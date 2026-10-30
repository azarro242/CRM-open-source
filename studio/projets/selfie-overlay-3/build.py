#!/usr/bin/env python3
"""Génère index.html depuis template.tpl + transcript.json.
Usage : python3 build.py [transparent|vert]   (défaut : transparent)"""
import json, re, html, sys

BASE = "/home/user/CRM-open-source/studio/projets/selfie-overlay-3"
MODE = sys.argv[1] if len(sys.argv) > 1 else "transparent"
# transparent : degrade vers l'alpha (WebM)
# noir        : meme degrade sur fond noir (MP4, a poser en mode « Ecran »)
# vert        : coupure nette a 960 px sur fond vert (MP4, incrustation chroma)
FOND = {"vert": "#00ff00", "noir": "#000000"}.get(MODE, "transparent")
BANDEAU = ("height: 960px; background: #000;" if MODE == "vert" else
           "height: 1060px; background: linear-gradient(180deg, #000 0px, #000 880px, rgba(0, 0, 0, 0) 1060px);")

words = json.load(open(f"{BASE}/transcript.json"))

# corrections d'écoute (noms de marque)
MOTS = {"Tiat": "Chat", "GPT,": "GPT,", "promptes": "prompts", "magazine.": "imagine.",
        "Commente": "Commente"}
fusion = []
for i, w in enumerate(words):
    t = w["text"].strip()
    if t in ("Tiat", "Tchat", "Chat") and i + 1 < len(words) and words[i + 1]["text"].strip().startswith("GPT"):
        suite = words[i + 1]["text"].strip()
        fusion.append({"text": "ChatGPT" + suite[3:], "start": w["start"], "end": words[i + 1]["end"]})
        words[i + 1]["text"] = ""
        continue
    if t == "":
        continue
    fusion.append({"text": MOTS.get(t, t), "start": w["start"], "end": w["end"]})
words = fusion

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
chunks[-1]["until"] = min(chunks[-1]["until"], 56.0)

BLEU = re.compile(r"^(ChatGPT|GPT|Ads|plateforme|publicitaire|publicité|prompts|utilisateurs|outil|guide|ressource|Meta|Google|Internet)$", re.I)
AMBRE = re.compile(r"^(gratuit\w*|abonne-toi|Commente|milliards|millions|100%|10|2|700|nouveauté|concurrence|changer)$", re.I)
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
       .replace("{{BANDEAU}}", BANDEAU)
       .replace("{{CAPTIONS_HTML}}", "\n".join(cap_html))
       .replace("{{CAPTIONS_TWEENS}}", "\n      ".join(cap_tw)))
open(f"{BASE}/index.html", "w").write(out)
print(f"{len(chunks)} blocs · mode={MODE} · fond={FOND} · index.html écrit.")
