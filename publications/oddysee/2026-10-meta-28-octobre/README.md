# Publication « Meta Ads : ce qui change le 28 octobre » — kit complet

Reel Instagram + article de blog oddysee.fr + guide PDF, reliés par un seul lien :
chaque personne qui commente **META** reçoit en message privé l'adresse de l'article sur votre site.

```
Reel (commentaire « META ») ──► message privé ──► article oddysee.fr ──► audit offert (/contact)
                                                        └──► guide PDF à télécharger
```

## Contenu du dossier

| Fichier | À quoi il sert |
|---|---|
| `interface-copier-coller.html` | **Au moment de poster** : un onglet par réseau, un bouton « Copier » par bloc (`python3 fabrique/interface.py`) |
| `1-DESCRIPTION-POST.md` | Tout le texte du post : légende, premier commentaire, réponses automatiques, texte alternatif, couverture, suivi |
| `2-DESCRIPTIONS-RESEAUX.md` | Les versions Facebook, TikTok et LinkedIn (générées avec l'interface) |
| `legende-instagram.txt` | La légende seule, prête à copier-coller |
| `message-prive.txt` | Le message privé envoyé à chaque « META » (contient le lien de l'article) |
| `couverture-reel.jpg` | Image de couverture du reel |
| `article/article.html` | L'article complet, prêt à ouvrir dans un navigateur (aperçu fidèle) |
| `article/article-contenu.html` | Le corps de l'article seul, à coller dans le site |
| `article/article.md` | Le texte source de l'article |
| `article/SEO.md` | Fiche SEO : title, meta description, mots-clés, liens, textes alternatifs |
| `article/images/` | Les 8 images de l'article (WebP) + l'image de partage 1200 × 630 (JPG) |
| `guide/guide-meta-ads-oddysee.pdf` | Le guide PDF (10 pages) |
| `fabrique/` | L'atelier qui fabrique l'article, les visuels et le PDF (`python3 fabrique/fabriquer.py`) |

La vidéo elle-même est dans `studio-v2/exports/oddysee-meta-28-octobre-v2.mp4`.

## Ordre de publication (important)

L'article doit être **en ligne avant le reel** : sinon les premiers « META » reçoivent un lien mort.

1. **Dimanche 25/10 — mettre l'article en ligne** sur oddysee.fr
   1. Créer l'article à l'adresse exacte :
      `https://www.oddysee.fr/blog/meta-ads-28-octobre-navigation-produit`
      (c'est celle du message privé — ne pas la changer, ou mettre à jour `message-prive.txt`).
   2. Coller le corps de l'article (`article/article-contenu.html`) :
      WordPress → bloc « HTML personnalisé » ; systeme.io → élément « Code HTML ».
   3. Téléverser les images de `article/images/` et remplacer les chemins `images/…` par leur adresse sur le site.
   4. Renseigner le title et la meta description (dans `article/SEO.md`), l'image de partage
      `partage-1200x630.jpg` et l'auteur (Alvarez Mouko).
   5. Téléverser le PDF à l'adresse `/guides/guide-meta-ads-oddysee.pdf` (lien en bas de l'article).
   6. Vérifier les deux liens maison :
      `/contact` (bouton « Je réserve mon audit Meta Ads offert ») et `/web` (offre de site en 7 jours).
   7. Ouvrir l'article sur téléphone et cliquer chaque lien une fois.
2. **Avant le reel — brancher la réponse automatique** (voir plus bas) et la tester avec un compte ami.
3. **Lundi 26/10 vers 12 h — publier le reel** avec `legende-instagram.txt`, la couverture et le texte alternatif,
   puis épingler le premier commentaire (`1-DESCRIPTION-POST.md`, section 3).
4. **Mercredi 28/10** — story de rappel « C'est aujourd'hui » avec le lien de l'article.

## Réponse automatique aux commentaires « META »

Avec **ManyChat** (Instagram, offre gratuite suffisante) :

1. Automatisation › « Commentaire sur un post ou un reel » › choisir ce reel.
2. Mot-clé : `META` (et ses variantes `meta`, `Méta`).
3. Réponse publique au commentaire : une des 3 variantes de `1-DESCRIPTION-POST.md` (section 4), en rotation.
4. Message privé : le texte de `message-prive.txt`, avec le lien en bouton « Je lis le guide ».

Sans outil : répondre à la main au commentaire puis envoyer `message-prive.txt` en message privé.
Le lien contient des paramètres UTM (`utm_source=instagram&utm_medium=dm`) : les visites venues du reel
apparaissent séparément dans Google Analytics.

## Sources et images

- 12 sources externes citées en lien dans l'article (Meta, Reuters, Adweek, PPC Land…), listées en fin d'article.
- Photos : Swello, Carlos Muza et Austin Distel sur Unsplash — licence Unsplash
  (utilisation commerciale autorisée, crédit affiché sous chaque photo).
- Schémas et visuels : créés par Oddysee aux couleurs de la marque.

## Mettre à jour l'article ou le guide

Modifier `article/article.md`, puis relancer :

```bash
python3 fabrique/fabriquer.py
```

L'article, la fiche SEO et le PDF sont régénérés ensemble. Si un schéma change (`fabrique/graphiques.html`),
lancer d'abord `node fabrique/rendu.mjs visuels`.
