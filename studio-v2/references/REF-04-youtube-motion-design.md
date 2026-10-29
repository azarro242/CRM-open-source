# REF-04 — Vidéo YouTube 16:9 « motion design éditorial + interfaces » (Oddysee)

Format reçu le 2026-10-29. Brief complet du client (direction V2, script intégral de 32 scènes) :
`REF-04-youtube-motion-design/BRIEF-CLIENT-V2.md`. Vidéos de référence et planches de photogrammes :
`REF-04-youtube-motion-design/videos/` et `planches/`.

## 1. Les trois références (analyse du 2026-10-29)

Toutes en 736 × 414, 30 i/s : elles servent de **langage visuel**, jamais de source à agrandir.

| Réf. | Fichier | Durée | Son | Ce qu'on voit |
|---|---|---|---|---|
| A | `ref-A-cartes-connexions.mp4` | 14,9 s | aucun | Fond dégradé violet/lilas avec halos ; cartes de verre blanches (icône + libellé + pastille noire « Wait 2 days ») reliées par des traits en arbre, la caméra glisse le long du flux ; le flux se resserre en colonne de nœuds ronds ; mosaïque de 6 visuels de campagnes ; les nœuds deviennent de gros points sur un trait, puis des boucles qui s'entrelacent ; fin « *Maximize* ⟳ ROI » (sérif italique + sans-sérif). |
| B | `ref-B-typo-interface.mp4` | 10,4 s | musique, sans voix | Fond blanc, halo violet en bas ; logo discret en haut à gauche ; phrase qui se construit mot à mot et glisse latéralement, avec un petit signe en étoile ; tableau de bord incliné en perspective qui se redresse ; gros plan sur une ligne (statut DRAFT + curseur) ; formulaire de paiement incliné, curseur qui clique sur les options (états violets) ; fin sur le bouton violet « Send for approval » et le clic, bord lumineux. |
| C | `ref-C-personne-systeme.mp4` | 74,4 s | **voix off anglaise + musique** (promo du produit « Flike ») | Portrait dans une pastille ronde, entouré d'icônes d'applications puis de petites fenêtres ; anneau coloré qui se referme et devient le logo ; rubans colorés qui traversent trois bulles (étapes) ; plusieurs sources reliées par des courbes vers un cercle central ; démonstrations d'interfaces (boîte mail, message, LinkedIn, WhatsApp, Slack) avec zooms et curseur ; ponctuation par un portrait expressif + mot géant « WOW » ; portrait central entouré d'autres portraits et cartes ; écran final logo + bouton « Try it for free today ». |

## 2. Concordance brief ↔ références ↔ outils du studio

| Mécanisme | Réf. | Réalisable dans HyperFrames | Comment |
|---|---|---|---|
| Fond continu dégradé + halos qui dérivent | A, B, C | Oui, à l'identique | Dégradés CSS + halos flous animés (GSAP), couleurs Oddysee |
| Cartes de verre, apparitions décalées, traits qui se tracent | A | Oui | HTML/CSS + tracé SVG (`stroke-dashoffset`) |
| Caméra qui glisse le long d'un flux | A, C | Oui | « Monde » plus grand que l'écran, translation/zoom du conteneur |
| Nœuds → boucles qui convergent, mot clé final | A | Oui | SVG animé, morphing de tracés |
| Phrase construite mot à mot, glissement latéral | B | Oui (déjà fait dans la série 60) | Typographie Outfit (+ sérif italique d'accent) |
| Interface inclinée en 3D qui se redresse, zoom sur une ligne | B, C | Oui | CSS `perspective` / `rotateX/Y` sur une **vraie capture** ou une interface reconstruite en HTML |
| Curseur, clic, changement d'état du bouton | B | Oui | Curseur SVG animé, pression du bouton, état violet |
| Portrait rond au centre, éléments en orbite | C | Oui | Photos détourées (ou mascottes) en pastille ; orbite GSAP |
| Rubans / courbes de plusieurs sources vers un centre | C | Oui | Tracés SVG en dégradé |
| Ponctuation portrait + mot géant | C | Oui | Comme la série 60 (zoom, mot en fond) |
| Écran final logo + bouton | B, C | Oui | Logo SVG Oddysee fourni |
| Sous-titres 2 lignes, SRT, version sans sous-titres | brief | Oui | Alignement de la voix (Whisper) → SRT ; deux rendus |
| Projet « éditable avec calques » | brief | Partiel | Le projet est en HTML (une couche par élément), modifiable par moi ; ce n'est **pas** un fichier Premiere ou After Effects |

## 3. Limites et éléments à fournir

- **À l'identique** = même grammaire de mouvement, même rythme et même qualité de finition, recomposés
  aux couleurs d'Oddysee. On ne reprend ni les logos ni les interfaces de Zelios, Flike ou des autres
  marques des références.
- Médias à fournir (sinon composition graphique simple, signalée) : vraies captures (site Oddysee, page de
  réservation, grille d'audit anonymisée), logos officiels Adidas, Puma, Montessori, Menara Mall (et l'accord
  de les montrer), justificatif Meta Business Partner et photos de Dublin, photos de l'équipe, de tournages
  et de projets, photos détourées ou choix des **mascottes** Oddysee pour les personnes, éventuels SVG ou PNG
  exportés depuis Illustrator (les `.ai` ne sont pas lus tels quels).
- Une face caméra filmée, si le client en veut, doit être fournie en vidéo : on ne peut pas l'inventer.
- Voix : fichier final du client (aucune voix provisoire). Le script fait environ 560 mots, soit environ
  3 min 30 à 4 min de voix.
- Rendu : 1920 × 1080, 30 i/s, monté par chapitres (S01–S09, S10–S15, S16–S22, S23–S32) puis assemblés,
  pour limiter le temps de rendu et faciliter les retouches.

## 4. Sous-titres (consigne du 2026-10-29)

Le client fournit le script et la voix off. Les sous-titres sont **intégrés à l'animation**, sur le modèle de
la réf. B : chaque phrase s'écrit mot à mot, calée sur la voix (horodatage Whisper), placée dans la scène à
côté de l'objet animé, mots clés en violet, sérif italique d'accent comme « *Maximize* ROI » (réf. A).

## 5. Projet modèle (2026-10-29)

`studio-v2/projets/oddysee-vsl-youtube/` : `build.py` (scènes calées sur les mots), `gabarit.tpl` (scènes S01–S32
regroupées en 16 sections), `realigner.py` (horodatage des voix longues), `mix.py` (voix, musique en boucle,
bruitages, −14 LUFS), `AFFECTATION.md` (tableau scène par scène), `FABRICATION.md` (médias, manques, à valider).
Fond clair = ciel du client flouté ; fond sombre = d'après la page d'accueil d'oddysee.fr.

## 6. Bibliothèque motion du client (2026-10-29) — ce qu'elle enseigne

Retour du client sur le premier VSL : trop de blanc, trop de vide, pas assez d'éléments explicatifs.
Cinq archives reçues, rangées dans `marque/oddysee/bibliotheque-motion/` (index : `INDEX.md`).

**Famille 1 — autocollants vintage tramés, recolorés violet `#632BC5` / blanc** (17 pièces, rawpixel) :
œil sur papier déchiré, microscope, main qui pointe, mains sur un ordinateur, pouce levé, loupe, trophée,
route, passeport, fiole, cadenas, maison, cœur anatomique, soleil, coupure de journal. Style « collage
éditorial » : trame demi-teinte, contour blanc épais d'autocollant. Usage : objet héros d'une scène
(main qui pointe vers un bouton, loupe sur l'audit, trophée pour l'expert, cadenas pour la capacité
limitée, route pour le parcours…), entrée en « autocollant collé » (petite rotation, rebond, ombre).

**Famille 2 — 3D « verre liquide », chrome et irisé** (≈ 215 images Pinterest, dédoublonnées) :
icônes et lettres en verre transparent, reflets arc-en-ciel, fonds unis noir, blanc ou dégradé bleu.
Beaucoup sont des logos de marques (OpenAI, Meta, Adidas, Nike, PlayStation, Mercedes…) ou des affiches
avec texte : **référence de style seulement**. Les objets génériques (sablier, bouclier coché, éclair,
coche, flamme, œil, bulle, maillons, cube, astérisque, fusée, avion en papier, enveloppe, dossier, étoile,
curseur, cible, point d'interrogation, globe…) sont détourés et réutilisables.

**Règles de composition tirées de la bibliothèque**
- Un objet héros par scène, grand (30 à 45 % de la hauteur), légèrement incliné, avec ombre portée douce.
- Fond jamais nu : dégradé + grain/trame léger, grand mot ou chiffre fantôme en arrière-plan, halos.
- Profondeur par couches : arrière-plan flou, objet héros net, cartes au premier plan, pastilles.
- Mélange assumé des deux familles : collage tramé violet pour l'humain et l'émotion (douleur,
  engagement), verre 3D pour la technique et la solution (parcours, audit, réservation).
- Mouvement permanent : l'objet héros flotte (lévitation lente), tourne de quelques degrés, reflet qui
  balaie le verre ; nouveauté visuelle toutes les 2 à 3 s.
- Droits : les fichiers rawpixel et Pinterest sont à vérifier avant tout usage publicitaire payant.
