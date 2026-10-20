# 🎬 Studio de montage vidéo — Guide d'utilisation

Ce dépôt est équipé d'un écosystème complet de montage vidéo basé sur
**HyperFrames** (le moteur vidéo HTML de HeyGen) piloté par Claude Code.
Vous décrivez le montage voulu, vous fournissez vos éléments, Claude produit le MP4.

---

## Ce qui est installé

| Composant | Rôle | État |
|---|---|---|
| 19 skills HyperFrames (`.agents/skills/`) | Workflows de création vidéo (motion design, sous-titres, habillage, promo…) | ✅ versionné dans le dépôt |
| CLI `hyperframes` (via npx) | Scaffolding, validation, rendu MP4 | ✅ testé (rendu 10 s validé) |
| ffmpeg / ffprobe | Extraction audio, encodage | ✅ installé par `outils/setup.sh` |
| `whisper-cli` (`outils/bin/`) | Transcription de la voix off (binaire pré-compilé) | ✅ versionné dans le dépôt |
| Modèle Whisper `small` multilingue | Nécessaire à la transcription du français | ⚠️ téléchargement bloqué par le réseau (voir plus bas) |
| Chrome Headless + GSAP local (`outils/vendor/`) | Rendu des compositions | ✅ opérationnel |

**Au début de chaque nouvelle session**, Claude lance `bash outils/setup.sh`
(≈ 1 minute) pour remettre en place ce qui ne survit pas au conteneur éphémère.

---

## Comment me soumettre vos éléments

### Option A — Débloquer le réseau (recommandé, à faire une fois)

L'environnement cloud bloque par défaut Google Drive et Hugging Face.
En le débloquant, Claude pourra **télécharger vos vidéos directement depuis
votre Google Drive** et récupérer le modèle de transcription.

1. Ouvrez [claude.ai/code](https://claude.ai/code) → icône nuage → modifier l'environnement.
2. Dans **Network access**, choisissez **Custom** et cochez
   *« Also include default list of common package managers »*.
3. Ajoutez ces domaines (un par ligne) :

   ```
   drive.google.com
   drive.usercontent.google.com
   *.googleusercontent.com
   huggingface.co
   *.huggingface.co
   *.hf.co
   cdn.jsdelivr.net
   unpkg.com
   ```

   (ou choisissez simplement **Full** pour tout autoriser.)

### Option B — Déposer les fichiers dans le dépôt GitHub

Pour des fichiers **≤ 25 Mo** (vos vidéos WhatsApp font 2–15 Mo, c'est parfait) :

1. Sur github.com, ouvrez ce dépôt, branche de travail en cours.
2. Naviguez dans `studio/sources/` → **Add file → Upload files**.
3. Dites ensuite à Claude en conversation : « les fichiers sont dans studio/sources ».

### Option C — Joindre le fichier dans la conversation

Si votre application permet de joindre des fichiers au message, envoyez
directement le MP4 dans la discussion.

---

## Types de montage disponibles

| Vous voulez… | Workflow utilisé |
|---|---|
| Une vidéo **motion design** synchronisée sur la voix off d'un MP4 existant | `general-video` + transcription |
| Ajouter des **sous-titres** stylés à une vidéo face caméra | `embedded-captions` (36 styles) |
| **Habiller** une interview/podcast (titres, lower-thirds, citations) | `talking-head-recut` |
| Une vidéo **promo d'un site ou produit** à partir d'une URL | `product-launch-video` |
| Une vidéo **explicative** à partir d'un texte ou de notes | `faceless-explainer` |
| Une vidéo **rythmée sur une musique** | `music-to-video` |
| Un **logo animé, titre, statistique animée** (< 10 s) | `motion-graphics` |
| Une **présentation / deck animé** | `slideshow` |
| Importer des maquettes **Figma** | `figma` |

Formats de sortie : 16:9 (1920×1080), 9:16 (1080×1920), carré, 4K.

---

## Déroulement d'un projet type (motion design sur voix off)

1. **Vous fournissez** le MP4 source (options A/B/C ci-dessus).
2. **Extraction & transcription** : la voix off est extraite (ffmpeg) et
   transcrite mot à mot avec horodatage (`whisper-cli`, modèle multilingue,
   `--language fr`).
3. **Brief éclair** : Claude confirme avec vous le style (palette, typo,
   ambiance), le format (16:9 / 9:16) et le niveau de relecture
   (storyboard ou rendu direct).
4. **Composition** : un projet HyperFrames est créé dans `studio/projets/<nom>/`,
   les animations sont calées sur les timestamps de la narration,
   la voix off d'origine reste la bande son.
5. **Rendu & livraison** : le MP4 final est rendu, envoyé dans la conversation
   et archivé dans `studio/exports/`.

---

## Limitations connues de l'environnement

- **Hugging Face bloqué par défaut** → pas de téléchargement du modèle Whisper
  tant que le réseau n'est pas élargi (Option A). Solution de repli : fournir
  vous-même les sous-titres (`.srt`/`.vtt`), le CLI sait les importer.
- **CDN jsdelivr/unpkg bloqués par défaut** → les librairies d'animation sont
  installées localement via npm (copie de GSAP déjà versionnée dans
  `outils/vendor/`).
- **Google Drive** : la recherche de fichiers fonctionne via le connecteur,
  mais le téléchargement des vidéos nécessite l'Option A (ou passez par B/C).
- Le conteneur est **éphémère** : tout résultat important est poussé sur GitHub
  ou envoyé dans la conversation avant la fin de session.
