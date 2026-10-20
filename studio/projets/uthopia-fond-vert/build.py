#!/usr/bin/env python3
"""Sous-titres animés (pastille encre, pop sans fondu — sécurité incrustation chroma)
générés depuis transcript.json -> index.html"""
import json, re, html

BASE = "/home/user/CRM-open-source/studio/projets/uthopia-fond-vert"
words = json.load(open(f"{BASE}/transcript.json"))

FIX = {"LIA": "l'IA", "LIA,": "l'IA,", "nouvelles": None}
for i, w in enumerate(words):
    t = w["text"].strip()
    if t in ("LIA", "LIA,"):
        t = FIX[t]
    # « de nouvelles outils » -> « de nouveaux outils »
    if t == "nouvelles" and i + 1 < len(words) and words[i + 1]["text"].strip().startswith("outils"):
        t = "nouveaux"
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
    if (w["text"].rstrip(",.;") != w["text"] or len(cur) >= 5 or len(txt) >= 34
            or (nxt and nxt["start"] - w["end"] > 0.45)):
        flush()
flush()
for i, c in enumerate(chunks):
    nxt = chunks[i + 1] if i + 1 < len(chunks) else None
    c["until"] = nxt["start"] if (nxt and nxt["start"] - c["end"] < 0.7) else c["end"] + 0.4
chunks[-1]["until"] = min(chunks[-1]["until"], 132.2)

BLEU = re.compile(r"^(l'?IA|intelligence|artificielle|Utopia|méthode|étape|formations?|apprentissage|parcours|technologie)$", re.I)
AMBRE = re.compile(r"^(gratuit\w*|100%|simple|accessible|concret|cliquer|incontournable|efficacement)$", re.I)

cap_html, cap_tw = [], []
for n, c in enumerate(chunks):
    spans = []
    for w in c["words"]:
        t = html.escape(w["text"])
        core = w["text"].strip(",.;")
        if BLEU.match(core):
            spans.append(f'<span class="kb">{t}</span>')
        elif AMBRE.match(core):
            spans.append(f'<span class="ka">{t}</span>')
        else:
            spans.append(t)
    cap_html.append(f'      <div class="cap" id="cap-{n}"><span class="pill">{" ".join(spans)}</span></div>')
    s, u = round(c["start"], 3), round(c["until"], 3)
    cap_tw.append(
        f'tl.set("#cap-{n}",{{autoAlpha:1}},{s});'
        f'tl.fromTo("#cap-{n}",{{scale:.88,y:12}},{{scale:1,y:0,duration:.16,ease:"power2.out"}},{s});'
        f'tl.set("#cap-{n}",{{autoAlpha:0}},{u});')

template = open(f"{BASE}/template.tpl").read()
out = (template
       .replace("{{CAPTIONS_HTML}}", "\n".join(cap_html))
       .replace("{{CAPTIONS_TWEENS}}", "\n      ".join(cap_tw)))
open(f"{BASE}/index.html", "w").write(out)
print(f"{len(chunks)} blocs de sous-titres générés, index.html écrit.")
