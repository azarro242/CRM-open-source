#!/usr/bin/env python3
"""Mixage du VSL : voix + musique en boucle (fondus enchaînés, effacée sous la voix) + bruitages.

  python3 mix.py renders/brut.mp4 sortie.mp4 [--sans-sous-titres renders/brut-sans.mp4 sortie-sans.mp4]

Cible : −14 LUFS intégré, crête vraie ≤ −1,5 dBTP (YouTube).
"""
import json, os, subprocess, sys, tempfile

ICI = os.path.dirname(os.path.abspath(__file__))
cfg = json.load(open(f"{ICI}/sfx.json"))
DUREE = cfg["duree"]
MUSIQUE = f"{ICI}/assets/musique/musique-client.mp3"
VOIX = f"{ICI}/voix.mp3"
# consigne client du 29/10 (2e version) : bruitages d'interface nettement audibles, la voix reste devant
ECARTS_SFX = {  # dB sous la sonie intégrée de la voix, pour le pic de chaque bruitage
    "click": 5, "click-soft": 5, "key-press": 5, "typing": 5, "pop": 5, "whoosh": 5, "whoosh-short": 5,
    "whoosh-cinematic": 6, "notification": 8, "ping": 8, "chime": 8, "sparkle": 8, "error": 8,
    "impact-bass-1": 10, "impact-bass-2": 10, "riser": 10,
}
ECART_DEFAUT = 8
GAIN_MUSIQUE = -18.0   # dB (musique ≈ 16 dB sous la voix, puis effacée quand la voix parle)

def run(cmd):
    subprocess.run(cmd, check=True)

def sonie(path, gain=0.0):
    """(sonie intégrée, sonie momentanée max) en LUFS, après un gain en dB."""
    r = subprocess.run(["ffmpeg", "-nostats", "-i", path, "-af", f"volume={gain}dB,apad=pad_dur=0.5,ebur128", "-f", "null", "-"],
                       capture_output=True, text=True).stderr
    import re
    m = [float(x) for x in re.findall(r" M:\s*(-?[\d.]+)", r)]
    i = float(re.findall(r"I:\s+(-?[\d.]+) LUFS", r)[-1])
    return i, max(m)

def gains_sfx():
    """Gain de chaque bruitage pour que son pic soit exactement ECARTS_SFX dB sous le niveau moyen de la voix."""
    voix_i = sonie(VOIX)[0]
    cache, out = {}, []
    for s in cfg["sfx"]:
        if s["f"] not in cache:
            cache[s["f"]] = sonie(f"{ICI}/assets/sfx/{s['f']}")[1]
        ecart = ECARTS_SFX.get(s["f"].rsplit(".", 1)[0], ECART_DEFAUT)
        out.append(round(voix_i - ecart - cache[s["f"]], 1))
    return out

def piste_audio(dest):
    with tempfile.TemporaryDirectory() as tmp:
        # 1) musique en boucle : copies enchaînées avec fondus de 2,5 s
        d_m = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", MUSIQUE],
                                   capture_output=True, text=True).stdout)
        n = int(DUREE // (d_m - 2.5)) + 2
        entrees, filtre = [], ""
        for i in range(n):
            entrees += ["-i", MUSIQUE]
        prec = "[0:a]"
        for i in range(1, n):
            filtre += f"{prec}[{i}:a]acrossfade=d=2.5:c1=tri:c2=tri[m{i}];"
            prec = f"[m{i}]"
        filtre += f"{prec}atrim=0:{DUREE},afade=t=in:d=1.5,afade=t=out:st={DUREE - 3.5}:d=3.5,volume={GAIN_MUSIQUE}dB[mus]"
        boucle = f"{tmp}/musique.wav"
        run(["ffmpeg", "-v", "error", "-y", *entrees, "-filter_complex", filtre, "-map", "[mus]", "-ar", "48000", "-ac", "2", boucle])

        # 2) bruitages placés
        sfx_in, sfx_f, labels = [], "", []
        gains = gains_sfx()
        for k, s in enumerate(cfg["sfx"]):
            sfx_in += ["-i", f"{ICI}/assets/sfx/{s['f']}"]
            ms = int(round(s["t"] * 1000))
            sfx_f += f"[{k + 2}:a]aformat=sample_rates=48000:channel_layouts=stereo,volume={gains[k]}dB,adelay={ms}|{ms}[s{k}];"
            labels.append(f"[s{k}]")
        # 3) voix (légère compression), effacement de la musique sous la voix, somme, normalisation
        f = (f"[0:a]aformat=sample_rates=48000:channel_layouts=stereo,apad=whole_dur={DUREE},"
             f"acompressor=threshold=-20dB:ratio=2.5:attack=8:release=120:makeup=2[v];"
             f"[v]asplit=2[v1][vsc];"
             f"[1:a]aformat=sample_rates=48000:channel_layouts=stereo[m];"
             f"[m][vsc]sidechaincompress=threshold=0.03:ratio=6:attack=40:release=600[md];"
             + sfx_f +
             f"[v1][md]{''.join(labels)}amix=inputs={2 + len(labels)}:normalize=0:duration=first,"
             f"atrim=0:{DUREE},loudnorm=I=-14:TP=-1.5:LRA=9[out]")
        run(["ffmpeg", "-v", "error", "-y", "-i", VOIX, "-i", boucle, *sfx_in, "-filter_complex", f,
             "-map", "[out]", "-ar", "48000", "-c:a", "pcm_s16le", dest])

def assembler(video, audio, sortie):
    run(["ffmpeg", "-v", "error", "-y", "-i", video, "-i", audio, "-map", "0:v", "-map", "1:a", "-c:v", "copy",
         "-c:a", "aac", "-b:a", "192k", "-movflags", "+faststart", "-shortest", sortie])

if __name__ == "__main__":
    os.makedirs(f"{ICI}/renders", exist_ok=True)
    audio = f"{ICI}/renders/mix.wav"
    piste_audio(audio)
    r = subprocess.run(["ffmpeg", "-nostats", "-i", audio, "-af", "ebur128=peak=true", "-f", "null", "-"],
                       capture_output=True, text=True).stderr
    print("\n".join(l for l in r.splitlines()[-12:] if "I:" in l or "Peak:" in l or "LRA:" in l))
    args = sys.argv[1:]
    while len(args) >= 2:
        assembler(args[0], audio, args[1]); print("→", args[1]); args = args[2:]
