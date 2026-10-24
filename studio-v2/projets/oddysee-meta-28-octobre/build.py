#!/usr/bin/env python3
"""Monte index.html depuis gabarit.tpl + voix.txt + l'horodatage de la voix.

  python3 build.py                 # voix Oxley : voix.mp3 + voix.transcript.json (ElevenLabs)
  python3 build.py --estimation    # sans voix : rythme estimé, pour vérifier les images seulement

Toute la mise en scène (scènes, sous-titres, bruitages, aiguille du cadran) se cale sur les
mots de la voix : changer de voix = relancer ce script, rien à retoucher à la main.
"""
import difflib, html, json, os, re, subprocess, sys, unicodedata

ICI = os.path.dirname(os.path.abspath(__file__))
ESTIMATION = "--estimation" in sys.argv
DECALAGE = 0.08          # la voix démarre à 80 ms : le son est là dès la première image
TRAINE = 2.4             # signature de fin après le dernier mot
VIOLET_NUIT = 2          # index de la scène sur fond sombre (sous-titres en blanc)


def norm(t):
    t = unicodedata.normalize("NFD", t.lower())
    t = "".join(c for c in t if unicodedata.category(c) != "Mn")
    return re.sub(r"[^a-z0-9\-']", "", t)


# ---------------------------------------------------------------- texte et horodatage
lignes = [l.split() for l in open(f"{ICI}/voix.txt", encoding="utf-8").read().strip().splitlines() if l.strip()]
jetons = [(k, w) for k, l in enumerate(lignes) for w in l]

if ESTIMATION:
    # débit estimé de la voix Oxley (~2,4 mots/s) + pauses de ponctuation — aucun audio
    mots, t = [], 0.0
    for _, w in jetons:
        d = 0.11 + 0.047 * len(norm(w))
        mots.append({"text": w, "start": round(t, 3), "end": round(t + d, 3)})
        t += d + (0.32 if w[-1] in ".?…" else 0.12 if w[-1] in ",:" else 0.03)
else:
    chemin = f"{ICI}/voix.transcript.json"
    if not os.path.exists(chemin) or not os.path.exists(f"{ICI}/voix.mp3"):
        sys.exit("voix.mp3 / voix.transcript.json absents : générer la voix Oxley d'abord "
                 "(outils/elevenlabs.py generer), ou lancer --estimation pour un contrôle visuel.")
    mots = json.load(open(chemin, encoding="utf-8"))

# alignement jetons du script ↔ mots horodatés (identiques avec ElevenLabs, tolérant sinon)
a, b = [norm(w) for _, w in jetons], [norm(m["text"]) for m in mots]
temps = [None] * len(jetons)
for bloc in difflib.SequenceMatcher(None, a, b, autojunk=False).get_matching_blocks():
    for i in range(bloc.size):
        m = mots[bloc.b + i]
        temps[bloc.a + i] = [m["start"], m["end"]]
for i in range(len(temps)):            # interpolation des rares mots non retrouvés
    if temps[i] is None:
        av = next((temps[j][1] for j in range(i - 1, -1, -1) if temps[j]), 0.0)
        ap = next((temps[j][0] for j in range(i + 1, len(temps)) if temps[j]), av + 0.4)
        temps[i] = [av, max(av + 0.1, ap)]
temps = [[round(s + DECALAGE, 3), round(e + DECALAGE, 3)] for s, e in temps]


def mot(ligne, debut_du_mot):
    """Index du premier jeton de la ligne dont la forme normalisée commence par …"""
    for i, (k, w) in enumerate(jetons):
        if k == ligne and norm(w).startswith(debut_du_mot):
            return i
    raise SystemExit(f"Mot introuvable ligne {ligne + 1} : {debut_du_mot}")


def t(ligne, debut_du_mot):
    return temps[mot(ligne, debut_du_mot)][0]


debuts_lignes = [temps[next(i for i, (k, _) in enumerate(jetons) if k == n)][0] for n in range(len(lignes))]
fin_voix = temps[-1][1]
DUREE = round(fin_voix + TRAINE, 2)

C = {
    "faux": t(0, "faux"), "vendredi": t(1, "vendredi"), "repousse": t(1, "repousse"),
    "vingtNov": t(1, "vingt"), "mercredi": t(2, "mercredi"), "vingtHuit": t(2, "vingt-huit"),
    "bouge": t(2, "bouge"), "clic": t(3, "clic"), "ouvrir": t(3, "ouvrir"),
    "instagram": t(3, "instagram"), "auLieu": t(3, "lieu") - 0.15, "site": t(3, "site"),
    "coupe": t(4, "coupe"), "teste": t(4, "teste"), "envoie": t(5, "envoie"), "gere": t(5, "gere"),
    "fin": fin_voix,
}

# scènes = lignes du script ; chevauchement de 0,4 s pour les transitions
AVANCE, RECOUVRE = 0.15, 0.4
scenes = []
for n in range(len(lignes)):
    debut = 0.0 if n == 0 else round(debuts_lignes[n] - AVANCE, 3)
    fin = DUREE if n == len(lignes) - 1 else round(debuts_lignes[n + 1] - AVANCE + RECOUVRE, 3)
    scenes.append({"debut": debut, "fin": fin})

# aiguille du cadran : un tic par demi-seconde entre « vingt-huit » et « bouge »
tics, x = [], C["vingtHuit"]
while x < C["bouge"] + 0.3:
    tics.append(round(x, 3))
    x += 0.5

# ---------------------------------------------------------------- sous-titres
AFFICHE = {"trente": "30", "vingt": "20", "vingt-huit,": "28,"}
FORTS = {"faux", "vingt", "novembre", "vingt-huit", "instagram", "site", "navigation", "produit", "envoie"}


def affiche(w):
    w = AFFICHE.get(w.lower(), w)
    return re.sub(r"([?:!;])$", " \\1", w)


def scene_de(t0):
    return max(n for n, s in enumerate(scenes) if s["debut"] <= t0 + 1e-6)


groupes, cour = [], []
for i, (k, w) in enumerate(jetons):
    cour.append(i)
    texte = " ".join(affiche(jetons[j][1]) for j in cour)
    dernier = i == len(jetons) - 1 or jetons[i + 1][0] != k
    if dernier or w[-1] in ".?:…" or (w[-1] == "," and len(cour) >= 2) or len(cour) >= 3 or len(texte) >= 15:
        groupes.append(cour)
        cour = []

sous, html_st = [], []
for n, g in enumerate(groupes):
    debut = temps[g[0]][0] - 0.04
    suivant = temps[groupes[n + 1][0]][0] - 0.04 if n + 1 < len(groupes) else None
    fin = suivant if (suivant is not None and suivant - temps[g[-1]][1] < 0.7) else temps[g[-1]][1] + 0.3
    entree = {"debut": round(debut, 3), "fin": round(fin, 3), "mots": []}
    spans = []
    for j, i in enumerate(g):
        base = "#ffffff" if scene_de(temps[i][0]) == VIOLET_NUIT else "#1d1d1d"
        m_fin = temps[g[j + 1]][0] if j + 1 < len(g) else fin
        entree["mots"].append({"i": i, "debut": temps[i][0], "fin": round(m_fin, 3), "base": base,
                               "fort": norm(jetons[i][1]) in FORTS})
        spans.append(f'<span class="m" id="m-{i}">{html.escape(affiche(jetons[i][1]))}</span>')
    sous.append(entree)
    html_st.append(f'          <div class="st" id="st-{n}">{"".join(spans)}</div>')

# ---------------------------------------------------------------- bruitages
S = scenes
SFX = [  # (instant, fichier, volume, [début dans le fichier, durée])
    (0.0, "impact-bass-2", 0.45), (0.02, "whoosh-short", 0.5),
    (C["faux"] - 0.02, "impact-bass-1", 0.75), (C["faux"] + 0.04, "glitch-2", 0.22, 0.0, 0.6),
    (S[1]["debut"], "whoosh", 0.6), (C["vendredi"] + 0.05, "pop", 0.45),
    (C["repousse"] + 0.2, "whoosh-short", 0.55), (C["vingtNov"], "click", 0.6), (C["vingtNov"] + 0.05, "ping", 0.3),
    (S[2]["debut"] - 1.1, "riser", 0.35, 8.8, 1.2), (S[2]["debut"] + 0.02, "impact-bass-2", 0.75),
    (C["bouge"] + 0.18, "click", 0.75),
    (S[3]["debut"], "whoosh-cinematic", 0.45, 0.0, 1.3), (C["clic"], "click-soft", 0.75),
    (C["ouvrir"], "whoosh-short", 0.5), (C["instagram"] - 0.05, "pop", 0.45), (C["auLieu"], "pop", 0.35),
    (C["site"], "error", 0.42), (C["site"] + 0.02, "impact-bass-1", 0.35),
    (S[4]["debut"], "whoosh", 0.55),
    (C["coupe"], "click", 0.8), (C["teste"] - 0.05, "pop", 0.4), (C["teste"] + 0.15, "pop", 0.4),
    (C["teste"] + 0.32, "click-soft", 0.5), (C["coupe"] + 0.6, "sparkle", 0.22, 0.0, 1.2),
    (S[5]["debut"], "whoosh-cinematic", 0.45, 0.0, 1.2), (C["envoie"] + 0.05, "whoosh-short", 0.6),
    (C["gere"], "notification", 0.35, 0.0, 1.4),
    (C["envoie"] + 0.7, "pop", 0.4), (C["gere"], "sparkle", 0.3, 0.0, 1.3),
    (C["fin"], "impact-bass-2", 0.4), (C["fin"] + 0.02, "chime", 0.45),
]
SFX += [(x, "key-press", 0.32) for x in tics]
SFX += [(S[4]["debut"] + 0.25 + i * 0.16, "key-press", 0.28) for i in (0, 2, 4)]

durees = {}
for f in os.listdir(f"{ICI}/assets/sfx"):
    if f.endswith(".mp3"):
        r = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0",
                            f"{ICI}/assets/sfx/{f}"], capture_output=True, text=True)
        durees[f[:-4]] = float(r.stdout.strip())

pistes, audio = [], []      # pistes : instant de fin de la dernière occupation, à partir de la piste 30
for n, e in enumerate(sorted(SFX, key=lambda e: e[0])):
    debut, nom, vol = max(0.0, e[0]), e[1], e[2]
    off = e[3] if len(e) > 3 else 0.0
    dur = e[4] if len(e) > 4 else durees[nom] - off
    dur = round(min(dur, DUREE - debut), 3)
    if dur <= 0.05:
        continue
    k = next((i for i, f in enumerate(pistes) if f <= debut - 0.01), None)
    if k is None:
        pistes.append(0)
        k = len(pistes) - 1
    pistes[k] = debut + dur
    media = f' data-media-start="{off}"' if off else ""
    audio.append(f'      <audio id="sfx-{n}" src="assets/sfx/{nom}.mp3" data-start="{debut:.3f}" '
                 f'data-duration="{dur}"{media} data-track-index="{30 + k}" data-volume="{vol}"></audio>')

# musique originale, recalculée si la durée change
musique = f"{ICI}/assets/musique/fond.wav"
info = f"{ICI}/assets/musique/fond.duree"
if not (os.path.exists(musique) and os.path.exists(info) and open(info).read().strip() == str(DUREE)):
    subprocess.run([sys.executable, f"{ICI}/outils/musique.py", str(DUREE), musique], check=True)
    open(info, "w").write(str(DUREE))
audio.insert(0, f'      <audio id="musique" src="assets/musique/fond.wav" data-start="0" data-duration="{DUREE}" '
                f'data-track-index="21" data-volume="0.2"></audio>')
if not ESTIMATION:
    duree_voix = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0",
                                       f"{ICI}/voix.mp3"], capture_output=True, text=True).stdout)
    audio.insert(0, f'      <audio id="voix" src="voix.mp3" data-start="{DECALAGE}" '
                    f'data-duration="{round(min(duree_voix, DUREE - DECALAGE), 3)}" data-track-index="20" data-volume="1"></audio>')

# ---------------------------------------------------------------- assemblage
ticks = "".join(f'<i class="tick" style="transform: rotate({k * 30}deg)"></i>' for k in range(12))
data = {"duree": DUREE, "c": {k: round(v, 3) for k, v in C.items()}, "scenes": scenes, "tics": tics, "sous": sous}
page = open(f"{ICI}/gabarit.tpl", encoding="utf-8").read()
for n, s in enumerate(scenes, 1):
    page = page.replace("{{S%d}}" % n, f'data-start="{s["debut"]}" data-duration="{round(s["fin"] - s["debut"], 3)}"')
page = (page.replace("{{DUREE}}", str(DUREE)).replace("{{TICKS}}", ticks)
            .replace("{{SOUS_TITRES}}", "\n".join(html_st)).replace("{{AUDIO}}", "\n".join(audio))
            .replace("{{DATA}}", json.dumps(data, ensure_ascii=False)))
assert "{{" not in page, re.findall(r"\{\{\w+\}\}", page)
open(f"{ICI}/index.html", "w", encoding="utf-8").write(page)
print(f"index.html : {DUREE} s · {len(scenes)} scènes · {len(sous)} sous-titres · {len(audio)} pistes audio"
      + (" · ESTIMATION (sans voix)" if ESTIMATION else " · voix Oxley"))
for n, s in enumerate(scenes, 1):
    print(f"  S{n} {s['debut']:6.2f} → {s['fin']:6.2f}   {' '.join(lignes[n - 1])}")
