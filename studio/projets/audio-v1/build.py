#!/usr/bin/env python3
"""Génère les sous-titres (HTML + tweens GSAP) depuis transcript.json
et les insère dans le template de composition -> index.html"""
import json, re, html

BASE = "/home/user/CRM-open-source/studio/projets/audio-v1"
words = json.load(open(f"{BASE}/transcript.json"))

# --- corrections de marque / oreille ---
FIX = {"Cloudmax": "Claude Max", "Cloudmax.": "Claude Max.", "Cloudmax,": "Claude Max,",
       "cloud.com": "claude.com"}
for i, w in enumerate(words):
    t = w["text"].strip()
    t = FIX.get(t, t)
    if i == 0 and t == "Je":
        t = "Tu"
    w["text"] = t

# --- découpage en blocs de sous-titres ---
chunks = []
cur = []
def flush():
    global cur
    if cur:
        chunks.append({"words": cur, "start": cur[0]["start"], "end": cur[-1]["end"]})
        cur = []
for i, w in enumerate(words):
    cur.append(w)
    nxt = words[i + 1] if i + 1 < len(words) else None
    txt = " ".join(x["text"] for x in cur)
    if (w["text"].rstrip(",.;")  != w["text"]            # ponctuation
        or len(cur) >= 4 or len(txt) >= 24               # taille
        or (nxt and nxt["start"] - w["end"] > 0.45)):    # pause
        flush()
flush()

# fenêtre d'affichage : jusqu'au bloc suivant (ou +0.4 s en fin de phrase)
for i, c in enumerate(chunks):
    nxt = chunks[i + 1] if i + 1 < len(chunks) else None
    if nxt and nxt["start"] - c["end"] < 0.7:
        c["until"] = nxt["start"]
    else:
        c["until"] = c["end"] + 0.4
chunks[-1]["until"] = min(chunks[-1]["until"], 52.9)

GOLD = re.compile(r"^(gratuit\w*|commente\w*|abonne\w*(-toi)?|illimité\w*|6|60|mois)$", re.I)
VIOLET = re.compile(r"^(Claude|Max\.?|claude\.com|Anthropic|communauté\W?|formulaire|mail|guide|l'IA)$", re.I)

cap_html, cap_tw = [], []
for n, c in enumerate(chunks):
    spans = []
    for w in c["words"]:
        t = html.escape(w["text"])
        core = w["text"].strip(",.;")
        if GOLD.match(core):
            spans.append(f'<span class="kw">{t}</span>')
        elif VIOLET.match(core):
            spans.append(f'<span class="kv">{t}</span>')
        else:
            spans.append(t)
    cap_html.append(f'      <div class="cap" id="cap-{n}">{" ".join(spans)}</div>')
    s, u = round(c["start"], 3), round(c["until"], 3)
    cap_tw.append(
        f'tl.set("#cap-{n}",{{autoAlpha:1}},{s});'
        f'tl.fromTo("#cap-{n}",{{y:16,scale:.96}},{{y:0,scale:1,duration:.18,ease:"power2.out"}},{s});'
        f'tl.set("#cap-{n}",{{autoAlpha:0}},{u});')

template = open(f"{BASE}/template.tpl").read()
out = (template
       .replace("{{CAPTIONS_HTML}}", "\n".join(cap_html))
       .replace("{{CAPTIONS_TWEENS}}", "\n      ".join(cap_tw)))
open(f"{BASE}/index.html", "w").write(out)
print(f"{len(chunks)} blocs de sous-titres générés, index.html écrit.")
