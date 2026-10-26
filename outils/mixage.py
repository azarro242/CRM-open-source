#!/usr/bin/env python3
"""Mixage final Studio V2 : voix + musique + bruitages, niveaux harmonisés.

  python3 outils/mixage.py <dossier_projet> <video_rendue.mp4> <sortie.mp4> [--rapport rapport.png]

Lit <projet>/mix.json (écrit par build.py) :
  - voix   : chaque phrase posée à son instant ; passe-haut, compression douce, niveau −16 LUFS ;
  - musique: niveau −16 LUFS, creusée de 3 dB vers 2,8 kHz (place pour la voix), puis
             enveloppe de « ducking » : basse sous la voix, remontée dans les respirations ;
  - sfx    : chaque bruitage ramené à la même crête de sonie, puis gain de sa catégorie,
             −2 dB supplémentaires quand la voix parle ;
  - master : −14 LUFS intégrés, crête vraie ≤ −1,5 dBTP (normes Instagram / TikTok).
Le rapport (PNG) trace la sonie momentanée de chaque piste dans le temps.
"""
import argparse, json, os, re, subprocess, sys, tempfile
import numpy as np

SR = 48000
CIBLE_VOIX = CIBLE_MUSIQUE = -16.0

ap = argparse.ArgumentParser()
ap.add_argument("projet")
ap.add_argument("video")
ap.add_argument("sortie")
ap.add_argument("--rapport")
ap.add_argument("--limite", type=float, default=0.79,
                help="plafond du limiteur (amplitude) ; baisser si la crête vraie dépasse −1,5 dBTP après encodage")
a = ap.parse_args()
P = os.path.abspath(a.projet)
mix = json.load(open(os.path.join(P, "mix.json"), encoding="utf-8"))
DUREE = mix["duree"]
N = int(DUREE * SR)


def decode(chemin, debut=0.0, duree=None, filtres=None):
    cmd = ["ffmpeg", "-v", "error", "-ss", f"{debut}"]
    if duree:
        cmd += ["-t", f"{duree}"]
    cmd += ["-i", chemin]
    if filtres:
        cmd += ["-af", filtres]
    cmd += ["-f", "f32le", "-ac", "2", "-ar", str(SR), "-"]
    brut = subprocess.run(cmd, capture_output=True, check=True).stdout
    return np.frombuffer(brut, dtype=np.float32).reshape(-1, 2).copy()


def ecrire(x, chemin):
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-f", "f32le", "-ac", "2", "-ar", str(SR), "-i", "-",
                    "-c:a", "pcm_f32le", chemin], input=x.astype(np.float32).tobytes(), check=True)


def sonie(chemin):
    """Sonie intégrée (LUFS) et courbe momentanée [(t, M)] via ffmpeg ebur128."""
    err = subprocess.run(["ffmpeg", "-nostats", "-i", chemin, "-af", "ebur128", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    courbe = [(float(t), float(m)) for t, m in re.findall(r"t:\s*([0-9.]+)\s+TARGET.*?M:\s*(-?[0-9.]+|-inf)", err)
              if m != "-inf"]
    integ = re.findall(r"I:\s*(-?[0-9.]+) LUFS", err)
    return (float(integ[-1]) if integ else -70.0), courbe


def fondu(x, ms=15):
    n = min(len(x) // 2, int(SR * ms / 1000))
    if n > 0:
        r = np.linspace(0, 1, n, dtype=np.float32)[:, None]
        x[:n] *= r
        x[-n:] *= r[::-1]
    return x


def poser(piste, x, t):
    i = int(round(t * SR))
    if i >= len(piste):
        return
    j = min(len(piste), i + len(x))
    piste[i:j] += x[: j - i]


def db(g):
    return 10 ** (g / 20)


parole = mix["parole"]


def masque_parole(n, plein_db, parole_db, rampe=0.12):
    """Gain par échantillon : plein_db hors voix, parole_db pendant la voix (rampes douces)."""
    t = np.arange(n) / SR
    g = np.full(n, plein_db, dtype=np.float32)
    for a_, z in parole:
        g = np.where((t >= a_) & (t <= z), parole_db, g)
        m = (t > a_ - rampe) & (t < a_)
        g[m] = np.minimum(g[m], plein_db + (parole_db - plein_db) * (t[m] - (a_ - rampe)) / rampe)
        m = (t > z) & (t < z + rampe * 1.6)
        g[m] = np.minimum(g[m], parole_db + (plein_db - parole_db) * (t[m] - z) / (rampe * 1.6))
    return (10 ** (g / 20)).astype(np.float32)


with tempfile.TemporaryDirectory() as tmp:
    pistes = {}
    # ---------------- voix
    voix = np.zeros((N, 2), dtype=np.float32)
    if mix["voix"]:
        brute = decode(os.path.join(P, mix["voix"]["fichier"]),
                       filtres="highpass=f=80,acompressor=threshold=0.125:ratio=2.5:attack=8:release=150:makeup=1.6")
        for sg in mix["voix"]["segments"]:
            x = brute[int(sg["src0"] * SR): int(sg["src1"] * SR)].copy()
            poser(voix, fondu(x), sg["debut"])
        ecrire(voix, f"{tmp}/v.wav")
        iv, _ = sonie(f"{tmp}/v.wav")
        voix *= db(CIBLE_VOIX - iv)
    pistes["voix"] = voix

    # ---------------- musique
    m = decode(os.path.join(P, mix["musique"]["fichier"]), filtres="equalizer=f=2800:t=q:w=1.2:g=-3")
    ecrire(m, f"{tmp}/m0.wav")
    im, _ = sonie(f"{tmp}/m0.wav")
    m *= db(CIBLE_MUSIQUE - im)
    musique = np.zeros((N, 2), dtype=np.float32)
    i0 = int(round(mix["musique"].get("debut", 0.0) * SR))   # la musique peut démarrer après la voix
    j0 = min(N, i0 + len(m))
    musique[i0:j0] = m[: j0 - i0]
    env = mix["musique"]["enveloppe"]
    tt = np.arange(N) / SR
    g_db = np.interp(tt, [e["t"] for e in env], [e["db"] for e in env])
    musique *= (10 ** (g_db / 20)).astype(np.float32)[:, None]
    pistes["musique"] = musique

    # ---------------- bruitages
    sfx = np.zeros((N, 2), dtype=np.float32)
    for e in mix["sfx"]:
        x = decode(os.path.join(P, e["fichier"]), e["decalage"], e["duree"])
        poser(sfx, fondu(x * db(e["gain_db"]), 8), e["t"])
    sfx *= masque_parole(N, 0.0, -2.0)[:, None]
    pistes["sfx"] = sfx

    # ---------------- somme + master
    somme = voix + musique + sfx
    ecrire(somme, f"{tmp}/somme.wav")
    err = subprocess.run(["ffmpeg", "-nostats", "-i", f"{tmp}/somme.wav", "-af",
                          "loudnorm=I=-14:TP=-1.5:LRA=9:print_format=json", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    mesure = json.loads(err[err.rindex("{"): err.rindex("}") + 1])
    filtre = ("loudnorm=I=-14:TP=-1.5:LRA=9:measured_I={input_i}:measured_TP={input_tp}:measured_LRA={input_lra}:"
              "measured_thresh={input_thresh}:offset={target_offset}:linear=true,aresample=192000,"
              "alimiter=limit={limite}:level=false:attack=1:release=50,aresample=48000").format(**mesure, limite=a.limite)
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", a.video, "-i", f"{tmp}/somme.wav", "-map", "0:v", "-map", "1:a",
                    "-c:v", "copy", "-af", filtre, "-c:a", "aac", "-b:a", "192k", "-t", f"{DUREE}",
                    "-movflags", "+faststart", a.sortie], check=True)

    # ---------------- contrôle
    gain_master = 10 ** ((-14.0 - float(mesure["input_i"])) / 20)
    i_fin, courbe_fin = sonie(a.sortie)
    tp = re.findall(r"Peak:\s*(-?[0-9.]+)", subprocess.run(
        ["ffmpeg", "-nostats", "-i", a.sortie, "-af", "ebur128=peak=true", "-f", "null", "-"],
        capture_output=True, text=True).stderr)
    courbes = {}
    for nom, x in pistes.items():
        ecrire(x * gain_master, f"{tmp}/{nom}.wav")
        courbes[nom] = sonie(f"{tmp}/{nom}.wav")[1]
    print(f"Master : {i_fin:.1f} LUFS intégrés · crête vraie {tp[-1] if tp else '?'} dBTP · {a.sortie}")

    def niveau(c, a_, z):
        v = [m_ for t, m_ in c if a_ <= t < z]
        return np.median(v) if v else None

    ecarts, pics = [], []
    for a_, z in parole:
        nv, nm = niveau(courbes["voix"], a_ + 0.2, z), niveau(courbes["musique"], a_ + 0.2, z)
        if nv is not None and nm is not None:
            ecarts.append(nv - nm)
    for e in mix["sfx"]:
        c = [m_ for t, m_ in courbes["sfx"] if e["t"] <= t < e["t"] + min(0.8, e["duree"]) + 0.4]
        if c:
            pics.append(max(c))
    voix_m = [m_ for t, m_ in courbes["voix"] if m_ > -40]
    print(f"Voix au-dessus de la musique pendant la parole : {np.median(ecarts):.1f} dB en médiane "
          f"(min {min(ecarts):.1f} dB)" if ecarts else "Pas de voix")
    if voix_m and pics:
        print(f"Bruitage le plus fort : {max(pics):.1f} LUFS momentanés · voix (90e centile) {np.percentile(voix_m, 90):.1f}")

    if a.rapport:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        fig, ax = plt.subplots(figsize=(13, 4.6), dpi=130)
        couleurs = {"voix": "#632bc5", "musique": "#d4a847", "sfx": "#e4572e"}
        noms = {"voix": "Voix", "musique": "Musique", "sfx": "Bruitages"}
        for a_, z in parole:
            ax.axvspan(a_, z, color="#e2d7f7", alpha=0.45, lw=0)
        for nom, c in courbes.items():
            if c:
                t_, v_ = zip(*c)
                ax.plot(t_, v_, color=couleurs[nom], lw=1.6 if nom == "voix" else 1.2, label=noms[nom])
        if courbe_fin:
            t_, v_ = zip(*courbe_fin)
            ax.plot(t_, v_, color="#1d1d1d", lw=0.9, alpha=0.55, label="Mixage final")
        ax.axhline(-14, color="#1d1d1d", ls="--", lw=0.8)
        ax.text(0.2, -13.3, "cible −14 LUFS", fontsize=8)
        ax.set_ylim(-50, -4)
        ax.set_xlim(0, DUREE)
        ax.set_xlabel("secondes")
        ax.set_ylabel("sonie momentanée (LUFS)")
        ax.set_title("Équilibre sonore — zones violettes : la voix parle, la musique s'efface dessous")
        ax.legend(loc="lower right", ncol=4, fontsize=8, frameon=False)
        ax.grid(alpha=0.25)
        fig.tight_layout()
        fig.savefig(a.rapport)
        print(f"Rapport : {a.rapport}")
