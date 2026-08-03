#!/usr/bin/env python3
"""Génère index.html depuis template.tpl + transcript.json.
Usage : python3 build.py [transparent|vert]   (défaut : transparent)"""
import json, re, html, sys

BASE = "/home/user/CRM-open-source/studio/projets/selfie-overlay"
VERT = len(sys.argv) > 1 and sys.argv[1] == "vert"
FOND = "#00ff00" if VERT else "transparent"
# fin du degrade de separation : opaque en chroma (pas de pixels semi-verts), fondu en alpha
FADE_FIN = "1" if VERT else "0"

words = json.load(open(f"{BASE}/transcript.json"))

# corrections d'écoute
for i, w in enumerate(words):
    t = w["text"].strip()
    if t.rstrip(",.") == "Gemma":
        t = t  # nom conservé tel qu'entendu
    w["text"] = t

chunks, cur = [], []
def flush():
    global cur
    if cur:
        chunks.append({"words": cur, "start": cur[0]["start"], "end": cur[-1]["end"]})
        cur = []
for i, w in enumerate(words):
    cur.append(w)
    nxt = words[i + 1] if i + 1 < len(words) else None
    txt = " ".join(x["text"] for x in cur)
    if (w["text"].rstrip(",.;") != w["text"] or len(cur) >= 4 or len(txt) >= 26
            or (nxt and nxt["start"] - w["end"] > 0.4)):
        flush()
flush()
for i, c in enumerate(chunks):
    nxt = chunks[i + 1] if i + 1 < len(chunks) else None
    c["until"] = nxt["start"] if (nxt and nxt["start"] - c["end"] < 0.7) else c["end"] + 0.35
chunks[-1]["until"] = min(chunks[-1]["until"], 54.2)

BLEU = re.compile(r"^(Claude|Gemma|Google|l'?IA|IA|local|langage|modèles?|communauté|lien|guide)$", re.I)
AMBRE = re.compile(r"^(gratuit\w*|abonne-toi|abonnement|commentes?|centaines|sécurisée?|limite|étape)$", re.I)
ROUGE = re.compile(r"^(problème|chinois|déguisés|données|n'importe)$", re.I)

cap_html, cap_tw = [], []
for n, c in enumerate(chunks):
    spans = []
    for w in c["words"]:
        t = html.escape(w["text"])
        core = w["text"].strip(",.;")
        if ROUGE.match(core):
            spans.append(f'<span class="kr">{t}</span>')
        elif BLEU.match(core):
            spans.append(f'<span class="kb">{t}</span>')
        elif AMBRE.match(core):
            spans.append(f'<span class="ka">{t}</span>')
        else:
            spans.append(t)
    cap_html.append(f'      <div class="cap" id="cap-{n}"><span class="pill">{" ".join(spans)}</span></div>')
    s, u = round(c["start"], 3), round(c["until"], 3)
    cap_tw.append(
        f'tl.set("#cap-{n}",{{autoAlpha:1}},{s});'
        f'tl.fromTo("#cap-{n}",{{scale:.86,y:14}},{{scale:1,y:0,duration:.15,ease:"power2.out"}},{s});'
        f'tl.set("#cap-{n}",{{autoAlpha:0}},{u});')

template = open(f"{BASE}/template.tpl").read()
out = (template
       .replace("{{FOND}}", FOND)
       .replace("{{FADE_FIN}}", FADE_FIN)
       .replace("{{CAPTIONS_HTML}}", "\n".join(cap_html))
       .replace("{{CAPTIONS_TWEENS}}", "\n      ".join(cap_tw)))
open(f"{BASE}/index.html", "w").write(out)
print(f"{len(chunks)} blocs de sous-titres · fond={FOND} · index.html écrit.")
