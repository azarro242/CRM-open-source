#!/usr/bin/env python3
"""Horodatage mot à mot d'une voix longue (plusieurs minutes), par fenêtres courtes.

  python3 realigner.py voix.mp3 voix.txt voix.transcript.json

Sur une voix de plus de deux minutes, l'horodatage DTW de Whisper en une seule passe dérive
(fins de phrases placées jusqu'à 3 s trop tôt). Ici : découpe aux vraies pauses en fenêtres de
6 à 14 s, Whisper + DTW sur chaque fenêtre, raccord au script mot à mot, puis recalage des
reprises de parole sur les silences mesurés.
"""
import difflib, json, os, re, statistics, subprocess, sys, tempfile

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../outils"))
RACINE = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../.."))
WHISPER = os.path.join(RACINE, "outils", "bin", "whisper-cli")
MODELE = os.path.expanduser("~/.cache/hyperframes/whisper/models/ggml-small.bin")
import unicodedata

audio, texte, sortie = sys.argv[1:4]
script = open(texte, encoding="utf-8").read().split()

def canon(t):
    t = unicodedata.normalize("NFD", t.lower().replace("’", "'"))
    t = "".join(c for c in t if unicodedata.category(c) != "Mn")
    t = re.sub(r"[^a-z0-9\-']", "", t)
    return t[:-1] if len(t) > 3 and t.endswith("s") else t

duree = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", audio],
                             capture_output=True, text=True).stdout)
sil_txt = subprocess.run(["ffmpeg", "-nostats", "-i", audio, "-af", "silencedetect=n=-40dB:d=0.15", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
b = [float(x) for x in re.findall(r"silence_(?:start|end): ([0-9.]+)", sil_txt)]
silences = list(zip(b[0::2], b[1::2] + [duree] * (len(b[0::2]) - len(b[1::2]))))
coupes = [(a + f) / 2 for a, f in silences if f - a >= 0.18]

# fenêtres : on coupe à la pause la plus proche de 10 s après le début de la fenêtre
fen, debut = [], 0.0
while debut < duree - 0.5:
    cand = [c for c in coupes if 6 <= c - debut <= 14]
    fin = min(cand, key=lambda c: abs(c - debut - 10)) if cand else min(duree, debut + 12)
    fen.append((debut, fin)); debut = fin

mots = []
with tempfile.TemporaryDirectory() as tmp:
    for n, (a, f) in enumerate(fen):
        wav = os.path.join(tmp, f"f{n}.wav")
        subprocess.run(["ffmpeg", "-v", "error", "-y", "-ss", str(a), "-t", str(f - a), "-i", audio, "-ar", "16000", "-ac", "1", wav], check=True)
        subprocess.run([WHISPER, "-m", MODELE, "-l", "fr", "-f", wav, "-dtw", "small", "-nfa", "-ojf", "-of", os.path.join(tmp, f"w{n}"), "-t", "8"],
                       check=True, capture_output=True)
        d = json.load(open(os.path.join(tmp, f"w{n}.json")))
        for seg in d["transcription"]:
            for tk in seg.get("tokens", []):
                t = tk["text"]
                if t.startswith("[_") or t.startswith("<|"):
                    continue
                tt = a + tk.get("t_dtw", -1) / 100.0 if tk.get("t_dtw", -1) >= 0 else None
                if t.startswith(" ") or not mots or mots[-1].get("fen") != n:
                    mots.append({"text": t.strip(), "t": tt, "fen": n})
                else:
                    mots[-1]["text"] += t
mots = [m for m in mots if m["text"] and m["t"] is not None]

sm = difflib.SequenceMatcher(None, [canon(w) for w in script], [canon(m["text"]) for m in mots], autojunk=False)
t = [None] * len(script)
for bl in sm.get_matching_blocks():
    for i in range(bl.size):
        t[bl.a + i] = mots[bl.b + i]["t"]
reconnus = sum(x is not None for x in t) / len(script)
connus = [i for i, x in enumerate(t) if x is not None]
for i in range(len(t)):
    if t[i] is None:
        av = max((j for j in connus if j < i), default=None); ap = min((j for j in connus if j > i), default=None)
        if av is not None and ap is not None:
            t[i] = t[av] + (t[ap] - t[av]) * (i - av) / (ap - av)
        else:
            t[i] = t[av] + 0.3 * (i - av) if av is not None else max(0.0, t[ap] - 0.3 * (ap - i))
# ordre strictement croissant
for i in range(1, len(t)):
    t[i] = max(t[i], t[i - 1] + 0.05)

# retard DTW médian, mesuré sur les mots qui suivent une ponctuation
reprises = [0.0] + [f for _, f in silences if f < duree - 0.1]
apres = [0] + [i for i in range(1, len(script)) if script[i - 1][-1] in ",.?!:;…»"]
ecarts = []
for i in apres:
    r = min(reprises, key=lambda x: abs(t[i] - x))
    if 0 <= t[i] - r <= 0.7:
        ecarts.append(t[i] - r)
retard = statistics.median(ecarts) if ecarts else 0.2
deb = [max(0.0, x - retard) for x in t]
cales = 0
for i in apres:
    r = min(reprises, key=lambda x: abs(deb[i] - x))
    if abs(deb[i] - r) <= 0.35:
        deb[i] = r; cales += 1
for i in range(1, len(deb)):
    deb[i] = max(deb[i], deb[i - 1] + 0.04)
# fins : début du mot suivant, ou début du silence qui suit
debs_sil = [a for a, _ in silences]
fins = []
for i in range(len(deb)):
    nxt = deb[i + 1] if i + 1 < len(deb) else duree
    s = min((a for a in debs_sil if deb[i] < a < nxt), default=None)
    fins.append(round(s if s is not None else nxt - 0.02, 3))
json.dump([{"text": w, "start": round(deb[i], 3), "end": fins[i]} for i, w in enumerate(script)],
          open(sortie, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"{sortie} : {len(script)} mots, {len(fen)} fenêtres, {reconnus:.0%} reconnus, retard DTW {retard:.2f} s, {cales} reprises calées")
