#!/usr/bin/env python3
"""VSL Oddysee (YouTube 16:9) — génère index.html, sous-titres.srt et sfx.json.

  python3 build.py

Entrées : voix.txt (une ligne = une phrase du script, L00…L31), voix.transcript.json (horodatage
mot à mot), gabarit.tpl (scènes). Toutes les animations sont calées sur les mots : T(l, k) = début
du k-ième mot de la ligne l (k négatif : depuis la fin).
"""
import json, math, re, sys, unicodedata

SANS_SOUS = "--sans-sous" in sys.argv   # variante sans sous-titres incrustés (même montage)

ICI = __file__.rsplit("/", 1)[0] if "/" in __file__ else "."
DUREE = 215.6          # voix finale 213,4 s + 2,2 s de maintien de l'écran final
FIN_SOUS = 213.5       # plus de sous-titres sur l'écran final

mots = json.load(open(f"{ICI}/voix.transcript.json", encoding="utf-8"))
lignes = [l.split() for l in open(f"{ICI}/voix.txt", encoding="utf-8").read().strip().split("\n")]
assert sum(map(len, lignes)) == len(mots)
L = []  # L[l][k] = (début, fin, texte)
i = 0
for l in lignes:
    L.append([(round(mots[i + k]["start"], 3), round(mots[i + k]["end"], 3), l[k]) for k in range(len(l))])
    i += len(l)

def T(l, k=0): return L[l][k][0]
def E(l, k=-1): return L[l][k][1]

# ---------- groupes de scènes (sections) ----------
GROUPES = [  # nom, première ligne, dernière ligne, thème (le thème n'est plus utilisé : fond unique)
    ("intro", 0, 0, "clair"), ("niv", 1, 7, "clair"), ("effets", 8, 9, "clair"),
    ("douleur", 10, 12, "sombre"), ("odd", 13, 13, "sombre"), ("parcours", 14, 15, "clair"),
    ("preuves", 16, 18, "clair"), ("temoins", 19, 19, "clair"), ("meta", 20, 20, "sombre"), ("engage", 21, 23, "sombre"),
    ("outils", 24, 24, "clair"), ("temps", 25, 25, "clair"), ("question", 26, 26, "clair"),
    ("audit", 27, 29, "clair"), ("cta", 30, 30, "clair"), ("capa", 31, 31, "sombre"),
    ("fin", 32, 32, "sombre"),
]
COUPES_FIXES = {}   # (instant de coupe imposé, si besoin)
FONDU = 0.4
G = {}
for n, (nom, a, b, theme) in enumerate(GROUPES):
    if n == 0:
        coupe = 0.0
    elif nom in COUPES_FIXES:
        coupe = COUPES_FIXES[nom]
    else:
        prec_fin = E(GROUPES[n - 1][2])
        coupe = max(prec_fin + 0.12, T(a) - 0.3)
    G[nom] = {"coupe": round(coupe, 3), "theme": theme, "a": a, "b": b}
noms = [g[0] for g in GROUPES]
for n, nom in enumerate(noms):
    debut = max(0.0, G[nom]["coupe"] - FONDU)
    fin = G[noms[n + 1]]["coupe"] + FONDU if n + 1 < len(noms) else DUREE
    G[nom].update(debut=round(debut, 3), fin=round(fin, 3), duree=round(fin - debut, 3))

# ---------- sous-titres intégrés (typographie animée) ----------
CLES = {  # ligne : [(fragment, classe)]  cle = violet gras ; ital = sérif italique
    0: [("marketing", "ital"), ("exponentielles", "cle")],
    1: [("débutant", "cle"), ("amateur", "cle"), ("professionnel", "cle"), ("expert", "cle")],
    2: [("plus", "cle"), ("clients", "cle")],
    3: [("complètement", "ital"), ("folle", "ital")],
    4: [("découvre", "cle")], 5: [("reproduit", "cle")], 6: [("actions", "cle")],
    7: [("choisir", "cle"), ("toi.", "ital")],
    8: [("ressens", "cle"), ("directement", "cle")],
    9: [("demandes", "cle"), ("rendez-vous", "cle"), ("chiffre", "cle"), ("affaires", "cle")],
    10: [("prochain", "ital"), ("client.", "ital")],
    11: [("plus", "ital"), ("rien.", "ital")],
    12: [("développer", "cle")],
    13: [("oddysee", "cle"), ("changer", "ital")],
    14: [("découvrir", "cle"), ("comprendre", "cle"), ("contacter", "cle")],
    15: [("dors", "ital")],
    16: [("terrain", "ital"), ("figures", "cle"), ("entrepreneuriat", "cle")],
    19: [("exagère", "ital"), ("témoignages", "cle"), ("confiance", "cle")],
    18: [("adidas", "cle"), ("puma", "cle"), ("montessori", "cle"), ("menara", "cle"), ("mall", "cle")],
    20: [("meta", "cle"), ("business", "cle"), ("partner", "cle"), ("cinq", "cle"), ("dublin", "ital"), ("zero", "cle"), ("laser", "cle"), ("retargeting", "cle"), ("savoir-faire", "cle")],
    21: [("engagement", "ital")],
    22: [("trois", "cle"), ("millions", "cle"), ("mille", "cle"), ("euros", "cle")],
    23: [("stratégie", "cle"), ("publicité", "cle")],
    24: [("chatgpt", "cle"), ("claude", "cle"), ("google", "cle")],
    25: [("précieux", "ital"), ("aussi", "ital")],
    26: [("mon", "cle"), ("entreprise", "cle")],
    27: [("audit", "ital"), ("gratuit", "ital")],
    28: [("bloque", "cle"), ("opportunités", "cle")],
    29: [("prioriser", "cle")],
    30: [("réserver", "cle"), ("audit", "cle")],
    31: [("dès", "ital"), ("maintenant", "ital")],
    32: [("différence", "ital"), ("expertise", "ital")],
}
# fragments affichés ailleurs dans l'image (pas de doublon avec le texte de la scène)
CACHES = {26: (17, 28)}  # ligne 25 : la question du prospect s'écrit dans la bulle (mots 17 à 27)

PONCT_SEULE = {":", "«", "»", "?", "!", ";"}
def norm(s):
    s = unicodedata.normalize("NFD", s.lower())
    return "".join(c for c in s if unicodedata.category(c) != "Mn")

morceaux = []  # {l, mots:[(i_global, texte, classe, debut, fin)]}
def longueur(ms): return sum(len(m[1]) + 1 for m in ms) - 1
gi = 0
for l, ligne in enumerate(L):
    cache = CACHES.get(l)
    # 1) mots affichables (ponctuation isolée accrochée au mot voisin)
    ms, phrases = [], []
    for k, (d, f, txt) in enumerate(ligne):
        if cache and cache[0] <= k < cache[1]:
            if ms: phrases.append(ms); ms = []
            continue
        cls = ""
        for frag, c in CLES.get(l, []):
            if norm(frag) in norm(txt):
                cls = c
        if txt in PONCT_SEULE and txt != "«" and (ms or phrases):
            cible = ms if ms else phrases[-1]
            p = cible[-1]; cible[-1] = (p[0], p[1] + "\u202f" + txt, p[2], p[3], p[4])
        else:
            ms.append((gi + k, txt, cls, d, f))
        if ms and ms[-1][1][-1] in ",.:…?»":
            phrases.append(ms); ms = []
    if ms: phrases.append(ms)
    # 2) petites propositions regroupées avec la suivante
    reg = []
    for ph in phrases:
        if reg and (len(reg[-1]) < 3 or longueur(reg[-1]) < 16) and longueur(reg[-1] + ph) <= 34 \
                and ph[0][3] - reg[-1][-1][4] < 0.6:
            reg[-1] = reg[-1] + ph
        else:
            reg.append(ph)
    # 3) propositions trop longues coupées en parts équilibrées
    for ph in reg:
        n = max(1, -(-longueur(ph) // 32))
        if n == 1:
            morceaux.append({"l": l, "mots": ph}); continue
        cible = longueur(ph) / n; part = []
        for m in ph:
            part.append(m)
            if longueur(part) >= cible * 0.92 and len(morceaux) >= 0 and m is not ph[-1]:
                morceaux.append({"l": l, "mots": part}); part = []
        if part:
            morceaux.append({"l": l, "mots": part})
    gi += len(ligne)
# phrases trop brèves à l'écran (< 0,8 s) regroupées avec la suivante de la même ligne
fus = []
for m in morceaux:
    if fus and fus[-1]["l"] == m["l"] and m["mots"][0][3] - fus[-1]["mots"][0][3] < 0.8 \
            and longueur(fus[-1]["mots"] + m["mots"]) <= 42:
        fus[-1]["mots"] += m["mots"]
    else:
        fus.append(m)
morceaux = fus
for n, m in enumerate(morceaux):
    m["debut"] = round(m["mots"][0][3] - 0.12, 3)
    fin_naturelle = m["mots"][-1][4] + 0.9
    suivant = morceaux[n + 1]["mots"][0][3] - 0.12 if n + 1 < len(morceaux) else 1e9
    m["fin"] = round(min(fin_naturelle if suivant - m["mots"][-1][4] > 1.3 else suivant, suivant, FIN_SOUS), 3)

html_sous = []
for n, m in enumerate(morceaux):
    spans = "".join(f'<span class="w {c[2]}" id="w{c[0]}">{c[1]}</span> ' for c in m["mots"])
    html_sous.append(f'<div class="st" id="st{n}">{spans.strip()}</div>')
donnees_sous = [{"d": m["debut"], "f": m["fin"], "m": [[c[0], c[3]] for c in m["mots"]]} for m in morceaux]

def srt_t(t):
    h, r = divmod(t, 3600); mn, s = divmod(r, 60)
    return f"{int(h):02d}:{int(mn):02d}:{int(s):02d},{int(round((s - int(s)) * 1000)):03d}"
# SRT : le texte intégral (y compris la question en bulle), une ligne de 42 caractères max par bloc
srt, n = [], 1
for l, ligne in enumerate(L):
    bloc = []
    for k, (d, f, txt) in enumerate(ligne):
        bloc.append((d, f, txt))
        long = len(" ".join(x[2] for x in bloc))
        if txt[-1] in ".?…" or (txt[-1] in ",:" and long > 20) or long > 38 or k == len(ligne) - 1:
            srt.append(f"{n}\n{srt_t(bloc[0][0])} --> {srt_t(bloc[-1][1] + 0.25)}\n{' '.join(x[2] for x in bloc)}\n")
            n += 1; bloc = []
open(f"{ICI}/sous-titres.srt", "w", encoding="utf-8").write("\n".join(srt))

# ---------- courbe exponentielle de l'accroche ----------
pts = []
for i in range(0, 61):
    u = i / 60
    x = 300 + 1320 * u
    y = 760 - 470 * ((math.exp(3.2 * u) - 1) / (math.exp(3.2) - 1))
    pts.append(f"{x:.1f},{y:.1f}")
COURBE = "M" + " L".join(pts)
COURBE_AIRE = COURBE + " L1620,760 L300,760 Z"

# ---------- icônes (traits, 24×24) ----------
def ico(corps, cls="ico"):
    return (f'<svg class="{cls}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" '
            f'stroke-linecap="round" stroke-linejoin="round">{corps}</svg>')
ICONES = {
    "mail": ico('<rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/>'),
    "cal": ico('<rect x="3" y="4" width="18" height="17" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/>'),
    "check": ico('<path d="M20 6 9 17l-5-5"/>'),
    "chat": ico('<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>'),
    "euro": ico('<path d="M18 7a7 7 0 1 0 0 10"/><path d="M4 10h10M4 14h10"/>'),
    "pub": ico('<path d="M3 11v2a1 1 0 0 0 1 1h3l5 4V6L7 10H4a1 1 0 0 0-1 1z"/><path d="M16 8a5 5 0 0 1 0 8"/>'),
    "post": ico('<rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="9" cy="9" r="2"/><path d="m21 15-5-5L5 21"/>'),
    "user": ico('<circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/>'),
    "oeil": ico('<path d="M2 12s4-7 10-7 10 7 10 7-4 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/>'),
    "doc": ico('<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6M8 13h8M8 17h6"/>'),
    "loupe": ico('<circle cx="11" cy="11" r="7"/><path d="m21 21-4.3-4.3"/>'),
    "maison": ico('<path d="m3 10 9-7 9 7v10a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z"/>'),
    "lune": ico('<path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z"/>'),
    "valise": ico('<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2M3 13h18"/>'),
    "ecole": ico('<path d="m2 9 10-5 10 5-10 5z"/><path d="M6 11v5c3 2 9 2 12 0v-5"/>'),
    "panier": ico('<circle cx="9" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/><path d="M2 3h3l3 12h11l2-8H6"/>'),
    "immeuble": ico('<rect x="4" y="3" width="16" height="18" rx="1"/><path d="M9 7h1M14 7h1M9 11h1M14 11h1M9 15h1M14 15h1"/>'),
    "croix": ico('<rect x="3" y="3" width="18" height="18" rx="4"/><path d="M12 8v8M8 12h8"/>'),
    "magasin": ico('<path d="M3 9 5 4h14l2 5M4 9h16v11H4z"/><path d="M9 20v-6h6v6"/>'),
    "formation": ico('<rect x="3" y="4" width="18" height="12" rx="2"/><path d="M8 20h8M12 16v4"/><path d="m10 8 4 2-4 2z"/>'),
    "horloge": ico('<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>'),
    "pin": ico('<path d="M12 21s-7-6.2-7-11a7 7 0 0 1 14 0c0 4.8-7 11-7 11z"/><circle cx="12" cy="10" r="2.5"/>'),
    "cible": ico('<circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="5"/><circle cx="12" cy="12" r="1"/>'),
    "fleche": ico('<path d="M5 12h14M13 6l6 6-6 6"/>'),
    "eclair": ico('<path d="M13 2 4 14h7l-1 8 9-12h-7z"/>'),
    "dossier": ico('<path d="M3 6a2 2 0 0 1 2-2h4l2 2h8a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>'),
    "facture": ico('<path d="M5 3h14v18l-3-2-2 2-2-2-2 2-2-2-3 2z"/><path d="M9 8h6M9 12h6"/>'),
    "graph": ico('<path d="M3 3v18h18"/><path d="m7 15 4-4 3 3 5-6"/>'),
    "coeur": ico('<path d="M20.8 4.6a5.5 5.5 0 0 0-7.8 0L12 5.7l-1-1.1a5.5 5.5 0 0 0-7.8 7.8l1 1.1L12 21l7.8-7.5 1-1.1a5.5 5.5 0 0 0 0-7.8z"/>'),
    "etoile": ico('<path d="m12 2 3 7 7 .6-5.3 4.6L18.4 21 12 17.3 5.6 21l1.7-6.8L2 9.6 9 9z"/>'),
}
CURSEUR = ('<svg viewBox="0 0 28 34" class="curseur-svg"><path d="M2 2 L2 27 L8.5 21 L13 31.5 L17.5 29.5 L13 19.5 '
           'L22 19.5 Z" fill="#111" stroke="#fff" stroke-width="2.2" stroke-linejoin="round"/></svg>')

# ---------- éléments répétés ----------
def calendrier(plein):
    evts = {2, 3, 5, 6, 8, 9, 10, 12, 13, 15, 16, 17, 19, 20, 22, 23, 24, 26, 27, 29, 30}
    cases = []
    for c in range(35):
        j = c - 2
        if 1 <= j <= 30:
            pts = '<i></i>' * (2 if j % 3 == 0 else 1) if (plein and j in evts) else ""
            cases.append(f'<div class="cj"><b>{j}</b><span>{pts}</span></div>')
        else:
            cases.append('<div class="cj vide"></div>')
    return "".join(cases)
def agenda(occupes, cote):
    heures = ["9:00", "10:00", "11:00", "12:00", "14:00", "15:00"]
    out = []
    for n, hr in enumerate(heures):
        bloc = f'<em class="occ">{occupes[n]}</em>' if occupes.get(n) else ""
        out.append(f'<div class="ag-l" id="ag{cote}{n}"><b>{hr}</b><span>{bloc}</span></div>')
    return "".join(out)
REPET = {
    "CAL_PLEIN": calendrier(True), "CAL_VIDE": calendrier(False),
    "AG_TOI": agenda({0: "Équipe", 3: "Client", 5: "Fournisseur"}, "t"),
    "AG_ODD": agenda({1: "Projet", 4: "Tournage"}, "o"),
}

# ---------- bruitages (temps en secondes, fichier, gain dB) ----------
SFX = []
def sfx(t, f, g=-8): SFX.append({"t": round(t, 3), "f": f, "g": g})
for nom in noms[1:]:
    sfx(G[nom]["coupe"] - 0.25, "whoosh.mp3", -20)
sfx(T(0, 13), "riser.mp3", -24)
for k in (3, 4, 6, 8): sfx(T(1, k), "pop.mp3", -14)
sfx(T(2, 11), "notification.mp3", -16)
sfx(T(4, 2), "click-soft.mp3", -14); sfx(T(5, 1), "pop.mp3", -15); sfx(T(5, 6), "pop.mp3", -15)
for k in (2, 5, 6): sfx(T(6, k), "click-soft.mp3", -13)
sfx(T(7, 13), "sparkle.mp3", -20)
sfx(T(9, 2), "notification.mp3", -16); sfx(T(9, 8), "ping.mp3", -16); sfx(T(9, 14), "chime.mp3", -18)
for k in (10, 12, 14): sfx(T(10, k), "pop.mp3", -15)
sfx(T(11, 4), "whoosh-short.mp3", -18)
for k in (4, 5, 7): sfx(T(12, k) + 0.25, "pop.mp3", -16)
sfx(T(13, 1), "chime.mp3", -16)
sfx(E(14) - 0.05, "notification.mp3", -16)
for k in (0, 5, 15): sfx(T(15, k) + 0.4, "ping.mp3", -18)
for k in (4, 5, 6, 9): sfx(T(18, k), "pop.mp3", -15)
sfx(T(20, 3), "sparkle.mp3", -18)
sfx(T(26, 18), "pop.mp3", -15)
sfx(T(29, -3), "notification.mp3", -16)
sfx(T(30, 3) + 0.35, "click.mp3", -10); sfx(T(30, 8) + 0.5, "click.mp3", -10); sfx(T(30, 10) + 0.3, "ping.mp3", -16)
sfx(T(31, 23) + 0.25, "click.mp3", -10); sfx(T(31, 22) - 0.1, "pop.mp3", -14)
sfx(E(32) + 0.1, "chime.mp3", -14)
for i in range(4): sfx(T(19, 16) + i * 0.18, "pop.mp3", -14)            # témoignages
sfx(T(19, 19), "notification.mp3", -16); sfx(T(20, 22) - 0.2, "whoosh.mp3", -12)
for k in (28, 31, 35): sfx(T(20, k), "click-soft.mp3", -12)               # zero, laser, retargeting
for t0 in (-0.15, G["odd"]["coupe"] - 0.7, G["fin"]["coupe"] - 0.7):       # étoile Oddysee : éclats puis traversée
    sfx(max(0.0, t0 + 0.05), "whoosh-cinematic.mp3", -8); sfx(max(0.0, t0 + 0.75), "impact-bass-2.mp3", -8)
json.dump({"duree": DUREE, "sfx": SFX}, open(f"{ICI}/sfx.json", "w"), indent=1)

# ---------- assemblage ----------
data = {"L": [[[w[0], w[1]] for w in l] for l in L], "G": G, "S": [] if SANS_SOUS else donnees_sous, "DUREE": DUREE}
h = open(f"{ICI}/gabarit.tpl", encoding="utf-8").read()
h = h.replace("%%DATA%%", json.dumps(data, ensure_ascii=False, separators=(",", ":")))
h = h.replace("%%SOUS%%", "" if SANS_SOUS else "\n        ".join(html_sous))
h = h.replace("%%DUREE%%", str(DUREE)).replace("%%COURBE%%", COURBE).replace("%%COURBE_AIRE%%", COURBE_AIRE)
h = h.replace("%%CURSEUR%%", CURSEUR)
for k, v in REPET.items(): h = h.replace(f"%%{k}%%", v)
h = re.sub(r"%%ICO:(\w+)%%", lambda m: ICONES[m.group(1)], h)
h = re.sub(r"%%T:(\d+):(-?\d+):(-?[\d.]+)%%", lambda m: str(round(T(int(m.group(1)), int(m.group(2))) + float(m.group(3)), 3)), h)
for nom in G: G[nom]["video"] = round(G[nom]["coupe"] + 0.15, 3)
h = re.sub(r"%%G:(\w+):(debut|duree|coupe|video)%%", lambda m: str(G[m.group(1)][m.group(2)]), h)
assert "%%" not in h, re.findall(r"%%[^%]*%%", h)[:5]
open(f"{ICI}/index.html", "w", encoding="utf-8").write(h)
print(f"index.html : {len(noms)} groupes, {len(morceaux)} morceaux de sous-titres, {len(SFX)} bruitages")
for nom in noms:
    print(f"  {nom:9s} {G[nom]['debut']:7.2f} → {G[nom]['fin']:7.2f}  ({G[nom]['theme']})")
