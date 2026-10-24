# Studio de montage vidéo — instructions de session

Ce dépôt sert d'atelier de montage vidéo basé sur HyperFrames
(skills versionnés dans `.agents/skills/`, exposés via `.claude/skills/`).
Guide utilisateur : `GUIDE-MONTAGE.md`.

## Studio V2 — génération actuelle (prioritaire)

Toute **nouvelle** vidéo se produit dans `studio-v2/` en suivant le skill `studio-v2`
(`.claude/skills/studio-v2/SKILL.md`). En résumé :

- Trois portes d'entrée : **A** prompt / script · **B** images à animer ·
  **C** vidéo d'exemple — toujours avec liens et ressources externes exploités.
- Trois questions **obligatoires** avant de produire : **format / dimensions**,
  **voix off** (ElevenLabs — liste des voix classées via `outils/elevenlabs.py` —
  ou fichier audio fourni), **sous-titres**.
- Qualité : appliquer intégralement `studio-v2/QUALITE.md` (acquis V1 + consignes V2).
- Toute nouvelle consigne qualité du client s'ajoute à `QUALITE.md` dans le même tour.
- Vidéos de l'agence du client (**Oddysee**) : lire `studio-v2/marque/oddysee/FICHE-MARQUE.md`
  et `mascottes/INDEX.md` (mascottes, faits sourcés, voix Oxley, format ≈ 25 s).
  Chaque nouveau lot de cinq mascottes s'ajoute à l'index dans le même tour.

Le dossier `studio/` (V1) est archivé : ne le modifier que pour retoucher un projet V1
existant à la demande du client.

## Au début de toute session impliquant de la vidéo

1. Lancer `bash outils/setup.sh` (idempotent, ~1 min) : ffmpeg, whisper-cli,
   navigateur de rendu, tentative de téléchargement du modèle Whisper.
2. Lire `.agents/skills/hyperframes/SKILL.md` — point d'entrée obligatoire
   avant toute création ou édition vidéo.

## Organisation

- `studio/sources/` : fichiers fournis par l'utilisateur (MP4, audio, images, logos).
- `studio/projets/` : un sous-dossier HyperFrames par montage (`hyperframes init`).
- `studio/exports/` : rendus finaux — les committer (< 100 Mo) ET les envoyer
  dans la conversation via SendUserFile.

## Contraintes de cet environnement cloud (politique réseau « Trusted »)

- `cdn.jsdelivr.net` / `unpkg.com` **bloqués** → ne jamais laisser un `<script src>`
  pointer vers un CDN : installer la lib via npm et copier le fichier en local
  (GSAP déjà vendorisé : `outils/vendor/gsap.min.js`). Google Fonts fonctionne.
- `huggingface.co` **bloqué** → le modèle Whisper ne peut pas se télécharger
  tant que l'utilisateur n'a pas élargi le réseau (voir GUIDE-MONTAGE.md).
  `whisper-cli` est fourni pré-compilé dans `outils/bin/`.
  Cache modèles : `~/.cache/hyperframes/whisper/models/ggml-small.bin`.
- Google Drive : recherche OK via le connecteur MCP, mais téléchargement de
  vidéos impossible (proxy) tant que le réseau n'est pas élargi ; sinon
  l'utilisateur dépose ses fichiers dans `studio/sources/` (upload GitHub ≤ 25 Mo).
- Docker indisponible → rendu local uniquement (validé : fonctionne).

## Règles projet

- Voix off en **français** → transcrire avec un modèle multilingue :
  `--model small --language fr` (jamais les modèles `.en`).
- L'utilisateur communique en français : répondre en français.
- Le fichier `claude.md` (minuscule) concerne un autre projet (tunnel de vente
  Systeme.io) — sans rapport avec le studio vidéo, ne pas le modifier.
