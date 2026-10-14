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

> En attente des consignes du client. Chaque élément reçu est ajouté ici,
> daté, avec sa règle d'application concrète.

<!-- Format d'ajout :
### [date] Titre de l'élément
- Consigne du client : « … »
- Règle d'application : …
-->
