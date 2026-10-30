#!/usr/bin/env python3
"""Horodatage mot à mot d'une voix off dont on connaît le texte (fichier audio fourni).

  python3 outils/aligner.py <voix.mp3> <texte.txt> <sortie.transcript.json> [--langue fr]

1. Whisper (modèle multilingue `small`) avec le texte en invite + horodatage DTW par jeton :
   les mots retrouvés sont ceux du script.
2. Recalage sur les vrais silences de la voix (ffmpeg silencedetect) : chaque mot qui suit
   une pause démarre exactement à la reprise de la parole ; les autres suivent le DTW.
Sortie au format de `hyperframes transcribe` / ElevenLabs : [{text, start, end}].
"""
import argparse, difflib, json, os, re, statistics, subprocess, sys, tempfile, unicodedata

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WHISPER = os.path.join(RACINE, "outils", "bin", "whisper-cli")
MODELE = os.path.expanduser("~/.cache/hyperframes/whisper/models/ggml-small.bin")

ap = argparse.ArgumentParser()
ap.add_argument("audio")
ap.add_argument("texte")
ap.add_argument("sortie")
ap.add_argument("--langue", default="fr")
a = ap.parse_args()

texte = open(a.texte, encoding="utf-8").read()
script = texte.split()

with tempfile.TemporaryDirectory() as tmp:
    wav = os.path.join(tmp, "v.wav")
    subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", a.audio, "-ar", "16000", "-ac", "1", wav], check=True)
    def whisper(invite):
        cmd = [WHISPER, "-m", MODELE, "-l", a.langue, "-f", wav, "-dtw", "small", "-nfa", "-ojf",
               "-of", os.path.join(tmp, "w"), "-t", "8"] + (["--prompt", " ".join(script)] if invite else [])
        subprocess.run(cmd, check=True, capture_output=True)
        return json.load(open(os.path.join(tmp, "w.json")))
    essais = [whisper(True)]
    sil = subprocess.run(["ffmpeg", "-nostats", "-i", a.audio, "-af", "silencedetect=n=-42dB:d=0.12",
                          "-f", "null", "-"], capture_output=True, text=True).stderr
    duree = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0",
                                  a.audio], capture_output=True, text=True).stdout)

UNITES = "zéro un deux trois quatre cinq six sept huit neuf dix onze douze treize quatorze quinze seize".split()
DIZAINES = {2: "vingt", 3: "trente", 4: "quarante", 5: "cinquante", 6: "soixante"}


def en_lettres(n):
    if n < 17:
        return UNITES[n]
    if n < 20:
        return "dix-" + UNITES[n - 10]
    if n < 70:
        d, u = divmod(n, 10)
        return DIZAINES[d] + ("" if u == 0 else "-et-un" if u == 1 else "-" + UNITES[u])
    return str(n)


def canon(t):
    """Forme de comparaison : minuscules, sans accents ni ponctuation, nombres en lettres, sans « s » final."""
    t = unicodedata.normalize("NFD", t.lower().replace("’", "'"))
    t = "".join(c for c in t if unicodedata.category(c) != "Mn")
    t = re.sub(r"[^a-z0-9\-']", "", t)
    if t.isdigit() and int(t) < 70:
        t = unicodedata.normalize("NFD", en_lettres(int(t)))
        t = "".join(c for c in t if unicodedata.category(c) != "Mn")
    return t[:-1] if len(t) > 3 and t.endswith("s") else t


def mots_de(d):
    mots = []
    for seg in d["transcription"]:
        for tk in seg.get("tokens", []):
            t = tk["text"]
            if t.startswith("[_") or t.startswith("<|"):
                continue
            if t.startswith(" ") or not mots:
                mots.append({"text": t.strip(), "dtw": tk.get("t_dtw", -1) / 100.0})
            else:
                mots[-1]["text"] += t
    return [m for m in mots if m["text"]]


def couverture(mots):
    sm = difflib.SequenceMatcher(None, [canon(w) for w in script], [canon(m["text"]) for m in mots], autojunk=False)
    return sum(b.size for b in sm.get_matching_blocks()) / len(script)


# l'invite (texte du script) aide souvent Whisper, mais peut aussi le faire décrocher : on garde
# la transcription qui retrouve le plus de mots du script
mots = mots_de(essais[0])
if couverture(mots) < 0.9 or any(m["dtw"] < 0 for m in mots):
    with tempfile.TemporaryDirectory() as tmp2:
        wav2 = os.path.join(tmp2, "v.wav")
        subprocess.run(["ffmpeg", "-v", "error", "-y", "-i", a.audio, "-ar", "16000", "-ac", "1", wav2], check=True)
        subprocess.run([WHISPER, "-m", MODELE, "-l", a.langue, "-f", wav2, "-dtw", "small", "-nfa", "-ojf",
                        "-of", os.path.join(tmp2, "w"), "-t", "8"], check=True, capture_output=True)
        autre = mots_de(json.load(open(os.path.join(tmp2, "w.json"))))
    if couverture(autre) > couverture(mots):
        mots = autre
taux = couverture(mots)
if taux < 0.8:
    sys.exit(f"La voix ne correspond qu'à {taux:.0%} du texte : vérifier qu'elle lit bien le script fourni.")

# instant DTW de chaque mot du script (mots non reconnus : interpolés entre leurs voisins)
dtw = [None] * len(script)
sm = difflib.SequenceMatcher(None, [canon(w) for w in script], [canon(m["text"]) for m in mots], autojunk=False)
for bl in sm.get_matching_blocks():
    for i in range(bl.size):
        if mots[bl.b + i]["dtw"] >= 0:
            dtw[bl.a + i] = mots[bl.b + i]["dtw"]
connus = [i for i, x in enumerate(dtw) if x is not None]
for i in range(len(dtw)):
    if dtw[i] is None:
        av = max((j for j in connus if j < i), default=None)
        ap = min((j for j in connus if j > i), default=None)
        if av is not None and ap is not None:
            dtw[i] = dtw[av] + (dtw[ap] - dtw[av]) * (i - av) / (ap - av)
        else:
            dtw[i] = dtw[av] + 0.3 * (i - av) if av is not None else max(0.0, dtw[ap] - 0.3 * (ap - i))
mots = [{"text": w, "dtw": dtw[i]} for i, w in enumerate(script)]

# silences → reprises de parole
bornes = [float(x) for x in re.findall(r"silence_(?:start|end): ([0-9.]+)", sil)]
silences = list(zip(bornes[0::2], bornes[1::2] + [duree] * (len(bornes[0::2]) - len(bornes[1::2]))))
reprises = [0.0] + [f for _, f in silences if f < duree - 0.1]

# retard moyen du DTW, mesuré sur les mots qui suivent une ponctuation
apres_pause = [0] + [i for i in range(1, len(script)) if script[i - 1][-1] in ",.?!:;…"]
ecarts = []
for i in apres_pause:
    r = min(reprises, key=lambda x: abs(mots[i]["dtw"] - x))
    if 0 <= mots[i]["dtw"] - r <= 0.7:
        ecarts.append(mots[i]["dtw"] - r)
retard = statistics.median(ecarts) if ecarts else 0.2
debut = [max(0.0, m["dtw"] - retard) for m in mots]

# recalage : mot après pause → reprise de parole la plus proche (±0,35 s)
ancres = {}
for i in apres_pause:
    r = min(reprises, key=lambda x: abs(debut[i] - x))
    if abs(debut[i] - r) <= 0.35 and r not in ancres.values():
        ancres[i] = r
indices = sorted(ancres)
for n, i in enumerate(indices):
    fin_groupe = indices[n + 1] if n + 1 < len(indices) else len(mots)
    decal = ancres[i] - debut[i]
    for k in range(i, fin_groupe):
        debut[k] += decal
    # le groupe doit tenir avant le silence qui suit sa reprise
    fin_parole = next((s for s, _ in silences if s > ancres[i] + 0.05), duree)
    dernier = fin_groupe - 1
    if dernier > i and debut[dernier] + 0.15 > fin_parole:
        echelle = (fin_parole - 0.15 - ancres[i]) / max(0.01, debut[dernier] - ancres[i])
        for k in range(i + 1, fin_groupe):
            debut[k] = ancres[i] + (debut[k] - ancres[i]) * echelle

# aucun mot ne démarre dans un silence ; ordre strictement croissant
for k in range(len(debut)):
    for s, f in silences:
        if s < debut[k] < f:
            debut[k] = f
    if k and debut[k] <= debut[k - 1]:
        debut[k] = debut[k - 1] + 0.05

sortie = []
for k, w in enumerate(script):
    fin = debut[k + 1] if k + 1 < len(debut) else duree
    for s, f in silences:              # le mot s'arrête au début de la pause qui le suit
        if debut[k] < s < fin:
            fin = s
            break
    sortie.append({"text": w, "start": round(debut[k], 3), "end": round(max(fin, debut[k] + 0.08), 3)})
json.dump(sortie, open(a.sortie, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"{a.sortie} : {len(sortie)} mots ({taux:.0%} reconnus) · retard DTW corrigé {retard:.2f} s · {len(ancres)} reprises calées")
