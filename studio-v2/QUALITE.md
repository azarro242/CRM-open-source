# Studio V2 — Exigences qualité

Ce fichier fixe le niveau de qualité attendu. Il se compose de deux parties :
les **acquis de la V1** (leçons déjà validées par le client) et les **éléments
d'amélioration V2** fournis par le client. Les deux s'appliquent à chaque projet.

---

## Partie 1 · Acquis de la V1 — à appliquer systématiquement

### Mise en page
- **Zones de sécurité Instagram / TikTok (9:16)** : aucun élément important au-dessus de
  170 px (barre d'état, boutons) ni sous 1640 px (pseudo, légende, barre de commentaire).
- **Calque à écran partagé** : partage **50/50** — séparation centrée sur 960 px.
- **Séparation entre zones** : **dégradé droit** noir → transparent.
  Jamais de courbe, jamais de trait visible.
- Les sous-titres ne recouvrent **jamais** le visage du présentateur.

### Typographie
- Les mots ne se coupent **jamais** en fin de ligne (animation lettre par lettre comprise :
  regrouper les lettres par mot insécable).
- Aucun caractère parasite (antislash, entités HTML) : relire chaque texte à l'écran.

### Animation
- Les calques transparents utilisent des apparitions **opaques** (échelle, glissement) —
  pas de fondu d'opacité, qui laisse des pixels semi-transparents.
- Curseurs, flashs et surbrillances se calent sur la **position à l'écran** de l'élément
  visé (tenir compte du défilement de la page), jamais sur sa position dans la page.
- Aucune durée d'affichage trop courte : un élément reste visible au moins ~0,5 s.

### Contenu
- Transcription : corriger les noms de marque mal entendus (ex. « Cloud Code » →
  Claude Code, « Tiat GPT » → ChatGPT) et signaler au client tout passage douteux.
- Charte : utiliser la **vraie** identité du client (couleurs, police, logo extraits de
  son site) plutôt qu'une palette inventée.

### Technique
- Polices et bibliothèques **vendorisées en local** (les CDN sont bloqués au rendu).
- Une source d'image distincte par apparition (un même fichier réutilisé peut rendre blanc).
- Effets sonores sur des pistes séparées : aucun chevauchement sur une même piste.

---

## Partie 2 · Éléments d'amélioration V2 — fournis par le client

> Chaque élément reçu est ajouté ici, daté, avec sa règle d'application concrète.

### [2026-10-14] Voix off : ElevenLabs ou fichier audio
- Consigne du client : « deux possibilités, soit générer la voix off grâce au modèle
  ElevenLabs […] proposer la liste des noms des voix sur la langue choisie, du meilleur
  au moins bon, l'utilisateur n'aura qu'à sélectionner le nom de la voix — ou fournir
  un fichier audio ».
- Règle d'application : la question Q2 propose exactement ces deux choix. Si ElevenLabs :
  liste classée produite par `outils/elevenlabs.py voix`, présentée avec lien d'écoute,
  sélection du nom par le client, génération en `eleven_v4`, sous-titres calés sur
  l'horodatage fourni par ElevenLabs. Détail : `PROTOCOLE.md` § 2, Q2.

### [2026-10-16] Référence de style : vidéo de Maxence Tison
- Consigne du client : « je voudrais que les vidéos puissent se ressembler »
  (https://youtu.be/DBQqB8eqpFI). Analyse complète : `references/REF-01-maxence-tison.md`.
- Règles d'application :
  - **Direction artistique du type « Publicité de marque »** (sauf charte du client qui
    l'emporte) : fonds clairs crème, cartes arrondies à ombres douces, titres sans-serif très
    gras avec le mot clé en serif italique souligné, sur-titres en petites capitales
    espacées, accent jaune pour pastilles, surlignages et badges. Cartes sombres possibles
    pour les chiffres choc.
  - **Script publicitaire en 5 temps**, 15 à 40 s : accroche (problème ou chiffre choc) →
    révélation de la marque → une idée par phrase courte, chacune avec son animation →
    preuve chiffrée → appel à l'action + signature. Ne pas allonger sans raison.
  - **Synchronisation voix ↔ image au mot près** : chaque action montrée à l'écran tombe sur
    le mot qui la nomme.
  - **Montrer le produit en usage** (interface qui s'anime, action réelle), pas seulement
    l'énoncer.
  - **Interdits** : texte posé sur un autre texte, texte tronqué au bord du cadre, texte sur
    image sans fond de lecture, sur-animation. Sobriété et lisibilité avant la quantité
    d'effets.
  - **Script validé** par le client avant la génération ; **retours horodatés** acceptés et
    appliqués au timecode près.

### [2026-10-20] Deuxième type de contenu : reel éducatif « faceless » (FUNL)
- Consigne du client : six reels de @agencefunl, « un autre type de contenu motion design »
  à ajouter à la base d'apprentissage. Analyse complète : `references/REF-02-funl-visibilite-ia.md`.
- Règles d'application **pour ce type** (9:16, 60 à 115 s) :
  - **Système visuel** : fond gris sauge `#A8B0A0` avec trame de points et vignettage,
    accent unique citron `#DFF25D`, cartes ardoise, titres en capitales condensées très
    grasses. Variante possible : collage vintage sur papier texturé.
  - **Mascotte** : grande tête en photo noir et blanc sur corps en bâton, expressive,
    présente tout au long de la vidéo.
  - **Sous-titres karaoké** : le mot prononcé passe en encadré citron.
  - **Chaque chiffre affiché porte sa source** (pastille en bas de cadre) ; étiqueter
    « CAPTURE RÉELLE », « RECONSTITUTION » ou « EXEMPLE » selon le cas.
  - **Écriture en 9 temps** : accroche datée → retournement → verrou de rétention (« reste
    jusqu'au bout ») → contexte sourcé → le détail que personne n'a lu → appel au partage
    **avant** le plan → plan d'action numéroté (pas ça / plutôt ça) → promesse tenue →
    signature + dernière phrase qui reprend l'accroche (**boucle**).
  - **Enchaînement continu** par animation, sans coupe franche ; musique de fond permanente.
- Règle **pour tous les types** : mixage final normalisé à **−14 LUFS** intégrés, crête
  ≤ −1 dBTP (mesuré à l'identique sur les six vidéos de référence).

### [2026-10-24] Vidéos de l'agence Oddysee : mascottes, ressources, voix, durée
- Consignes du client :
  - « Les illustrations qui vont te servir pour la création de contenu pour les vidéos de notre
    agence […] je vais t'en rajouter d'autres […] par groupe de cinq » — mascottes tête photo
    N&B sur corps en bâton **violet** (femme bouclée, homme moustachu, homme gominé) + un
    personnage collage en costume violet.
  - « les liens dans lesquels tu trouveras les différentes ressources pour chacune des vidéos
    en fonction du script et du sujet » — oddysee.fr (accueil, web, à propos, services).
  - Voix off : ElevenLabs, voix **« Oxley - Evil Character »**.
  - « la vidéo devra durer une moyenne de 25 secondes » ; s'appuyer sur les modèles fournis.
- Règles d'application **pour toute vidéo Oddysee** (détail : `marque/oddysee/FICHE-MARQUE.md`) :
  - Lire `marque/oddysee/FICHE-MARQUE.md` et `marque/oddysee/mascottes/INDEX.md` avant
    d'écrire le script ; ne prendre que les faits de la fiche, chacun avec sa source.
  - **Mascottes Oddysee** présentes tout au long de la vidéo, émotion choisie selon le temps du
    script (table « quel moment » de l'index), changement d'expression au mot près.
  - **Durée ≈ 25 s** (55 à 65 mots) : gabarit en 5 temps de la fiche (accroche → retournement →
    solution Oddysee → preuve sourcée → appel à l'action + logo).
  - **Système visuel REF-02 aux couleurs d'Oddysee** : violet `#632BC5` remplace le citron
    comme accent unique (karaoké, chiffres) ; fond clair brume `#F7F3FF` à trame de points
    proposé par défaut, à confirmer par le client sur la première vidéo ; police Outfit.
  - **Voix** : Oxley, `voice_id 2gPFXx8pN3Avh27Dw5Ma`, générée en français — la question Q2
    n'est plus posée pour Oddysee. Faire valider un premier essai (voix anglophone, accent
    possible) avant de monter toute la vidéo.
  - **Jamais de résultat chiffré promis** (Oddysee l'écrit elle-même : interdit par Meta) ;
    les chiffres montrés sont ceux du site, avec pastille de source.
  - Nouveau lot de mascottes reçu → l'ajouter à l'index dans le même tour.

### [2026-10-24] Script repris d'une vidéo existante : plus viral, selon l'actualité
- Consigne du client : « à partir de cette vidéo […] un script qui parle du même sujet avec
  une meilleure fréquence de viralité en fonction de la tendance actuelle autour de Meta ».
- Règles d'application :
  - **Revérifier chaque fait le jour de l'écriture** (sources datées dans
    `sources/<projet>/SOURCES.md`) : la vidéo de départ peut déjà être dépassée — c'est
    souvent là qu'est l'angle (ex. : date du 30/10 repoussée au 20/11 la veille).
  - **Apporter ce que la vidéo d'origine n'a pas** : mise à jour, démenti sourcé, urgence
    datée, version plus courte. Ne jamais copier sa structure phrase à phrase.
  - **Accroche ≤ 3 s** qui contredit ou surprend ; **une seule action** dans la vidéo, le
    détail pas à pas va dans la **légende** (fournie avec le script).
  - **Appel au partage ciblé** (« envoie ça à qui… ») en fin de vidéo ; mot-clé pour
    WhatsApp / commentaires dans la légende pour générer des demandes.
  - Rester juste envers la plateforme (Oddysee est Meta Business Partner) : citer les
    chiffres de Meta avec leur source, proposer de tester plutôt que de diaboliser.
  - Livrer **2 accroches de rechange** pour un test, et la **date limite de publication**
    quand le sujet est daté.

### [2026-10-24] Musique fournie : c'est elle qui donne le rythme
- Consigne du client : « fais en sorte que cette musique en arrière-plan puisse donner le rythme à
  notre vidéo, donc fais une réécriture complète de la vidéo sur la base de cet audio […] fais une
  étude minutieuse et si cela implique de modifier le script, redonne-moi un nouveau script ».
- Règles d'application :
  - **Étudier la musique avant tout** (`ANALYSE-MUSIQUE.md`) : tempo, grille des temps, sections et
    moments forts, passages calmes, présence de chant, volume.
  - **Chaque phrase de la voix est posée sur un temps** ; les phrases-clés tombent sur les
    changements de section (accroche → entrée de la batterie, appel à l'action → retour du refrain).
    Les scènes suivent les sections ; animations au tempo (pulsations, mascottes qui dansent) ;
    un passage calme = moment de concentration (fond assombri, pulsations coupées).
  - Si le texte ne tient pas dans la structure de la musique, **réécrire le script** et le donner
    au client pour une nouvelle voix — avec un tableau « v1 → v2 » qui justifie chaque coupe.

### [2026-10-24] Mixage harmonisé : aucun son au-dessus des autres
- Consigne du client : « fais en sorte que les sons soient parfaitement harmonisés pour pas qu'il y
  ait un son qui soit supérieur à l'autre et qu'il soit désagréable à l'écoute ».
- Règles d'application (`outils/mixage.py`, appelé après le rendu) :
  - voix compressée et ramenée à −16 LUFS ; musique ramenée à −16 LUFS, creusée de 3 dB vers
    2,8 kHz, puis abaissée sous la voix (−10 dB) et remontée dans les respirations (−4,5 dB) ;
  - chaque bruitage est mesuré et ramené à la même crête de sonie, puis dosé par catégorie
    (impact, transition, interface…), −2 dB de plus quand la voix parle ;
  - master à −14 LUFS intégrés, crête vraie ≤ −1,5 dBTP ;
  - **contrôle chiffré** livré avec la vidéo : courbe de sonie de chaque piste dans le temps
    (`…-equilibre-sonore.png`) ; la voix doit dominer la musique d'au moins 8 dB pendant la parole
    et aucun bruitage ne doit dépasser la voix.

### [2026-10-24] Appel à l'action « commente » + conclusion « abonne-toi »
- Consigne du client : « propose aux personnes de commenter le mot META pour recevoir un guide des
  bonnes pratiques […] la conclusion doit inciter les viewers à s'abonner ».
- Règles d'application (reels Oddysee) :
  - **un seul appel à l'action principal** : « Commente [MOT] → ressource offerte », dit par la voix,
    **montré à l'écran** (champ de commentaire, mot tapé, ressource reçue en message privé), placé
    sur le moment le plus fort de la musique ; il remplace l'appel au partage ;
  - **dernière phrase = « abonne-toi » avec une raison concrète** (« on surveille Meta pour toi »),
    bouton « S'abonner » → « Abonné ✓ » à l'écran, puis signature (logo + badge) ;
  - le mot-clé et la ressource sont repris dans la légende ; prévenir le client qu'il faut la
    ressource (PDF) et l'envoi en message privé.

### [2026-10-25] Série de 60 vidéos : trois scripts par jour, sur la base de la vidéo Meta v2
- Consigne du client : « on devra partir sur un rythme de trois vidéos par jour, donc trois scripts
  par jour qui seront transformés en vidéo sur la base de la première vidéo que nous avons faite en
  utilisant le même son en arrière-plan […] je te donne la voix off et je te rajouterai des
  librairies d'illustrations pour enrichir la base d'animation ».
- Règles d'application :
  - **Source des sujets** : le plan de 60 vidéos (`reports/Plan 60 vidéos publicité IA.md`) ; chaque
    script garde l'ID du plan.
  - **Publication : trois vidéos par jour sur les cinq réseaux** (choix du client du 2026-10-25),
    soit les 60 vidéos en 20 jours ; créneaux espacés et sujets d'objectifs différents chaque jour.
  - **Livraison quotidienne : trois scripts**, chacun avec le texte à dire (`voix.txt`), la raison du
    choix (sujet, accroche, mot-clé d'appel à l'action) et la légende. Le client génère la voix
    (ElevenLabs, voix Oxley) et la dépose : **aucune voix provisoire**.
  - **Gabarit commun** : le système de `studio-v2/projets/oddysee-meta-28-octobre-v2/` (gabarit,
    `build.py`, placement sur les temps, mixage `outils/mixage.py`) et **la même musique de fond**
    (`assets/musique/musique-client.mp3`). Chaque script est écrit pour tenir dans la structure de
    cette musique (≈ 60–65 mots, accroche sur l'entrée de la batterie, appel à l'action sur le
    moment fort, « abonne-toi » en conclusion).
  - **Bibliothèques d'illustrations** fournies par le client : rangées dans
    `studio-v2/marque/oddysee/illustrations/` avec un index (comme les mascottes) ; un fichier distinct
    par apparition ; varier les illustrations d'une vidéo à l'autre pour que la série ne se répète pas.
  - Un dossier par vidéo : `studio-v2/projets/oddysee-serie-60/<ID>-<sujet>/`.

### [2026-10-26] Mascottes : mélanger les personnages selon le sujet
- Consigne du client : « le but d'enrichir la librairie, c'est la mise en contexte selon le sujet : les
  mascottes des personnages doivent être mixées, ce qui se rapproche le plus en fonction du sujet et de
  l'objectif de la vidéo, pour ne pas avoir quelque chose de très monotone ».
- Règles d'application (bibliothèque : `marque/oddysee/mascottes/INDEX.md`, qui s'enrichit à chaque lot) :
  - **choisir les personnages par le sujet et l'objectif** : par exemple, un dirigeant frustré par sa pub
    → un personnage sérieux ou en colère ; un conseil → index levé ou main qui désigne ; une preuve ou un
    appel à l'action → victoire, pouce levé ;
  - **mélanger** : au moins deux personnages différents par vidéo (dialogue, avant / après), et pas le même
    duo d'une vidéo à l'autre sur une même journée ; alterner les styles (tête photo, gravure, pochoir) ;
  - l'émotion change avec la phrase (déjà la règle « une émotion par phrase ») ;
  - tenir un relevé des mascottes utilisées par vidéo dans `projets/oddysee-serie-60/README.md`, pour varier.
  - Seuls les fichiers présents sur le disque sont utilisables : les images collées dans la conversation
    doivent être renvoyées en pièce jointe.

### [2026-10-26] Scripts : partir de la douleur de ceux qui cherchent des clients
- Consigne du client (vidéo 60 rejetée) : « va sur quelque chose de beaucoup plus pertinent qui s'adapte à
  la réalité et à la problématique des personnes qui ont besoin de clients : parle de leur douleur et
  propose la solution de croissance ».
- Règles d'application :
  - **accroche = une douleur concrète du spectateur**, dans ses mots (agenda vide, mois en dents de scie,
    « avant ça vendait avec le boost », demandes jamais rappelées, pub qui coûte sans rapporter) ;
  - **retournement = la vraie cause**, sans culpabiliser (« ce n'est pas ton talent ») ;
  - **solution = un levier de croissance** qu'Oddysee met en place (pub ciblée, page qui rassure et
    convertit, suivi rapide des demandes, automatisation), formulé comme un bénéfice ;
  - pas de vidéo centrée sur Oddysee elle-même (défi interne, coulisses, badge) sauf si elle répond
    directement à une douleur du client ; les sujets 60, N09, N10 du plan sont à reprendre sous cet angle.

### [2026-10-26] Publication sur les comptes Oddysee, pas sur le profil d'Alvarez
- Consigne du client : « les vidéos que nous sommes en train de faire sont à poster sur le profil Oddysee,
  pas sur le profil Alvarez ».
- Règles d'application : Instagram, Facebook, TikTok, LinkedIn (page Oddysee) et YouTube au nom d'Oddysee ;
  textes LinkedIn à la voix de l'agence (« nous », vouvoiement), jamais à la première personne du fondateur ;
  pas d'« insert du fondateur » sauf demande expresse.

### [2026-10-27] Quatre vidéos par jour, scripts dans l'ordre de publication
- Consigne du client : « Je veux créer les prochains contenus de la journée, on travaillera sur quatre
  vidéos : commence par me donner le script de la voix off de la première vidéo de la journée, qui sera
  postée à 9 h ».
- Règles d'application :
  - jour 2 : **quatre vidéos**, à **9 h, 12 h 30, 15 h 30 et 18 h 30** (créneaux fixés par le client,
    voir l'entrée suivante) ;
  - livrer les scripts **un par un, dans l'ordre de publication**, chacun avec son créneau et le nom
    du fichier audio attendu (le client a déjà été perdu par un ordre différent au jour 1) ;
  - chaque script part toujours d'une douleur du spectateur (consigne du 26 octobre).

### [2026-10-27] Créneaux de publication : 9 h, 12 h 30, 15 h 30, 18 h 30
- Consigne du client : « donne-moi le script de la vidéo de 15 h 30 ».
- Règle d'application : avec quatre vidéos par jour, les créneaux sont 9 h, 12 h 30, **15 h 30** et 18 h 30
  (le créneau de 21 h proposé n'est pas retenu). La troisième vidéo du jour passe à 15 h 30, la quatrième
  à 18 h 30 ; toujours livrer les scripts dans cet ordre, avec l'heure dans le titre.

### [2026-10-28] Quatre vidéos par jour : rythme reconduit
- Consigne du client (jour 3) : « Je veux créer les prochains contenus de la journée, on travaillera sur
  quatre vidéos ; commence par me donner le script de la voix off de la première vidéo de la journée, qui
  sera postée à 9 h ».
- Règle d'application : le rythme de **quatre vidéos par jour** (9 h, 12 h 30, 15 h 30, 18 h 30) devient la
  norme de la série, jusqu'à nouvel ordre ; sujets toujours tirés de la douleur du spectateur, variés d'un
  jour à l'autre (e-commerce, services, demandes, offre…), et jamais deux fois le même sujet dans la série.

### [2026-10-28] Nouveau format « médecin + anatomie » en darija (à garder en mémoire)
- Consigne du client : « je voudrais créer un nouveau format de vidéo que tu devras sauvegarder en
  mémoire […] l'image représentant l'anatomie doit être utilisée comme sur le lien […] la description de
  la vidéo doit être en arabe […] l'anatomie en 3D te permettra de faire pivoter chaque partie du corps
  […] n'oublie pas d'intégrer les éléments du stop scroll ». Puis : « garder la même voix off, juste les
  transcriptions captions qui changent en arabe darija », « Darija partout », « Les sous-titres arabes
  doivent représenter les textes animés ».
- Règles d'application (détail : `references/REF-03-medecin-anatomie-darija.md`) :
  - **voix d'origine** du praticien conservée ; aucun doublage ; les **textes animés sont les sous-titres**,
    en **darija** (écriture arabe), révélés mot à mot au rythme de la parole ;
  - style des captures : pastilles blanches nom + icône ronde dégradée, bulles flottantes, cartes de verre
    sombres, carte d'adresse blanche, pastilles de fin « متابعة » / « رعاية », logo de la clinique en badge ;
  - **anatomie comme sur la page de référence** : même image, mêmes zones ; le médecin passe en vignette,
    la planche bascule entre face / profil / dos (rotation `rotationY`), zoome sur la partie citée, trace
    les méridiens et fait apparaître les points au moment où ils sont nommés ;
  - **stop scroll** : entrée zoomée + flash, accroche-question sur la douleur avec pastille « ! » qui pulse,
    barre de progression, coups de zoom aux mots forts, une nouveauté visuelle toutes les 1–2 s, bruitages ;
  - descriptions de publication **en darija** ; message de santé prudent (« كيعاونو يخففو »), mention
    « الطب الصيني مكمّل، وماشي بديل على الطبيب ».

### [2026-10-29] Nouveau type : vidéo YouTube 16:9 « motion design éditorial + interfaces »
- Consigne du client : brief « Oddysee — Brief de réalisation V2 » et trois vidéos de référence, avec la
  question : « me dire si tu peux réaliser à l'identique la vidéo […] si je te donne une voix off avec un script ».
- Règles d'application (détail : `references/REF-04-youtube-motion-design.md`, brief complet dans
  `references/REF-04-youtube-motion-design/BRIEF-CLIENT-V2.md`) :
  - 1920 × 1080, 30 i/s, durée = voix off complète ; script conservé mot pour mot, sans ajout ;
  - motion design sur fond clair à halos violets : cartes de verre, nœuds et courbes (réf. A), interfaces
    inclinées, zooms et clics (réf. B), personne au centre d'un système (réf. C) ; transitions par
    continuité (un objet se transforme pour la phrase suivante), jamais une suite de diapositives ;
  - un seul objet porteur de sens par phrase, mouvement déclenché sur le mot qui fait évoluer le sens ;
  - aucune preuve, aucun logo, aucun chiffre, aucun compte à rebours ni nombre de places inventé ; tout
    manque est signalé et remplacé par une composition graphique simple ;
  - livrables : vidéo sous-titrée, vidéo sans sous-titres, SRT, tableau d'affectation S01–S32 avec minutage
    réel, liste des manques et des faits à valider.

### [2026-10-29] Vidéo YouTube motion design : sous-titres intégrés à l'animation
- Consigne du client : « Je donnerai le script et la voix off, les sous-titrages doivent être incorporés dans
  l'animation comme sur l'un des modèles parmi les trois vidéos ».
- Règle d'application : pas de bande de sous-titres classique. Le texte parlé devient de la **typographie
  animée** comme dans la réf. B (phrase qui se construit mot à mot au rythme de la voix, glisse
  latéralement, petit signe graphique d'accompagnement) et la fin de la réf. A (mot clé en sérif italique +
  sans-sérif à côté de l'objet animé). Le texte est posé **dans** la composition, à côté de l'objet de la
  scène, jamais par-dessus ; deux lignes au plus ; mots clés en violet. Le SRT reste livré pour YouTube.

### [2026-10-29] Bruitages : jamais trop forts, réglés par rapport à la voix off
- Consigne du client : « Fais en sorte que les effets sonores ne soient pas trop forts et que ce soit ajusté
  par rapport à la voix off […] dans les précédentes vidéos, j'avais l'impression d'avoir des effets beaucoup
  trop forts. »
- Règle d'application (toutes les vidéos) : chaque bruitage culmine **au moins 12 dB sous le niveau moyen de
  la voix** (sonie momentanée max du bruitage ≤ sonie intégrée de la voix − 12 dB), mesuré et plafonné
  automatiquement au mixage (`ECART_SFX` dans `projets/oddysee-vsl-youtube/mix.py`) ; la voix reste toujours
  devant ; contrôle chiffré noté dans `FABRICATION.md`.

### [2026-10-29] Motion design : moins de vide, plus d'éléments explicatifs (bibliothèque fournie)
- Consigne du client : « la vidéo a beaucoup trop de blanc, il y a beaucoup trop de vide, il y a moins
  d'éléments explicatifs » ; cinq archives fournies comme apprentissage **et** comme ressources à détourer
  (`marque/oddysee/bibliotheque-motion/`).
- Règles d'application (détail : `references/REF-04-youtube-motion-design.md`, partie 6) :
  - chaque scène a un **objet héros illustré** (autocollant vintage tramé violet ou objet 3D en verre) en
    plus des cartes d'interface ; jamais une carte seule sur un grand fond vide ;
  - remplir l'espace : composition en couches (fond texturé, grand mot ou chiffre en arrière-plan, objet
    héros, cartes, pastilles), 60 à 75 % de la surface occupée hors zone des sous-titres ;
  - textures : trame, grain, papier déchiré, contours blancs d'autocollant ; reflets irisés sur le verre ;
  - les images de marques tierces (logos, affiches, textes) servent de **référence de style uniquement**.

### [2026-10-29] Bruitages d'interface plus présents (remplace l'écart de 12 dB pour les clics et glissements)
- Consigne du client : « en ce qui concerne les effets sonores de clics, de swipe ou de flèche, je souhaiterais
  que tu augmentes le son parce que la voix off est beaucoup trop élevée et on a l'impression que la vidéo n'a
  pas d'effet sonore ».
- Règle d'application (toutes les vidéos), mesurée au mixage (`ECARTS_SFX` dans `projets/oddysee-vsl-youtube/mix.py`) :
  - **clics, touches, apparitions (pop), glissements (whoosh), curseur** : pic à **5 dB sous** le niveau moyen
    de la voix — nettement audibles, sans jamais couvrir un mot ;
  - **notifications, carillons, scintillements** : 8 dB sous la voix ;
  - **impacts graves, montées (riser)** : 10 dB sous la voix ;
  - la voix reste devant : aucun bruitage ne dépasse son niveau moyen ; vérification chiffrée à chaque export.

<!-- Format d'ajout :
### [date] Titre de l'élément
- Consigne du client : « … »
- Règle d'application : …
-->
