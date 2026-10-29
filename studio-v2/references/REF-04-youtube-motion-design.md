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

## 7. Références 3D « verre givré » (archives AF et AF2, 2026-10-29)

46 compositions haut de gamme (cartes translucides en éventail, objets en verre et chrome, rubans irisés,
cercles de verre concentriques, grappes d'icônes autour d'une main ou d'un objet, interfaces en verre
isométriques, cartes bancaires et cadenas en verre). Planches : `marque/oddysee/bibliotheque-motion/planches/
reference-3d-AF*.jpg`. Ce sont des **références de style** (marques et textes d'autrui) : on reprend les
procédés, pas les images.

Procédés reproduits dans HyperFrames (CSS 3D, flou d'arrière-plan, dégradés coniques, SVG) :
- éventail de cartes translucides qui s'ouvre et se referme (profondeur, flou décroissant) ;
- panneaux « verre givré » (`backdrop-filter: blur`, liseré clair, reflet en diagonale qui balaie) ;
- rubans et bandes irisés qui se dessinent et traversent la scène ;
- cercles de verre concentriques qui se superposent (transitions) ;
- grappe d'icônes en orbite autour d'un objet héros, parallaxe lente ;
- interfaces posées en perspective isométrique, puis redressées.

Objets 3D supplémentaires : Adobe Stock via le connecteur Adobe (compte du client, licence obtenue avant
usage, contenus « free » de préférence), détourés et teintés aux couleurs Oddysee. Pas de génération d'images
Firefly dans cet environnement.

## 8. Modèle principal à dupliquer : la réf. C, plan par plan (consigne du 2026-10-29)

Le client a renvoyé la réf. C (`videos/ref-C-personne-systeme.mp4`, 74 s) comme **modèle d'interactions et
d'animations à dupliquer** avant la nouvelle version. Planches à 2 images/s : `planches/ref-C-detail-*.jpg`.

**Constat clé : une seule coupe franche en 74 s (à 62,5 s).** Tout le reste est une seule caméra continue :
chaque élément se transforme en élément suivant.

| Temps | Ce qui se passe | Procédé |
|---|---|---|
| 0–4 s | Halo bleu flou, ondes concentriques ; portrait rond qui jaillit avec un anneau coloré ; icônes d'applications (carrés blancs arrondis) qui arrivent des bords | Apparition « pop », orbite, zoom lent permanent |
| 2–8 s | Pastilles rouges de notifications qui **comptent** (1 → 15) ; même personne, autre expression (main au menton) | Compteurs animés = surcharge ; changement d'expression par fondu |
| 8–10 s | Petites cartes (e-mails, « relance en attente ») envahissent l'espace autour du portrait | Densité croissante = douleur |
| 10–13 s | L'anneau du logo (quatre arcs de couleur) se referme sur le portrait, le reste s'efface ; les arcs **s'envolent en traînées** puis se réassemblent en logo ; le nom s'écrit lettre à lettre | Logo = outil de transition (ouverture et fermeture) |
| 13–19 s | Le logo se dénoue en rubans de couleur qui s'emmêlent puis se tendent en une ligne ; la ligne ondule ; des cercles **montent le long de la vague** (tache de couleur → bulle blanche + icône + libellé) | Chemin à étapes ; la caméra suit la ligne |
| 19–26 s | Faisceaux blancs qui convergent de gauche à droite : icônes des sources au départ, cercle central « vue 360 » à l'arrivée ; les faisceaux se resserrent en un seul rayon, le cercle devient « IA » | Convergence (plusieurs sources → un résultat) |
| 26–32 s | **Volet de couleur** (dalle rouge puis bleue) qui balaie l'écran et dévoile une grande fenêtre d'application ; le contenu se remplit par blocs | Transition par volet ; remplissage progressif |
| 32–36 s | Boîte mail : **zoom fort** sur deux lignes surlignées, arrière-plan agrandi et flou ; curseur qui survole et clique | Profondeur de champ + curseur |
| 36–42 s | Fil d'e-mail, brouillon qui s'écrit ; la carte de réponse grossit au premier plan ; clic sur « Insérer » → **confettis** | Gros plan sur l'action + récompense |
| 42–52 s | Carrousel de fenêtres (LinkedIn, messagerie, Slack) : chaque fenêtre entre par la droite pendant que la précédente recule floutée à gauche ; badge de marque en coin ; messages qui s'écrivent | Carrousel en profondeur |
| 52–56 s | **Rupture** : mot géant « WOW » en contour qui défile derrière ; portrait expressif qui grossit jusqu'à remplir l'écran | Rupture de rythme toutes les 10–15 s |
| 56–62 s | Liste « relances prêtes à envoyer » qui se remplit ; curseur sur les lignes | Zoom avant + survol |
| 62,5 s | Seule coupe : gros plan sur une carte d'e-mail, puis recul | — |
| 64–68 s | Deuxième personne au centre, cartes de messages en orbite, puis autres visages autour | Réseau humain |
| 68–74 s | L'anneau du logo se referme à nouveau sur le portrait (**rime avec l'ouverture**), traînées, logo, nom lettre à lettre, bouton « Try it for free today » + adresse ; curseur, clic, maintien | Écran final avec clic |

**Règles à appliquer au VSL Oddysee**
1. Caméra continue : pas de fondus enchaînés entre « diapositives » ; chaque scène naît d'un élément de la
   précédente (anneau, ligne, carte, cercle). Coupe franche seulement pour une rupture voulue.
2. Le logo Oddysee (étoile à quatre branches) joue le rôle de l'anneau Flike : ses quatre branches se
   séparent en traînées violettes et se réassemblent ; ouverture, passage « Chez Oddysee » et fin.
3. Profondeur de champ permanente : arrière-plan agrandi et flou, sujet net, zoom lent continu (3 à 5 %).
4. Densité : nouvel élément toutes les 0,5 à 1 s ; compteurs qui montent ; cartes qui s'accumulent.
5. Lignes et faisceaux comme fil conducteur entre les idées (parcours, convergence vers l'audit).
6. Interfaces : volet coloré pour entrer, remplissage par blocs, zoom fort sur la ligne utile, curseur, clic
   récompensé (confettis, coche, pulsation).
7. Rupture de rythme toutes les 10 à 15 s : grand mot en contour qui défile + visage expressif.
8. Écran final qui rime avec l'ouverture : même anneau ou même portrait, bouton, clic.

## 9. Réf. D — tableau de bord animé, pour les résultats et l'écosystème (2026-10-29)

`videos/ref-D-ecosysteme.mp4` (20 s, 1280 × 960, 60 i/s) ; planche `planches/ref-D-ecosysteme.jpg`.
Consigne du client : à intégrer **à côté des explications**, dans la partie qui exprime les résultats ou le
processus d'écosystème mis en place par Oddysee.

Ce qu'on voit : une interface d'analyse blanche et violette (barre latérale, indicateurs chiffrés, histogrammes,
courbe, tableau). Ouverture sur une mosaïque d'écrans qui se resserre sur un seul ; histogrammes qui poussent
barre par barre ; **zooms successifs** sur une zone (indicateurs, courbe) ; curseur qui survole un point de la
courbe et ouvre une infobulle ; passage d'un écran à l'autre (analyse → gestion) par glissement ; tableau qui se
remplit ligne par ligne ; fin en recul sur une mosaïque d'écrans en perspective.

Usage dans le VSL : écran de suivi Oddysee reconstruit en HTML (couleurs Oddysee, chiffres **illustratifs**
mentionnés comme tels, jamais présentés comme des résultats réels), placé à côté du texte animé, pour le
parcours (S14), les effets concrets (S09) ou le diagnostic de l'audit (S27–S28).
