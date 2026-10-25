#!/usr/bin/env python3
"""Fabrique l'article (HTML + fragment CMS + fiche SEO) et le guide PDF depuis article/article.md.

  python3 fabrique/fabriquer.py

Étapes : typographie française → Markdown → HTML ; images optimisées (WebP, JPG de partage) ;
données structurées (Article, FAQ) ; guide A4 imprimé par Chromium (couverture + contenu + pied de page).
"""
import html, json, os, re, subprocess, sys
import markdown
from PIL import Image

ICI = os.path.dirname(os.path.abspath(__file__))
RACINE = os.path.dirname(ICI)
ART = os.path.join(RACINE, "article")
N, F = " ", " "   # espace insécable (avant « : », dans « ») · fine insécable (avant ; ! ?)


def typo(ligne):
    ligne = re.sub(r" ([;!?])", F + r"\1", ligne)
    ligne = re.sub(r" :(?=\s|$)", N + ":", ligne)
    ligne = ligne.replace("« ", "«" + N).replace(" »", N + "»")
    ligne = re.sub(r"(\d) (%|h\b|minutes\b|jours\b)", r"\1" + N + r"\2", ligne)
    ligne = re.sub(r"(\d) (\d{3})\b", r"\1" + N + r"\2", ligne)      # 117 700
    return ligne


# ---------------------------------------------------------------- source
brut = open(os.path.join(ART, "article.md"), encoding="utf-8").read()
_, entete, corps = brut.split("---", 2)
meta = dict(l.split(": ", 1) for l in entete.strip().splitlines())
meta = {k: typo(v) for k, v in meta.items()}
lignes, dans_code = [], False
for l in corps.strip().splitlines():
    if l.startswith("```"):
        dans_code = not dans_code
        lignes.append(l)
        continue
    lignes.append(l if dans_code else typo(l))
corps = "\n".join(lignes)

md = markdown.Markdown(extensions=["md_in_html", "fenced_code", "attr_list", "tables", "sane_lists"])
contenu = md.convert(corps)
# liens externes : nouvel onglet, sans transmettre de jeton
contenu = re.sub(r'<a href="(https?://(?!www\.oddysee\.fr)[^"]+)"', r'<a href="\1" target="_blank" rel="noopener"', contenu)

# ---------------------------------------------------------------- images
IMG = os.path.join(ART, "images")
SRC_PHOTOS = os.path.join(ICI, "img")
for nom in ("telephone-fil", "tableau-de-bord", "telephone-ordinateur"):
    im = Image.open(os.path.join(SRC_PHOTOS, nom + ".jpg")).convert("RGB")
    if nom == "telephone-fil":                      # photo verticale → recadrage 16:9 centré sur l'écran
        h = int(im.width * 9 / 16)
        haut = int(im.height * 0.30)
        im = im.crop((0, haut, im.width, haut + h))
    im.thumbnail((1600, 1600))
    im.save(os.path.join(IMG, nom + ".webp"), "WEBP", quality=82, method=6)
for f in os.listdir(IMG):
    if f.endswith(".png"):
        im = Image.open(os.path.join(IMG, f)).convert("RGB")
        im.save(os.path.join(IMG, f[:-4] + ".webp"), "WEBP", quality=88, method=6)
        if f.startswith("partage"):
            im.save(os.path.join(IMG, f[:-4] + ".jpg"), "JPEG", quality=88, optimize=True)
images = sorted(re.findall(r'<img alt="([^"]*)" src="([^"]+)"', contenu), key=lambda x: x[1])

# ---------------------------------------------------------------- données structurées
faq = []
for q, r in re.findall(r"<h3>(.*?)</h3>\s*<p>(.*?)</p>", contenu, re.S):
    faq.append({"@type": "Question", "name": html.unescape(re.sub("<.*?>", "", q)),
                "acceptedAnswer": {"@type": "Answer", "text": html.unescape(re.sub("<.*?>", "", r))}})
h1 = html.unescape(re.search(r"<h1>(.*?)</h1>", contenu).group(1))
image_abs = "https://www.oddysee.fr/images/blog/meta-ads-28-octobre/partage-1200x630.jpg"
schema = [
    {"@context": "https://schema.org", "@type": "BlogPosting", "headline": h1, "description": meta["meta_description"],
     "image": image_abs, "datePublished": meta["date"], "dateModified": meta["date"], "inLanguage": "fr",
     "mainEntityOfPage": meta["url"],
     "author": {"@type": "Person", "name": meta["auteur"], "url": "https://www.oddysee.fr/a-propos"},
     "publisher": {"@type": "Organization", "name": "Oddysee", "url": "https://www.oddysee.fr/"}},
    {"@context": "https://schema.org", "@type": "FAQPage", "mainEntity": faq},
]
jsonld = "\n".join(f'<script type="application/ld+json">{json.dumps(s, ensure_ascii=False)}</script>' for s in schema)

# ---------------------------------------------------------------- fragment CMS + page complète
open(os.path.join(ART, "article-contenu.html"), "w", encoding="utf-8").write(contenu + "\n")
STYLE = """
:root { --violet: #632bc5; --violet-pale: #a877ff; --lilas: #e2d7f7; --brume: #f7f3ff; --or: #f0c860; --encre: #1d1d1d; --gris: #6f6a7a; }
@font-face { font-family: Outfit; font-weight: 400 900; src: url("../fabrique/polices/Outfit-400-latin.woff2") format("woff2"); }
@font-face { font-family: Outfit; font-weight: 800; src: url("../fabrique/polices/Outfit-800-latin.woff2") format("woff2"); }
@font-face { font-family: Outfit; font-weight: 900; src: url("../fabrique/polices/Outfit-900-latin.woff2") format("woff2"); }
* { box-sizing: border-box; }
body { margin: 0; background: #fff; color: var(--encre); font: 400 18px/1.65 Outfit, system-ui, sans-serif; }
main { max-width: 760px; margin: 0 auto; padding: 32px 16px 80px; }
h1 { font-weight: 900; font-size: clamp(34px, 7vw, 54px); line-height: 1.05; margin: 8px 0 12px; }
h2 { font-weight: 900; font-size: clamp(26px, 5vw, 34px); line-height: 1.15; margin: 48px 0 12px; }
h3 { font-weight: 800; font-size: 21px; margin: 28px 0 6px; }
p, li { max-width: 68ch; }
a { color: var(--violet); font-weight: 600; }
img { display: block; width: 100%; height: auto; border-radius: 18px; margin: 22px 0 6px; }
.meta-article, .credit, .petit { color: var(--gris); font-size: 15px; }
.credit { margin-top: 0; }
.essentiel { background: var(--brume); border-left: 6px solid var(--violet); border-radius: 14px; padding: 6px 22px; margin: 22px 0; }
blockquote { margin: 24px 0; padding: 14px 22px; border-radius: 14px; background: var(--encre); color: #fff; font-weight: 700; }
blockquote p { margin: 0; }
pre { background: var(--encre); color: #e9e4f3; padding: 18px 20px; border-radius: 14px; overflow-x: auto; font-size: 15px; }
.checklist { list-style: none; padding: 0; }
.checklist li { position: relative; padding: 8px 0 8px 40px; border-bottom: 1px dashed var(--lilas); }
.checklist li::before { content: ""; position: absolute; left: 0; top: 11px; width: 22px; height: 22px; border: 3px solid var(--violet); border-radius: 6px; }
.cta { margin: 48px 0; padding: 8px 24px 20px; border-radius: 22px; background: var(--brume); text-align: center; }
.cta h2 { margin-top: 24px; }
.bouton { display: inline-block; min-height: 52px; padding: 15px 28px; border-radius: 14px; background: var(--violet); color: #fff;
  font-weight: 800; text-decoration: none; }
"""
page = f"""<!doctype html>
<html lang="fr">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>{html.escape(meta["titre_seo"])}</title>
<meta name="description" content="{html.escape(meta["meta_description"])}" />
<link rel="canonical" href="{meta["url"]}" />
<meta property="og:type" content="article" />
<meta property="og:title" content="{html.escape(h1)}" />
<meta property="og:description" content="{html.escape(meta["meta_description"])}" />
<meta property="og:url" content="{meta["url"]}" />
<meta property="og:image" content="{image_abs}" />
<meta property="og:locale" content="fr_FR" />
<meta name="twitter:card" content="summary_large_image" />
{jsonld}
<style>{STYLE}</style>
</head>
<body><main>
{contenu}
</main></body>
</html>
"""
open(os.path.join(ART, "article.html"), "w", encoding="utf-8").write(page)

# ---------------------------------------------------------------- fiche SEO
texte = re.sub(r"<[^>]+>", " ", contenu)
mots = len(re.findall(r"\w+", texte))
liens = [html.unescape(l) for l in re.findall(r'href="([^"]+)"', contenu)]
internes = [l for l in liens if "oddysee.fr" in l or l.startswith("/")]
externes = sorted(set(l for l in liens if l not in internes))
seo = f"""# Fiche SEO — article « {h1} »

| Élément | Valeur | Contrôle |
|---|---|---|
| URL (slug) | `{meta["url"]}` | mot-clé principal dans l'adresse |
| Balise title | {meta["titre_seo"]} | {len(meta["titre_seo"])} caractères (≤ 60) |
| Meta description | {meta["meta_description"]} | {len(meta["meta_description"])} caractères (150–160) |
| H1 | {h1} | {len(h1.split())} mots (≤ 10) |
| Longueur | {mots} mots | 6 sections + checklist + FAQ |
| Mot-clé principal | Meta Ads 28 octobre · navigation produit | dans le title, le H1, l'URL, l'intro, un H2 |
| Mots-clés secondaires | Advantage+, nouvelles conditions Meta, robots.txt Meta, API de conversions, test A/B | répartis dans les H2 |
| Liens internes | {len(internes)} | {", ".join(sorted(set(internes)))} |
| Liens externes (sources) | {len(externes)} | ouverture dans un nouvel onglet, `rel="noopener"` |
| Images | {len(images)} | toutes avec texte alternatif ; WebP ; image de partage 1200 × 630 en JPG |
| Données structurées | BlogPosting + FAQPage ({len(faq)} questions) | dans le `<head>` de `article.html` |

## À adapter au moment de la publication
- Téléverser les images de `article/images/` et remplacer les chemins `images/…` par leur adresse sur le site.
- Mettre l'adresse définitive de l'image de partage dans `og:image` et dans les données structurées
  (prévue : `{image_abs}`).
- Téléverser `guide/guide-meta-ads-oddysee.pdf` à l'adresse `/guides/guide-meta-ads-oddysee.pdf` (lien en fin d'article).
- Vérifier que `https://www.oddysee.fr/contact` est bien la page de prise de rendez-vous (bouton « Je réserve mon audit… »).

## Images et textes alternatifs
""" + "\n".join(f"- `{s}` — {html.unescape(a)}" for a, s in images) + "\n"
open(os.path.join(ART, "SEO.md"), "w", encoding="utf-8").write(seo)

# ---------------------------------------------------------------- guide PDF
# images du guide en JPEG (Chromium les intègre telles quelles : PDF léger)
GI = os.path.join(ICI, "guide-img")
os.makedirs(GI, exist_ok=True)
for f in os.listdir(IMG):
    if f.endswith(".webp"):
        im = Image.open(os.path.join(IMG, f)).convert("RGB")
        im.thumbnail((1400, 1400))
        im.save(os.path.join(GI, f[:-5] + ".jpg"), "JPEG", quality=80, optimize=True, progressive=True)
m = Image.open(os.path.join(ICI, "img", "03-femme-victoire.webp"))
m.thumbnail((520, 780))
m.save(os.path.join(ICI, "img", "mascotte-couverture.png"), optimize=True)
guide_corps = re.sub(r'src="images/([^"]+)\.webp"', r'src="guide-img/\1.jpg"', contenu)
guide_corps = re.sub(r'<p class="petit">.*?</p>', "", guide_corps, flags=re.S)
# version imprimée : sans la photo décorative de la partie 6 ni l'image de la checklist (la liste à cocher suffit)
guide_corps = re.sub(r'<p><img alt="[^"]*" src="guide-img/telephone-ordinateur\.jpg" />\s*</p>\s*<p class="credit">.*?</p>', "",
                     guide_corps, flags=re.S)
guide_corps = re.sub(r'<p><img alt="[^"]*" src="guide-img/checklist-meta-ads\.jpg" /></p>', "", guide_corps)
guide_corps = re.sub(r"<h1>.*?</h1>\s*<p class=\"meta-article\">.*?</p>", "", guide_corps, flags=re.S)
guide = open(os.path.join(ICI, "guide-gabarit.html"), encoding="utf-8").read().replace("{{CONTENU}}", guide_corps)
open(os.path.join(ICI, "guide.html"), "w", encoding="utf-8").write(guide)
subprocess.run(["node", os.path.join(ICI, "rendu.mjs"), "guide"], check=True)
from pypdf import PdfWriter
sortie = PdfWriter()
for morceau in ("couverture.pdf", "contenu.pdf"):
    sortie.append(os.path.join(ICI, morceau))
sortie.add_metadata({"/Title": "Les bonnes pratiques Meta Ads — Oddysee", "/Author": "Oddysee",
                     "/Subject": "Navigation produit (28 octobre 2026) et nouvelles conditions Meta (20 novembre 2026)"})
with open(os.path.join(RACINE, "guide", "guide-meta-ads-oddysee.pdf"), "wb") as f:
    sortie.write(f)
for morceau in ("couverture.pdf", "contenu.pdf"):
    os.remove(os.path.join(ICI, morceau))

print(f"Article : {mots} mots · {len(images)} images · {len(externes)} sources · FAQ {len(faq)} questions")
print(f"title {len(meta['titre_seo'])} car. · description {len(meta['meta_description'])} car.")
