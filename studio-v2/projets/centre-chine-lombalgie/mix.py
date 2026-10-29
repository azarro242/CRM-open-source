#!/usr/bin/env python3
"""Mixage du format « médecin + anatomie » : la voix d'origine du médecin reste la piste principale.

  python3 mix.py renders/brut.mp4 <sortie.mp4> [--rapport rapport.png] [--limite 0.72]

Lit mix.json (écrit par build.py) :
  - voix  : piste audio de la vidéo source, passe-haut 80 Hz, compression douce, −16 LUFS ;
  - sfx   : chaque bruitage à son gain (déjà égalisé par build.py), −2 dB pendant la parole ;
  - master: −14 LUFS intégrés, crête vraie ≤ −1,5 dBTP (Instagram / TikTok).
Pas de musique : le médecin parle presque sans pause ; elle peut s'ajouter sur demande.
"""
import argparse, json, os, re, subprocess, tempfile
import numpy as np

SR = 48000
ICI = os.path.dirname(os.path.abspath(__file__))
ap = argparse.ArgumentParser()
ap.add_argument("video")
ap.add_argument("sortie")
ap.add_argument("--rapport")
ap.add_argument("--limite", type=float, default=0.72)
a = ap.parse_args()
mix = json.load(open(os.path.join(ICI, "mix.json"), encoding="utf-8"))
DUREE, N, parole = mix["duree"], int(mix["duree"] * SR), mix["parole"]


def decode(chemin, debut=0.0, duree=None, filtres=None):
    cmd = ["ffmpeg", "-v", "error", "-ss", f"{debut}"] + (["-t", f"{duree}"] if duree else []) + ["-i", chemin]
    cmd += (["-af", filtres] if filtres else []) + ["-vn", "-f", "f32le", "-ac", "2", "-ar", str(SR), "-"]
    return np.frombuffer(subprocess.run(cmd, capture_output=True, check=True).stdout, np.float32).reshape(-1, 2).copy()


def ecrire(x, chemin):
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-f", "f32le", "-ac", "2", "-ar", str(SR), "-i", "-",
                    "-c:a", "pcm_f32le", chemin], input=x.astype(np.float32).tobytes(), check=True)


def sonie(chemin):
    err = subprocess.run(["ffmpeg", "-nostats", "-i", chemin, "-af", "ebur128", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    courbe = [(float(t), float(m)) for t, m in re.findall(r"t:\s*([0-9.]+)\s+TARGET.*?M:\s*(-?[0-9.]+|-inf)", err)
              if m != "-inf"]
    integ = re.findall(r"I:\s*(-?[0-9.]+) LUFS", err)
    return (float(integ[-1]) if integ else -70.0), courbe


def fondu(x, ms):
    n = min(len(x) // 2, int(SR * ms / 1000))
    if n > 0:
        r = np.linspace(0, 1, n, dtype=np.float32)[:, None]
        x[:n] *= r
        x[-n:] *= r[::-1]
    return x


def poser(piste, x, t):
    i = int(round(t * SR))
    j = min(len(piste), i + len(x))
    if i < j:
        piste[i:j] += x[: j - i]


db = lambda g: 10 ** (g / 20)

with tempfile.TemporaryDirectory() as tmp:
    voix = np.zeros((N, 2), np.float32)
    v = decode(os.path.join(ICI, mix["voix"]), 0, mix["fin_voix"],
               "highpass=f=80,acompressor=threshold=0.125:ratio=2.5:attack=8:release=150:makeup=1.6")
    poser(voix, fondu(v, 40), 0.0)
    ecrire(voix, f"{tmp}/v.wav")
    voix *= db(-16.0 - sonie(f"{tmp}/v.wav")[0])

    sfx = np.zeros((N, 2), np.float32)
    for e in mix["sfx"]:
        x = decode(os.path.join(ICI, e["fichier"]), e["decalage"], e["duree"])
        poser(sfx, fondu(x * db(e["gain_db"]), 8), e["t"])
    t = np.arange(N) / SR
    g = np.ones(N, np.float32)
    for a_, z in parole:
        g[(t >= a_ - 0.1) & (t <= z + 0.15)] = db(-2.0)
    sfx *= g[:, None]

    somme = voix + sfx
    ecrire(somme, f"{tmp}/somme.wav")
    err = subprocess.run(["ffmpeg", "-nostats", "-i", f"{tmp}/somme.wav", "-af",
                          "loudnorm=I=-14:TP=-1.5:LRA=9:print_format=json", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    m = json.loads(err[err.rindex("{"): err.rindex("}") + 1])
    filtre = ("loudnorm=I=-14:TP=-1.5:LRA=9:measured_I={input_i}:measured_TP={input_tp}:measured_LRA={input_lra}:"
              "measured_thresh={input_thresh}:offset={target_offset}:linear=true,aresample=192000,"
              "alimiter=limit={limite}:level=false:attack=1:release=50,aresample=48000").format(**m, limite=a.limite)
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", a.video, "-i", f"{tmp}/somme.wav", "-map", "0:v", "-map", "1:a",
                    "-c:v", "copy", "-af", filtre, "-c:a", "aac", "-b:a", "192k", "-t", f"{DUREE}",
                    "-movflags", "+faststart", a.sortie], check=True)

    gain = db(-14.0 - float(m["input_i"]))
    i_fin, courbe_fin = sonie(a.sortie)
    tp = re.findall(r"Peak:\s*(-?[0-9.]+)", subprocess.run(
        ["ffmpeg", "-nostats", "-i", a.sortie, "-af", "ebur128=peak=true", "-f", "null", "-"],
        capture_output=True, text=True).stderr)
    print(f"Master : {i_fin:.1f} LUFS intégrés · crête vraie {tp[-1] if tp else '?'} dBTP · {a.sortie}")
    courbes = {}
    for nom, x in (("voix", voix), ("sfx", sfx)):
        ecrire(x * gain, f"{tmp}/{nom}.wav")
        courbes[nom] = sonie(f"{tmp}/{nom}.wav")[1]
    vm = [y for _, y in courbes["voix"] if y > -40]
    sm = [y for _, y in courbes["sfx"]]
    if vm and sm:
        print(f"Voix (90e centile) {np.percentile(vm, 90):.1f} LUFS · bruitage le plus fort {max(sm):.1f} LUFS momentanés")

    if a.rapport:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        fig, ax = plt.subplots(figsize=(13, 4.6), dpi=130)
        for a_, z in parole:
            ax.axvspan(a_, z, color="#d5efe9", alpha=0.6, lw=0)
        for nom, coul, lib in (("voix", "#02a5a9", "Voix du médecin"), ("sfx", "#e5484d", "Bruitages")):
            if courbes[nom]:
                t_, v_ = zip(*courbes[nom])
                ax.plot(t_, v_, color=coul, lw=1.5 if nom == "voix" else 1.1, label=lib)
        if courbe_fin:
            t_, v_ = zip(*courbe_fin)
            ax.plot(t_, v_, color="#1d1d1d", lw=0.9, alpha=0.55, label="Mixage final")
        ax.axhline(-14, color="#1d1d1d", ls="--", lw=0.8)
        ax.text(0.2, -13.3, "cible −14 LUFS", fontsize=8)
        ax.set_ylim(-50, -4)
        ax.set_xlim(0, DUREE)
        ax.set_xlabel("secondes")
        ax.set_ylabel("sonie momentanée (LUFS)")
        ax.set_title("Équilibre sonore — zones vertes : le médecin parle")
        ax.legend(loc="lower right", ncol=3, fontsize=8, frameon=False)
        ax.grid(alpha=0.25)
        fig.tight_layout()
        fig.savefig(a.rapport)
        print(f"Rapport : {a.rapport}")
