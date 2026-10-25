"""Interface « copier-coller » de la publication, un onglet par réseau.

    python3 fabrique/interface.py
    → interface-copier-coller.html (page autonome) + 2-DESCRIPTIONS-RESEAUX.md (mêmes textes)

Les textes Instagram viennent de legende-instagram.txt et message-prive.txt ; les autres réseaux
sont écrits ici. La typographie française (espaces insécables) est appliquée automatiquement.
"""
import base64, json, os, re

ICI = os.path.dirname(os.path.abspath(__file__))
PUB = os.path.dirname(ICI)
F, N = " ", " "


def typo(texte):
    lignes = []
    for l in texte.strip("\n").splitlines():
        l = re.sub(r" ([;!?])", F + r"\1", l)
        l = re.sub(r" :(?=\s|$)", N + ":", l)
        l = l.replace("« ", "«" + N).replace(" »", N + "»")
        l = re.sub(r"(\d) (%|h\b|jours\b)", r"\1" + N + r"\2", l)
        lignes.append(l)
    return "\n".join(lignes)


def lire(nom):
    return open(os.path.join(PUB, nom), encoding="utf-8").read().strip()


ARTICLE = "https://www.oddysee.fr/blog/meta-ads-28-octobre-navigation-produit"


def lien(source, support):
    return f"{ARTICLE}?utm_source={source}&utm_medium={support}&utm_campaign=meta-28-octobre"


dm_instagram = lire("message-prive.txt")
dm_facebook = dm_instagram.replace("utm_source=instagram", "utm_source=facebook")

premier_commentaire = typo("""
📌 Le pas-à-pas complet, la méthode de test et la checklist : commente META et on t'envoie le guide en message privé.
""")
reponses_meta = [typo(t) for t in (
    "C'est envoyé en message privé 📩",
    "Guide envoyé, regarde tes messages 👀",
    "Envoyé ! Dis-nous si tu as une question",
)]

RESEAUX = [
    {
        "id": "instagram", "nom": "Instagram", "mode": "Réponse automatique",
        "blocs": [
            {"titre": "Légende", "ou": "Nouveau reel › Légende",
             "texte": lire("legende-instagram.txt"), "limite": 2200, "hashtags_max": 5, "premiere_ligne": 125},
            {"titre": "Premier commentaire, à épingler", "ou": "Sous le reel publié › Commenter, puis appui long › Épingler",
             "texte": premier_commentaire},
            {"titre": "Réponses publiques au mot META", "ou": "ManyChat › réponse au commentaire (les 3 en rotation)",
             "variantes": reponses_meta},
            {"titre": "Message privé envoyé", "ou": "ManyChat › message privé (ou à la main)",
             "texte": dm_instagram,
             "note": "Le lien ouvre l'article sur oddysee.fr. Il doit être en ligne avant la publication du reel."},
            {"titre": "Texte alternatif", "ou": "Paramètres avancés › Accessibilité › Texte alternatif",
             "texte": typo("Mascotte Oddysee qui tamponne « Faux » sur le 30 octobre : tes pubs Meta changent dès le mercredi 28."),
             "conseil": 125,
             "note": "Instagram ne propose pas toujours ce champ sur les reels. S'il n'apparaît pas, rien à faire : "
                     "les sous-titres de la vidéo la rendent déjà accessible."},
            {"titre": "Story de relais, avec sondage", "ou": "Story › partager le reel › autocollant Sondage",
             "texte": typo("Mercredi, tes pubs Meta changent. C'est réglé chez toi ?"),
             "variantes": [typo("Oui, c'est fait"), typo("Pas encore 😬")], "variantes_titre": "Réponses du sondage"},
        ],
    },
    {
        "id": "facebook", "nom": "Facebook", "mode": "Réponse automatique",
        "blocs": [
            {"titre": "Description du reel", "ou": "Page Facebook › Créer un reel › Description",
             "texte": typo("""
Le 30 octobre ? Repoussé. Mais mercredi 28, tes pubs Facebook et Instagram changent quand même 👇

Mercredi 28/10, Meta active la « navigation produit » par défaut sur les pubs déjà en ligne. Un clic sur ta pub peut ouvrir une page dans l'application… au lieu de ton site.

Les nouvelles conditions publicitaires arrivent le 20/11 (au lieu du 30/10). Ce que l'IA de Meta modifie dans tes pubs, c'est toi qui en réponds.

Avant mercredi, dans le Gestionnaire de publicités :
1. Choisis : couper, garder ou tester la navigation produit.
2. Teste 7 jours : une pub avec, une pub sans, et compare tes vraies ventes.
3. Relis ce que l'IA de Meta a changé dans tes pubs (Advantage+).

Meta annonce +3 % de conversions avec l'option. C'est son propre test : vérifie avec tes chiffres.

💬 Commente META : on t'envoie le guide complet en message privé, gratuit et sourcé.
👍 Suis la page : on surveille Meta pour toi.

#MetaAds #PubliciteFacebook #MarketingDigital
"""), "hashtags_max": 3,
             "note": "Publication croisée depuis Instagram ? La légende Instagram passe aussi. Celle-ci parle le langage "
                     "de Facebook (« Gestionnaire de publicités », « Suis la page », 3 hashtags)."},
            {"titre": "Premier commentaire, à épingler", "ou": "Sous le reel publié › ⋯ › Épingler",
             "texte": premier_commentaire},
            {"titre": "Réponses publiques au mot META", "ou": "ManyChat › réponse au commentaire (les 3 en rotation)",
             "variantes": reponses_meta},
            {"titre": "Message privé Messenger", "ou": "ManyChat › message Messenger (ou à la main)",
             "texte": dm_facebook,
             "note": "Même message qu'Instagram, avec un lien suivi « facebook » pour compter les visites venues d'ici."},
        ],
    },
    {
        "id": "tiktok", "nom": "TikTok", "mode": "Réponse à la main",
        "blocs": [
            {"titre": "Légende", "ou": "Publier › Description",
             "texte": typo("""
Meta a repoussé ses nouvelles conditions au 20 novembre. Mais mercredi 28 octobre, tes pubs Facebook et Instagram changent quand même 👇

La « navigation produit » s'active par défaut : un clic sur ta pub peut ouvrir une page dans Instagram au lieu de ton site.

Avant mercredi, dans Ads Manager :
1. Choisis : couper, garder ou tester.
2. Teste 7 jours : une pub avec, une pub sans.
3. Relis ce que l'IA de Meta a modifié dans tes pubs.

💬 Commente META : on te répond avec le guide gratuit (lien dans notre bio).

#metaads #publicitefacebook #instagramads #marketingdigital #entrepreneur
"""), "limite": 4000, "hashtags_max": 5},
            {"titre": "Lien à mettre dans la bio", "ou": "Profil › Modifier le profil › Site web",
             "texte": lien("tiktok", "bio"),
             "note": "Sur TikTok, les liens des légendes et des commentaires ne sont pas cliquables : le guide passe par la bio "
                     "le temps de la campagne."},
            {"titre": "Réponses aux commentaires META", "ou": "Sous chaque commentaire META › Répondre",
             "variantes": [typo(t) for t in (
                 "Le guide est en lien dans notre bio 🔗",
                 "C'est dans la bio : le guide complet, gratuit 👆",
                 "Lien dans la bio ! Dis-nous si tu bloques sur une étape",
             )],
             "note": "ManyChat ne propose pas la réponse automatique commentaire → message privé sur TikTok : on répond à la main. "
                     "Astuce : répondez en vidéo à l'un des premiers commentaires, TikTok la pousse comme un nouveau contenu."},
        ],
    },
    {
        "id": "linkedin", "nom": "LinkedIn", "mode": "Lien en commentaire",
        "blocs": [
            {"titre": "Texte du post", "ou": "Commencer un post › ajouter la vidéo › texte",
             "texte": typo("""
Meta a repoussé ses nouvelles conditions publicitaires au 20 novembre.
Beaucoup d'annonceurs en concluent qu'ils ont le temps.

Ils ont tort : mercredi 28 octobre, un autre changement s'applique.

La « navigation produit » s'active par défaut sur les publicités Facebook et Instagram déjà en ligne. Un clic sur l'annonce peut ouvrir une page produit dans l'application, au lieu du site de l'annonceur.

Meta annonce +3 % de conversions avec cette option. C'est le résultat de son propre test.

Ce que je recommande à nos clients avant mercredi :
→ décider publicité par publicité : couper, garder ou tester ;
→ tester 7 jours, une version avec et une sans, et comparer les ventes réelles ;
→ relire ce que l'IA de Meta modifie dans les créations (Advantage+). Avec les nouvelles conditions, l'annonceur en reste seul responsable.

J'ai réuni le pas-à-pas, la méthode de test et la checklist dans un guide sourcé (Meta, Reuters, Adweek). Le lien est en premier commentaire.

#MetaAds #MarketingDigital #Publicité
"""), "limite": 3000, "hashtags_max": 3,
             "note": "Écrit à la première personne, pour le profil d'Alvarez. Le lien reste hors du post : il va en premier commentaire."},
            {"titre": "Premier commentaire, avec le lien", "ou": "Sous le post publié › Commenter",
             "texte": typo("Le guide complet : pas-à-pas pour couper la navigation produit, test A/B en 7 jours, checklist et 12 sources 👉 ")
                      + lien("linkedin", "social")},
            {"titre": "Réponses aux commentaires", "ou": "Sous chaque commentaire › Répondre",
             "variantes": [typo(t) for t in (
                 "Merci ! Le guide est en premier commentaire 👆",
                 "Bonne question. Le pas-à-pas est dans le guide, en premier commentaire.",
             )]},
        ],
    },
]

AVANT = [
    {"id": "article", "texte": "Article en ligne, testé sur téléphone", "lien": ARTICLE},
    {"id": "pdf", "texte": "Guide PDF en ligne sur le site"},
    {"id": "auto", "texte": "Réponse automatique META testée (Instagram, Facebook)"},
    {"id": "couv", "texte": "Couverture « Faux » choisie"},
]
for a in AVANT:
    a["texte"] = typo(a["texte"])

# ---------------------------------------------------------------- page
couv = os.path.join(ICI, "img", "couverture-mini.jpg")
if not os.path.exists(couv):
    from PIL import Image
    im = Image.open(os.path.join(PUB, "couverture-reel.jpg")).convert("RGB")
    im.thumbnail((240, 427))
    im.save(couv, quality=72, optimize=True)
couv64 = base64.b64encode(open(couv, "rb").read()).decode()

donnees = json.dumps({"reseaux": RESEAUX, "avant": AVANT}, ensure_ascii=False).replace("</", "<\\/")
page = open(os.path.join(ICI, "interface-gabarit.html"), encoding="utf-8").read()
page = page.replace("{{DONNEES}}", donnees).replace("{{COUVERTURE}}", "data:image/jpeg;base64," + couv64)
open(os.path.join(PUB, "interface-copier-coller.html"), "w", encoding="utf-8").write(page)

# ---------------------------------------------------------------- même contenu en Markdown
md = ["# Descriptions par réseau — reel « Le 30 octobre ? Faux. »", "",
      "Tous les textes de `interface-copier-coller.html`, dans l'ordre de publication. "
      "Fichier généré par `python3 fabrique/interface.py` : modifier les textes dans ce script.", ""]
for r in RESEAUX:
    md += [f"## {r['nom']} — {r['mode'].lower()}", ""]
    for i, b in enumerate(r["blocs"], 1):
        md += [f"### {i}. {b['titre']}", f"*Où : {b['ou']}*", ""]
        if "texte" in b:
            md += ["```", b["texte"], "```", ""]
        for v in b.get("variantes", []):
            md += [f"- `{v}`"]
        if b.get("variantes"):
            md += [""]
        if b.get("note"):
            md += [f"> {b['note']}", ""]
open(os.path.join(PUB, "2-DESCRIPTIONS-RESEAUX.md"), "w", encoding="utf-8").write("\n".join(md))

for r in RESEAUX:
    for b in r["blocs"]:
        if "texte" in b:
            t = b["texte"]
            n = len(re.findall(r"#\w+", t))
            print(f"{r['nom']:9} {b['titre'][:34]:34} {len(t):5} car. · {n} hashtags")
