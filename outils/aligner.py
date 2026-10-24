#!/usr/bin/env python3
"""Horodatage mot à mot d'une voix off dont on connaît le texte (fichier audio fourni).

  python3 outils/aligner.py <voix.mp3> <texte.txt> <sortie.transcript.json> [--langue fr]

1. Whisper (modèle multilingue `small`) avec le texte en invite + horodatage DTW par jeton :
   les mots retrouvés sont ceux du script.
2. Recalage sur les vrais silences de la voix (ffmpeg silencedetect) : chaque mot qui suit
   une pause démarre exactement à la reprise de la parole ; les autres suivent le DTW.
Sortie au format de `hyperframes transcribe` / ElevenLabs : [{text, start, end}].
"""
import argparse, json, os, re, statistics, subprocess, sys, tempfile

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
    subprocess.run([WHISPER, "-m", MODELE, "-l", a.langue, "-f", wav, "-dtw", "small", "-nfa", "-ojf",
                    "-of", os.path.join(tmp, "w"), "-t", "8", "--prompt", " ".join(script)],
                   check=True, capture_output=True)
    d = json.load(open(os.path.join(tmp, "w.json")))
    sil = subprocess.run(["ffmpeg", "-nostats", "-i", a.audio, "-af", "silencedetect=n=-42dB:d=0.12",
                          "-f", "null", "-"], capture_output=True, text=True).stderr
    duree = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0",
                                  a.audio], capture_output=True, text=True).stdout)

# mots Whisper + instant DTW du premier jeton de chaque mot
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
if len(mots) != len(script) or any(m["dtw"] < 0 for m in mots):
    sys.exit(f"Alignement incomplet ({len(mots)} mots Whisper pour {len(script)} dans le script) : "
             "vérifier que la voix lit bien le texte fourni.")

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
print(f"{a.sortie} : {len(sortie)} mots · retard DTW corrigé {retard:.2f} s · {len(ancres)} reprises calées")
