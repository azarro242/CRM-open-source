# Studio V2 — Protocole de production

Nouvelle génération de contenu, qualité supérieure. Ce protocole s'applique à
**toute** vidéo produite dans `studio-v2/`. La V1 (`studio/`) reste archivée telle quelle.

---

## 1. Les trois portes d'entrée

Chaque projet démarre par **une** de ces trois portes. Identifier laquelle est la
première chose à faire.

| Porte | Ce que le client fournit | Ce que je produis |
|---|---|---|
| **A · Prompt** | Une description écrite (idée, script, storyboard) | La vidéo entièrement construite à partir du texte |
| **B · Images** | Des images fixes (photos, captures, visuels, maquettes) | Les images animées et mises en scène |
| **C · Vidéo d'exemple** | Une vidéo de référence | Une vidéo qui reprend son style, son rythme ou sa structure |

**Dans les trois cas**, le client peut joindre des **éléments externes** : liens
(site, réseaux), logos, chartes graphiques, musiques, captures, documents.
Ils sont systématiquement exploités : un lien de site → j'en extrais couleurs,
typographie et logo ; un logo → je le place ; une musique → je cale le rythme dessus.

---

## 2. Les trois questions d'ouverture — obligatoires

Avant toute production, poser ces trois questions (sauf si la réponse a déjà été
donnée explicitement dans la demande). Ne jamais deviner.

### Q1 · Format / dimensions

| Choix | Dimensions | Usage |
|---|---|---|
| Vertical 9:16 | 1080 × 1920 | Reels, TikTok, Shorts, Stories |
| Horizontal 16:9 | 1920 × 1080 | YouTube, site web, LinkedIn, présentation |
| Carré 1:1 | 1080 × 1080 | Fil Instagram / Facebook |
| Portrait 4:5 | 1080 × 1350 | Fil Instagram / Facebook (occupe plus d'écran) |

Préciser aussi s'il s'agit d'une **vidéo complète** ou d'un **calque à superposer**
sur une autre vidéo (voir § 5 pour les formats de calque).

### Q2 · Voix off

- **Audio fourni** → je transcris et je cale tout au mot près
- **Enregistrée plus tard par le client** → je cale sur le script/storyboard, piste sans voix
- **Voix IA générée** → synthèse vocale française (installation à vérifier)
- **Pas de voix** → musique et effets sonores uniquement

### Q3 · Sous-titres

- **Avec** → préciser l'emplacement (bas de cadre, dans le bandeau, au centre) et le style
- **Sans**

---

## 3. Questions complémentaires selon la porte

Seulement si l'information manque — une question à la fois, option recommandée en premier.

- **Porte A (prompt)** : objectif de la vidéo (vendre, expliquer, annoncer) ; durée cible ;
  charte à respecter (lien ou couleurs).
- **Porte B (images)** : ordre des images ; style d'animation (doux, dynamique, cinématique) ;
  texte à ajouter sur chaque image.
- **Porte C (vidéo d'exemple)** : ce qu'il faut reprendre (style visuel, rythme,
  structure, effets) et ce qu'il faut changer (contenu, marque, durée).

---

## 4. Déroulé de production

1. **Brief** — remplir `modeles/BRIEF.md` dans `projets/<nom>/BRIEF.md` avec les réponses.
   Le récapituler au client en séparant *ce qu'il a dit* de *ce que j'ai déduit*.
2. **Ressources** — rapatrier tous les éléments externes dans `sources/<nom>/`
   (télécharger les liens, extraire la charte d'un site, vectoriser les logos).
3. **Composition** — construire avec HyperFrames (lire `.agents/skills/hyperframes/SKILL.md`).
   Appliquer **toutes** les exigences de `QUALITE.md`.
4. **Contrôle** — `npm run check` sans erreur + instantané de **chaque** scène, inspecté
   visuellement avant le rendu final.
5. **Rendu & livraison** — export dans `exports/`, envoyé dans la conversation,
   commit sur la branche.

---

## 5. Livraison — formats de sortie

- **Vidéo complète** → **MP4** (H.264 + AAC), lisible partout.
- **Calque à superposer** — le MP4 ne gère pas la transparence. Livrer selon le besoin :
  - **MP4 mode « Écran »** : fond noir, à poser en mode de fusion Écran — conserve les dégradés ;
  - **MP4 fond vert** : incrustation chroma, coupure nette (un dégradé ne se détoure pas) ;
  - **WebM transparent** : seulement si le logiciel du client le lit (pas le cas actuellement).
- Piste audio d'un calque = **effets sonores seuls** (la voix reste sur la vidéo d'origine).
