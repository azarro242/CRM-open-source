#!/usr/bin/env python3
"""Série 60 · vidéo 39 « Des clics… mais aucun contact ? » — gabarit de la vidéo Meta v2.

  python3 build.py                 # voix fournie : voix.mp3 + voix.transcript.json (outils/aligner.py)
  python3 build.py --estimation    # sans voix : rythme estimé, pour contrôler les images seulement

1. Grille rythmique de la musique (temps détectés par librosa, mis en cache dans grille.json).
2. Chaque phrase de la voix devient un segment, posé sur un temps de la musique : les phrases
   « ancres » tombent sur les changements de section (FAUX sur l'entrée de la batterie, l'appel à
   commenter sur le retour du refrain…), les autres sur le premier temps libre.
3. Scènes, sous-titres, animations au tempo et bruitages se calent sur ce placement.
4. Écrit index.html (aperçu HyperFrames) et mix.json (mixage final : outils/mixage.py).
"""
import difflib, html, json, os, re, subprocess, sys, unicodedata

ICI = os.path.dirname(os.path.abspath(__file__))
ESTIMATION = "--estimation" in sys.argv
MUSIQUE = "assets/musique/musique-client.mp3"
NUIT = 2                    # scène sur fond sombre (sous-titres en blanc)
PAUSE_MAX = 0.45            # au-delà, une pause interne à la phrase est raccourcie…
PAUSE_MAX_SUSP = 0.55       # … (après « … » : un peu plus de suspense)
PAUSE_COURTE = 0.30         # … à cette durée
ECART = 0.20                # silence minimal entre deux phrases (0,28 ailleurs : texte dense avant la partie B)
FIN_TENUE = 1.6             # tenue de la signature après le dernier mot

# phrase → instant visé dans la musique (calés au temps le plus proche) — cf. ANALYSE-MUSIQUE.md
ANCRES = {0: 0.10, 1: 3.065, 4: 10.89, 5: 17.369, 6: 23.336}
# phrase → scène
SCENE_DE_LIGNE = [0, 0, 1, 1, 2, 3, 4, 5]
# sections calmes de la musique (pas de pulsation visuelle)
CALMES = [(17.30, 23.30)]


def norm(t):
    t = unicodedata.normalize("NFD", t.lower())
    t = "".join(c for c in t if unicodedata.category(c) != "Mn")
    return re.sub(r"[^a-z0-9\-']", "", t.replace("’", "'"))


def sonde(chemin):
    r = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", chemin],
                       capture_output=True, text=True)
    return float(r.stdout.strip())


# ---------------------------------------------------------------- grille rythmique
grille_f = f"{ICI}/assets/musique/grille.json"
if not os.path.exists(grille_f):
    import librosa, numpy as np
    y, sr = librosa.load(f"{ICI}/{MUSIQUE}", sr=22050, mono=True)
    oe = librosa.onset.onset_strength(y=y, sr=sr)
    _, b = librosa.beat.beat_track(onset_envelope=oe, sr=sr, units="time", tightness=100)
    b = [float(x) for x in b]
    per = (b[-1] - b[0]) / (len(b) - 1)
    fin = len(y) / sr
    while b[-1] + per < fin - 0.3:          # prolonge la grille jusqu'à la fin du morceau
        b.append(b[-1] + per)
    json.dump({"temps": [round(x, 3) for x in b], "periode": round(per, 4), "duree": round(fin, 3)},
              open(grille_f, "w"), indent=1)
G = json.load(open(grille_f))
TEMPS, PERIODE, FIN_MUSIQUE = G["temps"], G["periode"], G["duree"]


def temps_proche(x):
    return min(TEMPS, key=lambda b: abs(b - x))


def temps_suivant(x):
    return next((b for b in TEMPS if b >= x - 1e-3), x)


# ---------------------------------------------------------------- texte et horodatage
lignes = [l.split() for l in open(f"{ICI}/voix.txt", encoding="utf-8").read().strip().splitlines() if l.strip()]
jetons = [(k, w) for k, l in enumerate(lignes) for w in l]

if ESTIMATION:
    # aucun audio : rythme estimé
    mots, t = [], 0.0
    for i, (k, w) in enumerate(jetons):
        # calibré sur la voix Oxley v1 : pas = 0,138 s + 0,041 s par lettre ; « … » ≈ 0,65 s
        n = len(norm(w))
        mots.append({"text": w, "start": round(t, 3), "end": round(t + 0.10 + 0.04 * n, 3)})
        fin_ligne = i + 1 < len(jetons) and jetons[i + 1][0] != k
        t += 0.138 + 0.041 * n + (0.7 if fin_ligne else 0.65 if w[-1] == "…" else 0.12 if w[-1] in ",:" else 0)
    VOIX = None
else:
    if not (os.path.exists(f"{ICI}/voix.mp3") and os.path.exists(f"{ICI}/voix.transcript.json")):
        sys.exit("voix.mp3 / voix.transcript.json absents : déposer la voix puis lancer "
                 "python3 ../../../outils/aligner.py voix.mp3 voix.txt voix.transcript.json")
    mots = json.load(open(f"{ICI}/voix.transcript.json", encoding="utf-8"))
    VOIX = sonde(f"{ICI}/voix.mp3")

a_, b_ = [norm(w) for _, w in jetons], [norm(m["text"]) for m in mots]
src = [None] * len(jetons)
for bl in difflib.SequenceMatcher(None, a_, b_, autojunk=False).get_matching_blocks():
    for i in range(bl.size):
        m = mots[bl.b + i]
        src[bl.a + i] = [m["start"], m["end"]]
for i in range(len(src)):
    if src[i] is None:
        av = next((src[j][1] for j in range(i - 1, -1, -1) if src[j]), 0.0)
        ap = next((src[j][0] for j in range(i + 1, len(src)) if src[j]), av + 0.4)
        src[i] = [av, max(av + 0.1, ap)]

# ---------------------------------------------------------------- placement des phrases sur la grille
def morceaux(k):
    """Découpe la phrase k aux longues pauses : [(src0, src1, [indices des mots])]."""
    idx = [i for i, (kk, _) in enumerate(jetons) if kk == k]
    res, cour = [], [idx[0]]
    for a, b in zip(idx, idx[1:]):
        trou = src[b][0] - src[a][1]
        if trou > (PAUSE_MAX_SUSP if jetons[a][1].endswith("…") else PAUSE_MAX):
            res.append(cour)
            cour = []
        cour.append(b)
    res.append(cour)
    out = []
    for n, m in enumerate(res):
        s0 = max(0.0, src[m[0]][0] - 0.05)
        s1 = src[m[-1]][1] + (0.12 if n == len(res) - 1 else 0.06)
        if VOIX:
            s1 = min(s1, VOIX)
        out.append((s0, s1, m))
    return out


def placer(retard):
    """Pose chaque phrase sur un temps ; la musique démarre `retard` s après la vidéo."""
    grille = [x + retard for x in TEMPS]
    # les phrases sans ancre peuvent partir sur un demi-temps (texte dense avant la partie B)
    demi = sorted(grille + [g + PERIODE / 2 for g in grille])
    proche = lambda x: min(grille, key=lambda g: abs(g - x))
    suivant = lambda x: next((g for g in grille if g >= x - 1e-3), x)
    suivant_demi = lambda x: next((g for g in demi if g >= x - 1e-3), x)
    segs, fin_prec, derive = [], -1.0, 0.0
    for k, l in enumerate(lignes):
        mc = morceaux(k)
        if k in ANCRES:
            vise = ANCRES[k] if k == 0 else proche(ANCRES[k] + retard)
            cible = vise
            if cible < fin_prec + ECART:            # la phrase précédente déborde : temps suivant
                cible = suivant(fin_prec + ECART)
            derive += cible - vise
        else:
            cible = suivant_demi(fin_prec + ECART)
        # la syllabe d'attaque tombe sur le temps : la voix démarre 50 ms avant
        premier = mc[0][2][0]
        debut = max(0.0, cible - (src[premier][0] - mc[0][0])) if k else cible
        for n, (s0, s1, m) in enumerate(mc):
            segs.append({"ligne": k, "morceau": n, "mots": m, "src0": round(s0, 3), "src1": round(s1, 3),
                         "debut": round(debut, 3), "fin": round(debut + s1 - s0, 3), "temps": round(cible, 3)})
            debut = debut + s1 - s0 + PAUSE_COURTE
        fin_prec = segs[-1]["fin"]
    deborde = max(0.0, fin_prec - (FIN_MUSIQUE + retard) + 0.3)
    return segs, derive + 2 * deborde + 0.05 * retard


# la musique peut démarrer 0, 1 ou 2 temps après la voix : on garde le calage le plus juste
essais = [(placer(n * PERIODE), n * PERIODE) for n in range(3)]
(segments, cout), RETARD = min(essais, key=lambda e: e[0][1])
RETARD = round(RETARD, 3)
TEMPS = [round(x + RETARD, 3) for x in TEMPS]
CALMES = [(a + RETARD, z + RETARD) for a, z in CALMES]
FIN_MUSIQUE_V = FIN_MUSIQUE + RETARD

temps = [None] * len(jetons)
for sg in segments:
    for i in sg["mots"]:
        temps[i] = [round(sg["debut"] + src[i][0] - sg["src0"], 3), round(sg["debut"] + src[i][1] - sg["src0"], 3)]

fin_voix = segments[-1]["fin"]
DUREE = round(max(fin_voix + FIN_TENUE, FIN_MUSIQUE_V + 0.25), 2)


def mot(ligne, prefixe):
    for i, (k, w) in enumerate(jetons):
        if k == ligne and norm(w).startswith(prefixe):
            return i
    raise SystemExit(f"Mot introuvable ligne {ligne + 1} : {prefixe}")


def t(ligne, prefixe):
    return temps[mot(ligne, prefixe)][0]


C = {
    "des": t(0, "des"), "clics": t(0, "clics"), "aucun": t(0, "aucun"), "contact": t(0, "contact"),
    "ta1": t(1, "ta"), "pub1": t(1, "pub"), "promet": t(1, "promet"), "chose": t(1, "chose"),
    "page2": t(2, "page"), "montre": t(2, "montre"), "autre": t(2, "autre"),
    "retrouve": t(3, "retrouve"), "va": t(3, "va"),
    "page4": t(4, "page"), "repeter": t(4, "repeter"), "offre": t(4, "offre"), "image": t(4, "image"),
    "prix": t(4, "prix"), "meme1": t(4, "meme"),
    "seul": t(5, "seul"), "bouton": t(5, "bouton"), "visible": t(5, "visible"), "whatsapp": t(5, "whatsapp"),
    "reserver": t(5, "reserver"),
    "commente": t(6, "commente"), "audit": t(6, "audit"), "compare": t(6, "compare"), "page6": t(6, "page"),
    "abonne": t(7, "abonne"), "clics7": t(7, "clics"), "clients7": t(7, "clients"), "fin": fin_voix,
}

# scènes : chacune démarre 0,25 s avant sa première phrase (la transition finit sur le temps)
nb_scenes = max(SCENE_DE_LIGNE) + 1
scenes = []
for n in range(nb_scenes):
    premiere = next(s for s in segments if SCENE_DE_LIGNE[s["ligne"]] == n and s["morceau"] == 0)
    debut = 0.0 if n == 0 else round(premiere["debut"] - 0.25, 3)
    scenes.append({"debut": debut, "fin": None, "temps": premiere["temps"]})
for n in range(nb_scenes):
    scenes[n]["fin"] = DUREE if n == nb_scenes - 1 else round(scenes[n + 1]["debut"] + 0.45, 3)

# temps de la musique pour les animations au tempo (hors passages calmes et après la fin)
pulsations = [b for b in TEMPS if b < DUREE - 0.1 and not any(a <= b < z for a, z in CALMES)]
# le fil entre la pub et la page pulse au tempo (partie B)
tics = [b for b in TEMPS if C["page4"] - 0.05 <= b <= C["prix"] + 0.3]
# frappe de « AUDIT » : une lettre par demi-temps à partir de « Commente » (retour de la batterie)
_b = [b for b in TEMPS if b >= C["commente"] - 0.08][:3]
frappe = [_b[0], _b[0] + PERIODE / 2, _b[1], _b[1] + PERIODE / 2, _b[2]]
frappe = [round(x, 3) for x in frappe]
publier = next(b for b in TEMPS if b > frappe[-1] + 0.1)
carte = round(publier + 0.3, 3)          # la réponse arrive juste après la publication

# ---------------------------------------------------------------- sous-titres
AFFICHE = {}
FORTS = {"clics", "aucun", "contact", "pub", "promet", "chose", "page", "autre", "retrouve", "va", "repeter",
         "offre", "image", "prix", "seul", "bouton", "visible", "whatsapp", "reserver", "commente", "audit", "compare",
         "abonne-toi", "clients"}


def affiche(w, ligne):
    if ligne == 6 and norm(w) == "audit":
        return "« AUDIT »\u00a0:"
    w = AFFICHE.get(w.lower(), w)
    return re.sub(r"([?:!;])$", "\u00a0\\1", w)


def scene_de(t0):
    return max(n for n, s in enumerate(scenes) if s["debut"] <= t0 + 1e-6)


groupes, cour = [], []
for i, (k, w) in enumerate(jetons):
    cour.append(i)
    texte = " ".join(affiche(jetons[j][1], k) for j in cour)
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
        base = "#ffffff" if scene_de(temps[i][0]) == NUIT else "#1d1d1d"
        m_fin = temps[g[j + 1]][0] if j + 1 < len(g) else fin
        entree["mots"].append({"i": i, "debut": temps[i][0], "fin": round(m_fin, 3), "base": base,
                               "fort": norm(jetons[i][1]) in FORTS})
        spans.append(f'<span class="m" id="m-{i}">{html.escape(affiche(jetons[i][1], jetons[i][0]))}</span>')
    sous.append(entree)
    html_st.append(f'          <div class="st" id="st-{n}">{"".join(spans)}</div>')

# ---------------------------------------------------------------- bruitages (catégorie → niveau relatif)
S = scenes
avant = lambda x, d=0.22: x - d     # un « whoosh » culmine ~0,22 s après son départ
SFX = [  # (instant, fichier, catégorie, [début dans le fichier, durée])
    (C["clics"] - 0.03, "click", "ui"), (C["clics"] + 0.2, "click", "ui"), (C["contact"] - 0.02, "error", "accent", 0.0, 0.9),
    (C["ta1"] - 0.02, "impact-bass-1", "impact"), (C["ta1"] + 0.03, "glitch-2", "accent", 0.0, 0.45),
    (C["page2"] - 0.05, "whoosh-short", "transition"), (C["autre"] - 0.02, "glitch-1", "accent", 0.0, 0.4),
    (avant(S[1]["temps"]), "whoosh", "transition"),
    (C["retrouve"] - 0.03, "pop", "ui"), (C["va"] - 0.05, "whoosh-short", "transition"),
    (avant(S[2]["temps"], 0.3), "whoosh-cinematic", "transition", 0.0, 1.2),
    (S[2]["temps"] - 0.02, "impact-bass-2", "impact", 0.0, 1.6),
    (C["offre"] - 0.02, "click", "ui"), (C["image"] - 0.02, "click", "ui"), (C["prix"] - 0.02, "click", "ui"),
    (C["prix"] + 0.3, "ping", "accent"),
    (avant(S[3]["temps"], 0.3), "whoosh-cinematic", "transition", 0.0, 1.2),
    (C["bouton"] - 0.02, "pop", "ui"), (C["whatsapp"] - 0.02, "click", "ui"),
    (S[4]["temps"] - 1.6, "riser", "montee", 8.43, 1.6),
    (S[4]["temps"] - 0.02, "impact-bass-2", "impact", 0.0, 1.8),
    (publier, "click-soft", "ui"), (publier + 0.12, "pop", "ui"),
    (carte, "notification", "accent", 0.0, 1.3),
    (avant(S[5]["temps"]), "whoosh", "transition"),
    (C["abonne"] + 0.05, "click", "ui"), (C["abonne"] + 0.15, "ping", "accent"),
    (C["fin"] + 0.05, "chime", "signature"), (C["fin"] + 0.35, "sparkle", "accent", 0.0, 1.2),
]
SFX += [(x, "key-press", "tic") for x in tics]
SFX += [(x, "key-press", "frappe") for x in frappe]
GAIN_CAT = {"impact": -2.0, "accent": -4.0, "transition": -5.0, "ui": -5.0, "montee": -7.0,
            "signature": -3.0, "tic": -9.0, "frappe": -6.0}

# niveau propre de chaque bruitage (crête de sonie momentanée), pour les égaliser entre eux
niv_f = f"{ICI}/assets/sfx/niveaux.json"
niv = json.load(open(niv_f)) if os.path.exists(niv_f) else {}
for f in sorted(os.listdir(f"{ICI}/assets/sfx")):
    if f.endswith(".mp3") and f[:-4] not in niv:
        # silence ajouté : la fenêtre momentanée (400 ms) doit couvrir les sons très courts
        out = subprocess.run(["ffmpeg", "-nostats", "-i", f"{ICI}/assets/sfx/{f}", "-af", "apad=pad_dur=1,ebur128",
                              "-f", "null", "-"], capture_output=True, text=True).stderr
        mm = [float(x) for x in re.findall(r"M:\s*(-?[0-9.]+)", out)]
        mm = [x for x in mm if x > -70]
        niv[f[:-4]] = {"duree": sonde(f"{ICI}/assets/sfx/{f}"), "m_max": max(mm) if mm else -20.0}
json.dump(niv, open(niv_f, "w"), indent=1)

CIBLE_SFX = -20.0           # crête momentanée commune avant gain de catégorie
evenements = []
for e in sorted(SFX, key=lambda e: e[0]):
    debut, nom, cat = max(0.0, e[0]), e[1], e[2]
    off = e[3] if len(e) > 3 else 0.0
    dur = e[4] if len(e) > 4 else niv[nom]["duree"] - off
    dur = round(min(dur, DUREE - debut), 3)
    if dur <= 0.05:
        continue
    gain_db = max(-30.0, min(12.0, CIBLE_SFX - niv[nom]["m_max"])) + GAIN_CAT[cat]
    evenements.append({"t": round(debut, 3), "fichier": f"assets/sfx/{nom}.mp3", "decalage": off, "duree": dur,
                       "gain_db": round(gain_db, 2), "categorie": cat})

# ---------------------------------------------------------------- musique : ducking sous la voix
PAROLE_DB, PAUSE_DB = -11.0, -4.5           # gain musique pendant la voix / dans les respirations
zones = []
for sg in segments:
    a, z = sg["debut"] - 0.08, sg["fin"] + 0.05
    if zones and a - zones[-1][1] < 0.45:
        zones[-1][1] = z
    else:
        zones.append([a, z])
enveloppe = [{"t": 0.0, "db": PAROLE_DB}]
for a, z in zones:
    enveloppe += [{"t": round(max(0.0, a - 0.12), 3), "db": PAUSE_DB if a > 0.2 else PAROLE_DB},
                  {"t": round(max(0.0, a), 3), "db": PAROLE_DB},
                  {"t": round(z, 3), "db": PAROLE_DB}, {"t": round(z + 0.2, 3), "db": PAUSE_DB}]

mix = {"duree": DUREE, "musique": {"fichier": MUSIQUE, "debut": RETARD, "enveloppe": enveloppe},
       "voix": None if ESTIMATION else {"fichier": "voix.mp3", "segments": segments},
       "sfx": evenements, "parole": zones}
json.dump(mix, open(f"{ICI}/mix.json", "w"), ensure_ascii=False, indent=1)

# ---------------------------------------------------------------- balises audio de l'aperçu
audio = [f'      <audio id="musique" src="{MUSIQUE}" data-start="{RETARD}" data-duration="{round(min(FIN_MUSIQUE, DUREE - RETARD), 3)}" '
         f'data-track-index="21" data-volume="1"></audio>']
if not ESTIMATION:
    for n, sg in enumerate(segments):
        audio.append(f'      <audio id="voix-{n}" src="voix.mp3" data-start="{sg["debut"]}" data-media-start="{sg["src0"]}" '
                     f'data-duration="{round(sg["src1"] - sg["src0"], 3)}" data-track-index="{20 if n % 2 == 0 else 19}" '
                     f'data-volume="1"></audio>')
pistes = []
for n, e in enumerate(evenements):
    k = next((i for i, f in enumerate(pistes) if f <= e["t"] - 0.01), None)
    if k is None:
        pistes.append(0)
        k = len(pistes) - 1
    pistes[k] = e["t"] + e["duree"]
    media = f' data-media-start="{e["decalage"]}"' if e["decalage"] else ""
    vol = round(min(1.0, 10 ** (e["gain_db"] / 20)), 3)
    audio.append(f'      <audio id="sfx-{n}" src="{e["fichier"]}" data-start="{e["t"]:.3f}" data-duration="{e["duree"]}"'
                 f'{media} data-track-index="{30 + k}" data-volume="{vol}"></audio>')

# ---------------------------------------------------------------- assemblage
ticks = "".join(f'<i class="tick" style="transform: rotate({k * 30}deg)"></i>' for k in range(12))
data = {"duree": DUREE, "c": {k: round(v, 3) for k, v in C.items()}, "scenes": scenes, "tics": tics,
        "frappe": frappe, "publier": publier, "carte": carte, "pulse": pulsations, "calmes": CALMES, "sous": sous,
        "musique": [{"t": e["t"], "v": round(10 ** (e["db"] / 20), 3)} for e in enveloppe]}
page = open(f"{ICI}/gabarit.tpl", encoding="utf-8").read()
for n, s in enumerate(scenes, 1):
    page = page.replace("{{S%d}}" % n, f'data-start="{s["debut"]}" data-duration="{round(s["fin"] - s["debut"], 3)}"')
page = (page.replace("{{DUREE}}", str(DUREE)).replace("{{TICKS}}", ticks)
            .replace("{{SOUS_TITRES}}", "\n".join(html_st)).replace("{{AUDIO}}", "\n".join(audio))
            .replace("{{DATA}}", json.dumps(data, ensure_ascii=False)))
assert "{{" not in page, re.findall(r"\{\{\w+\}\}", page)
open(f"{ICI}/index.html", "w", encoding="utf-8").write(page)

print(f"index.html : {DUREE} s · musique {FIN_MUSIQUE} s à {60 / PERIODE:.1f} BPM, départ à {RETARD} s · "
      f"dérive des ancres {cout:.2f} s · {len(evenements)} bruitages"
      + (" · ESTIMATION (sans voix)" if ESTIMATION else " · voix"))
for sg in segments:
    texte = " ".join(jetons[i][1] for i in sg["mots"])
    print(f"  {sg['debut']:6.2f} → {sg['fin']:6.2f}  (temps {sg['temps']:6.2f})  {texte}")
