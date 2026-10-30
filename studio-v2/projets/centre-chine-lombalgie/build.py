#!/usr/bin/env python3
"""Centre de réadaptation de Chine · « Mal au dos à force d'être assis » — format « médecin + anatomie », darija.

  python3 build.py        → index.html (aperçu et rendu HyperFrames) + mix.json (outils de mixage : mix.py)

La voix chinoise du médecin est conservée. Les textes animés sont les sous-titres : chaque phrase devient une
carte en verre en darija, révélée mot à mot pendant qu'il parle (horodatage : transcription du client recalée
sur l'enveloppe sonore, voir SCRIPT-DARIJA.md). Pendant les explications, le médecin passe en vignette et la
planche d'anatomie (image et zones de la page « body chart » du client) pivote face / profil / dos.
"""
import html, json, os, re

ICI = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(ICI, "..", "..", "sources", "centre-chine-lombalgie")
DUREE = 45.0                 # 42 s de vidéo + carte de fin sur image figée
FIN_VIDEO = 41.966

# ---------------------------------------------------------------- icônes (traits blancs, grille 24)
ICONES = {
    "sourire": '<circle cx="12" cy="12" r="10"/><path d="M8 14s1.5 2 4 2 4-2 4-2"/><path d="M9 9h.01M15 9h.01"/>',
    "horloge": '<circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/>',
    "chaise": '<path d="M19 9V6a2 2 0 0 0-2-2H7a2 2 0 0 0-2 2v3"/><path d="M3 16a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-5a2 2 0 0 0-4 0v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V11a2 2 0 0 0-4 0z"/><path d="M5 18v2M19 18v2"/>',
    "colonne": '<rect x="9" y="2" width="6" height="4" rx="1.5"/><rect x="9" y="8.5" width="6" height="4" rx="1.5"/><rect x="9" y="15" width="6" height="4" rx="1.5"/><path d="M12 20.5V22M6 4.5h2M16 4.5h2M6 17h2M16 17h2"/>',
    "aiguille": '<path d="M4 20 15.5 8.5"/><circle cx="18" cy="6" r="3"/><path d="M3 21l1.5-1.5"/>',
    "lignes": '<path d="M8 3c-2 4 2 6 0 9s2 6 0 9"/><path d="M16 3c-2 4 2 6 0 9s2 6 0 9"/>',
    "cible": '<circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="5"/><circle cx="12" cy="12" r="1.5"/>',
    "feuille": '<path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/>',
    "main": '<path d="M18 11V6a2 2 0 0 0-4 0v1"/><path d="M14 10V4a2 2 0 0 0-4 0v2"/><path d="M10 10.5V6a2 2 0 0 0-4 0v8"/><path d="M18 8a2 2 0 1 1 4 0v6a8 8 0 0 1-8 8h-2c-2.8 0-4.5-.86-5.99-2.34l-3.6-3.6a2 2 0 0 1 2.83-2.82L7 15"/>',
    "ventouse": '<path d="M8 4h8"/><path d="M9 4v3C6.6 8.1 5.5 10.2 5.5 13v2h13v-2c0-2.8-1.1-4.9-3.5-6V4"/><path d="M9 15c1-1.6 5-1.6 6 0"/><path d="M3 19.5c3-1.6 6-1.6 9 0s6 1.6 9 0"/>',
    "lune": '<path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/>',
    "coeur": '<path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/><path d="m9 11 2 2 4-4"/>',
    "agenda": '<rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/><path d="m9 16 2 2 4-4"/>',
    "repere": '<path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/>',
    "tel": '<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>',
}


def icone(nom, taille=60):
    return (f'<svg viewBox="0 0 24 24" width="{taille}" height="{taille}" fill="none" stroke="#fff" stroke-width="2.2" '
            f'stroke-linecap="round" stroke-linejoin="round">{ICONES[nom]}</svg>')


# ---------------------------------------------------------------- sous-titres = textes animés (darija)
# (id, texte, icône, entrée, sortie, début de parole, fin de parole)
SOUS = [
    ("k1", "السلام عليكم", "sourire", 0.85, 2.05, 0.90, 1.50),
    ("k2", "اللي كيقعد ساعات طويلة ف البيرو…", "horloge", 2.10, 6.55, 2.15, 6.05),
    ("k3", "القعدة الطويلة كتجيب الوجع ف أسفل الظهر", "colonne", 7.45, 11.70, 7.60, 10.60),
    ("k4", "أجي عندنا، نديرو ليك الإبر الصينية", "aiguille", 11.80, 15.65, 11.95, 15.15),
    ("k5", "على خط المثانة… وخط الكلاوي", "lignes", 15.75, 20.40, 15.90, 19.25),
    ("k6", "ونقط على سلسلة الظهر كتخفف الوجع", "colonne", 20.50, 23.95, 20.70, 23.45),
    ("k7", "ونقط بعيدة على الوجع", "cible", 24.00, 26.20, 24.10, 25.55),
    ("k8", "تشنغشان وتشنغجين ف رمانة الرجل", "cible", 26.25, 29.30, 26.30, 28.75),
    ("k9", "وي تشونغ: ورا الركبة", "cible", 29.35, 31.10, 29.45, 30.30),
    ("k10", "كيعاونو يخففو هاد الوجع", "feuille", 31.15, 33.35, 31.30, 32.95),
    ("k11", "وكاين حتى الماساج والحجامة", "main", 33.40, 36.00, 33.50, 35.75),
    ("k12", "باش يرتاح جسمك من العيا", "lune", 36.05, 38.35, 36.15, 37.80),
    ("k13", "شكراً بزاف!", "coeur", 38.45, 39.95, 38.60, 39.60),
]

# ---------------------------------------------------------------- pastilles et bulles autour du médecin
# (id, texte, icône, entrée, sortie, left, top)
PUCES = [
    ("p-bureau", "ساعات ف البيرو", "horloge", 2.45, 7.30, 40, 520),
    ("p-assis", "القعدة الطويلة", "chaise", 4.30, 7.30, 640, 900),
    ("p-aiguille", "الإبر الصينية", "aiguille", 13.00, 15.55, 640, 900),
    ("p-soulage", "راحة من الوجع", "feuille", 31.50, 33.30, 40, 560),
    ("p-massage", "الماساج", "main", 33.85, 37.95, 40, 540),
    ("p-ventouse", "الحجامة", "ventouse", 34.95, 37.95, 700, 760),
    ("p-repos", "جسم مرتاح", "lune", 36.40, 38.30, 40, 760),
    ("p-suivi", "متابعة", "agenda", 40.10, DUREE, 760, 190),
    ("p-soin", "رعاية", "coeur", 40.40, DUREE, 600, 290),
]
# (id, icône, entrée, sortie, left, top, taille)
BULLES = [
    ("b-aiguille", "aiguille", 13.30, 15.55, 70, 760, 128),
    ("b-ventouse", "ventouse", 35.20, 37.95, 880, 560, 116),
    ("b-lune", "lune", 36.50, 38.30, 80, 900, 132),
    ("b-coeur", "coeur", 40.70, DUREE, 930, 640, 96),
]

# ---------------------------------------------------------------- planche d'anatomie
ZONES = json.load(open(os.path.join(SRC, "reference-page", "zones.json"))) if os.path.exists(
    os.path.join(SRC, "reference-page", "zones.json")) else None
if ZONES is None:   # zones extraites de la page « body chart » du client (aire de chaque région)
    h = open(os.path.join(SRC, "reference-page", "body-chart.html"), encoding="utf-8").read()
    ZONES = {m.group(1): m.group(2) for m in re.finditer(
        r'<g class="zone" id="zone-([^"]+)".*?<path class="zone__aire" d="([^"]+)"', h)}
    json.dump(ZONES, open(os.path.join(SRC, "reference-page", "zones.json"), "w"))

# placement de l'image dans le repère de la page (viewBox 133 4 366 883) et découpe de chaque vue
VUES = {
    "face": {"img": (126.48710010319917, -19.481140255798827, 939.1124871001032, 939.7355300238455), "coupe": (134, 12, 364, 867)},
    "profil": {"img": (-165.94959908361966, -18.72935183177975, 939.2898052691867, 939.7355300238455), "coupe": (234, 12, 164, 867)},
    "dos": {"img": (-437.47882187938285, -19.614781756830304, 942.4964936886396, 943.7248285620985), "coupe": (148, 12, 336, 867)},
}
# méridiens (tracés approximatifs, repère de la page) — vessie et vaisseau gouverneur de dos, reins de face
MERIDIENS = {
    "dos": [
        ("m-vessie-g", "#00b5a3", "M300,165 L298,300 L296,420 L285,470 L271,520 L267,600 L266,628 L266,700 L262,760 L252,808"),
        ("m-vessie-d", "#00b5a3", "M332,165 L334,300 L336,420 L347,470 L361,520 L368,600 L375,628 L380,700 L385,760 L395,808"),
        ("m-dumai", "#f2b134", "M316,482 L316,330 L316,180 L316,110 L316,22"),
    ],
    "face": [
        ("m-rein-g", "#3b82f6", "M288,815 L284,720 L289,640 L298,560 L305,480 L306,400 L304,300 L292,215"),
        ("m-rein-d", "#3b82f6", "M340,815 L344,720 L339,640 L330,560 L323,480 L322,400 L324,300 L336,215"),
    ],
}
# points (vue de dos) : vaisseau gouverneur, puis Weizhong (BL40), Chengjin (BL56), Chengshan (BL57)
POINTS = {
    "pt-dm": [(316, 440), (316, 385), (316, 330), (316, 270), (316, 210)],
    "pt-chengshan": [(266, 738), (381, 738)],
    "pt-chengjin": [(266, 690), (379, 690)],
    "pt-weizhong": [(266, 628), (375, 628)],
}


def svg_vue(nom):
    x, y, w, hh = VUES[nom]["img"]
    cx, cy, cw, ch = VUES[nom]["coupe"]
    morceaux = [f'<svg class="planche" viewBox="133 4 366 883" preserveAspectRatio="xMidYMid meet">',
                f'<clipPath id="cp-{nom}"><rect x="{cx}" y="{cy}" width="{cw}" height="{ch}"/></clipPath>',
                f'<g clip-path="url(#cp-{nom})"><image href="assets/img/anatomie.png" preserveAspectRatio="none" '
                f'x="{x:.2f}" y="{y:.2f}" width="{w:.2f}" height="{hh:.2f}"/></g>']
    if nom == "dos":
        morceaux.append(f'<path id="z-lombaires" class="zone-douleur" d="{ZONES["d-lombaires"]}"/>')
    if nom == "profil":
        morceaux.append(f'<path id="z-lombes" class="zone-douleur" d="{ZONES["p-lombes"]}"/>')
    for mid, couleur, d in MERIDIENS.get(nom, []):
        morceaux.append(f'<path id="{mid}" class="meridien" d="{d}" stroke="{couleur}" pathLength="1" '
                        f'stroke-dasharray="1 1" stroke-dashoffset="1"/>')
    if nom == "dos":
        for gid, pts in POINTS.items():
            for k, (px, py) in enumerate(pts):
                morceaux.append(f'<g class="point {gid}" id="{gid}-{k}"><circle class="point-halo" cx="{px}" cy="{py}" r="15"/>'
                                f'<circle class="point-coeur" cx="{px}" cy="{py}" r="6.5"/></g>')
    morceaux.append("</svg>")
    return "".join(morceaux)


# ---------------------------------------------------------------- bruitages
SFX = [  # (instant, fichier, gain dB, [début, durée])
    (0.00, "impact-bass-1", -8), (0.05, "whoosh-short", -12), (0.85, "pop", -14),
    (2.45, "pop", -14), (4.30, "pop", -14),
    (9.45, "whoosh", -12), (9.70, "glitch-1", -14, 0.0, 0.4), (10.25, "whoosh-short", -14),
    (11.75, "whoosh", -12), (13.00, "pop", -14), (13.30, "sparkle", -16, 0.0, 1.0),
    (15.70, "whoosh", -12), (17.90, "ping", -15), (18.20, "whoosh-short", -15), (18.55, "whoosh-short", -15),
    (19.70, "ping", -15), (20.55, "whoosh-short", -15), (20.85, "whoosh-short", -15),
    (22.35, "key-press", -16), (22.55, "key-press", -16), (22.75, "key-press", -16), (22.95, "key-press", -16),
    (23.15, "key-press", -16),
    (24.60, "whoosh-cinematic", -14, 0.0, 1.2), (26.60, "pop", -13), (28.10, "pop", -13),
    (29.40, "whoosh-short", -14), (29.60, "ping", -14),
    (31.10, "whoosh", -12), (31.50, "pop", -14), (33.85, "pop", -14), (34.95, "pop", -14),
    (36.45, "sparkle", -15, 0.0, 1.2), (38.45, "chime", -12),
    (40.00, "notification", -10, 0.0, 1.3), (40.40, "pop", -14), (40.70, "pop", -14),
]
niv = json.load(open(os.path.join(ICI, "assets", "sfx", "niveaux.json")))
evenements = []
for e in SFX:
    t, nom, g = e[0], e[1], e[2]
    off = e[3] if len(e) > 3 else 0.0
    dur = e[4] if len(e) > 4 else niv[nom]["duree"] - off
    dur = round(min(dur, DUREE - t), 3)
    gain = max(-30.0, min(12.0, -20.0 - niv[nom]["m_max"])) + g     # égalisés à −20 LUFS de crête, puis gain
    evenements.append({"t": t, "fichier": f"assets/sfx/{nom}.mp3", "decalage": off, "duree": dur, "gain_db": round(gain, 2)})

# ---------------------------------------------------------------- HTML
def mots(texte):
    return " ".join(f'<span class="mot">{html.escape(m)}</span>' for m in texte.split())


html_sous = []
for kid, texte, ic, *_ in SOUS:
    html_sous.append(f'        <div class="sous" id="{kid}" dir="rtl"><i class="sous-ic">{icone(ic, 62)}</i>'
                     f'<div class="sous-txt"><div class="sous-titre">{mots(texte)}</div><i class="sous-trait"></i></div></div>')
html_puces = [f'        <div class="puce" id="{pid}" dir="rtl" style="left: {x}px; top: {y}px"><i class="puce-ic">{icone(ic, 38)}</i>'
              f'<span>{html.escape(t)}</span></div>' for pid, t, ic, a, z, x, y in PUCES]
html_bulles = [f'        <div class="bulle" id="{bid}" style="left: {x}px; top: {y}px; width: {s}px; height: {s}px">'
               f'{icone(ic, int(s * 0.48))}</div>' for bid, ic, a, z, x, y, s in BULLES]
audio = []
for n, e in enumerate(evenements):
    vol = round(min(1.0, 10 ** (e["gain_db"] / 20)), 3)
    media = f' data-media-start="{e["decalage"]}"' if e["decalage"] else ""
    audio.append(f'      <audio id="sfx-{n}" src="{e["fichier"]}" data-start="{e["t"]:.3f}" data-duration="{e["duree"]}"{media} '
                 f'data-track-index="{30 + n % 6}" data-volume="{vol}"></audio>')

data = {"duree": DUREE, "finVideo": FIN_VIDEO, "sous": [s[:1] + s[3:] for s in SOUS],
        "puces": [(p[0], p[3], p[4]) for p in PUCES], "bulles": [(b[0], b[2], b[3]) for b in BULLES]}
page = open(os.path.join(ICI, "gabarit.tpl"), encoding="utf-8").read()
remplacements = {
    "{{DUREE}}": str(DUREE), "{{FIN_VIDEO}}": str(FIN_VIDEO), "{{FIGE_DUREE}}": str(round(DUREE - 41.9, 3)),
    "{{SVG_FACE}}": svg_vue("face"), "{{SVG_PROFIL}}": svg_vue("profil"), "{{SVG_DOS}}": svg_vue("dos"),
    "{{SOUS}}": "\n".join(html_sous), "{{PUCES}}": "\n".join(html_puces), "{{BULLES}}": "\n".join(html_bulles),
    "{{AUDIO}}": "\n".join(audio), "{{DATA}}": json.dumps(data, ensure_ascii=False),
    "{{IC_ALERTE}}": '<b>!</b>', "{{IC_COEUR}}": icone("coeur", 64), "{{IC_REPERE}}": icone("repere", 34),
    "{{IC_TEL}}": icone("tel", 32),
}
for k, v in remplacements.items():
    page = page.replace(k, v)
assert "{{" not in page, re.findall(r"\{\{\w+\}\}", page)
open(os.path.join(ICI, "index.html"), "w", encoding="utf-8").write(page)
json.dump({"duree": DUREE, "voix": "assets/video/medecin.mp4", "fin_voix": FIN_VIDEO,
           "parole": [[s[5], s[6]] for s in SOUS], "sfx": evenements},
          open(os.path.join(ICI, "mix.json"), "w"), ensure_ascii=False, indent=1)
print(f"index.html : {DUREE} s · {len(SOUS)} sous-titres · {len(PUCES)} pastilles · {len(evenements)} bruitages")
