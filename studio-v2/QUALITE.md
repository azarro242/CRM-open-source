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

<!-- Format d'ajout :
### [date] Titre de l'élément
- Consigne du client : « … »
- Règle d'application : …
-->
