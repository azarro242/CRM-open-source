# Studio V2 — Protocole de production

Nouvelle génération de contenu, qualité supérieure. Ce protocole s'applique à
**toute** vidéo produite dans `studio-v2/`. La V1 (`studio/`) reste archivée telle quelle.

---

## 1. Les trois portes d'entrée

Chaque projet démarre par **une** de ces trois portes. Identifier laquelle est la
première chose à faire.

| Porte | Ce que le client fournit | Ce que je produis | Cas d'usage |
|---|---|---|---|
| **A · Prompt** | Une description écrite (idée, script, storyboard) | La vidéo entièrement construite à partir du texte | Aucune direction artistique imposée |
| **B · Images** | Des images fixes (photos, captures, visuels, maquettes) | Les images animées et mises en scène | Une marque à respecter |
| **C · Vidéo d'exemple** | Une vidéo de référence | Une vidéo qui reprend son style, son rythme ou sa structure | Reprendre un style précis |

Référence fondatrice de cette méthode et du style visé : `references/REF-01-maxence-tison.md`.

### Types de contenu de référence

Le type se déduit du brief ; le demander seulement s'il reste ambigu. Il fixe la direction
artistique, la durée et la structure d'écriture (détail dans `QUALITE.md`).

| Type | Durée | Objectif | Référence |
|---|---|---|---|
| **Publicité de marque** | 15–40 s | Présenter et vendre un produit, une marque, un service | `references/REF-01-maxence-tison.md` |
| **Reel éducatif faceless** | 60–115 s | Expliquer une actualité ou une méthode, gagner des abonnés | `references/REF-02-funl-visibilite-ia.md` |
| **Reel mascotte Oddysee** | ≈ 25 s | Vidéos de l'agence du client : faire venir des clients à Oddysee | `marque/oddysee/FICHE-MARQUE.md` (REF-02 aux couleurs Oddysee + 5 temps de REF-01) |

### Bibliothèques de marque

Une marque récurrente a son dossier `marque/<nom>/` : fiche de marque (faits sourcés,
couleurs, police, voix, format vidéo), logos, polices, captures, mascottes. Le lire **avant**
d'écrire le script d'une vidéo de cette marque.

- `marque/oddysee/` — agence du client : `FICHE-MARQUE.md`, `mascottes/INDEX.md`.

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

### Q2 · Voix off — deux possibilités

1. **Générée avec ElevenLabs**
   1. Langue de la vidéo : la déduire de la demande (français par défaut), sinon la demander.
   2. Lancer `python3 outils/elevenlabs.py voix --langue <code>` : liste des voix de cette
      langue, **classées de la meilleure à la moins bonne** (voix vérifiées dans la langue
      d'abord, puis usage réel en production sur 12 mois, puis popularité).
   3. Présenter la liste au client : nom, profil (genre, âge, accent, usage) et lien
      « écouter » pour chaque voix. Puis lui faire choisir par `AskUserQuestion` avec les
      4 premières en options — il peut taper le nom d'une autre voix de la liste.
      **Le client n'a qu'à sélectionner un nom.**
   4. Générer : `python3 outils/elevenlabs.py generer --voix <id> --texte <script>
      --sortie <projet>/voix.mp3 --langue <code>` (modèle `eleven_v4` par défaut).
      Le fichier `voix.transcript.json` produit à côté donne l'horodatage mot à mot :
      les sous-titres se calent dessus sans passer par Whisper.
2. **Fichier audio fourni** → transcription Whisper (`--model small --language <code>`)
   et calage au mot près.

Pour un cas particulier (vidéo sans voix, voix enregistrée plus tard), le client
l'indique dans le champ « Autre » de la question.

**Voix déjà choisie par marque** : pour une vidéo **Oddysee**, Q2 est répondue d'office —
ElevenLabs, voix « Oxley - Evil Character » (`2gPFXx8pN3Avh27Dw5Ma`). Ne pas reposer la question.

**Clé d'API** : la génération lit la variable `ELEVENLABS_API_KEY`. Le client l'ajoute dans les
réglages de l'environnement cloud (menu de l'environnement dans la barre de titre de la session
→ Modifier → *Network secrets* / *API credentials*, sinon variable d'environnement). Elle est
prise en compte à la **session suivante**. Ne jamais la demander dans la conversation.

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
3. **Script** — rédiger le script selon la structure en 5 temps de `QUALITE.md` et le
   **faire valider par le client avant toute génération** (voix comprise).
4. **Composition** — construire avec HyperFrames (lire `.agents/skills/hyperframes/SKILL.md`).
   Appliquer **toutes** les exigences de `QUALITE.md`.
5. **Contrôle** — `npm run check` sans erreur + instantané de **chaque** scène, inspecté
   visuellement avant le rendu final.
6. **Rendu & livraison** — export dans `exports/`, envoyé dans la conversation,
   commit sur la branche.
7. **Retours** — le client peut donner ses retours horodatés (« à 0:10 : le bandeau de
   droite en noir ») ; chaque retour est appliqué au timecode près, puis la vidéo est
   rendue à nouveau.

---

## 5. Livraison — formats de sortie

- **Vidéo complète** → **MP4** (H.264 + AAC), lisible partout.
- **Calque à superposer** — le MP4 ne gère pas la transparence. Livrer selon le besoin :
  - **MP4 mode « Écran »** : fond noir, à poser en mode de fusion Écran — conserve les dégradés ;
  - **MP4 fond vert** : incrustation chroma, coupure nette (un dégradé ne se détoure pas) ;
  - **WebM transparent** : seulement si le logiciel du client le lit (pas le cas actuellement).
- Piste audio d'un calque = **effets sonores seuls** (la voix reste sur la vidéo d'origine).
