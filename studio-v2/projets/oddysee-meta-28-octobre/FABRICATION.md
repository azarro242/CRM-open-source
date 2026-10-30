# Fabrication — vidéo « Le 30 octobre ? Faux. »

**Livrée le 24/10/2026** : `studio-v2/exports/oddysee-meta-28-octobre.mp4` (30,8 s, 1080 × 1920, −14 LUFS).
Voix : fichier Oxley fourni par le client (généré sur elevenlabs.io, modèle v3), calé mot à mot avec
`outils/aligner.py` (Whisper DTW + recalage sur les silences). La mise en scène se cale automatiquement
sur les mots de la voix.

## Refaire le rendu avec un fichier voix fourni

```bash
cd studio-v2/projets/oddysee-meta-28-octobre
python3 ../../../outils/aligner.py voix.mp3 voix.txt voix.transcript.json --langue fr
python3 build.py && npx --yes hyperframes@0.8.193 check
npx --yes hyperframes@0.8.193 render --fps 30 --quality looks --output renders/brut.mp4
# puis loudnorm −14 LUFS / −1,5 dBTP vers studio-v2/exports/
```

## Variante : voix générée par l'API (session où `ELEVENLABS_API_KEY` est disponible)

```bash
cd studio-v2/projets/oddysee-meta-28-octobre
python3 ../../../outils/elevenlabs.py generer --voix 2gPFXx8pN3Avh27Dw5Ma \
  --texte voix.txt --sortie voix.mp3 --langue fr      # voix Oxley + voix.transcript.json
python3 build.py                                        # index.html calé sur la voix
npx --yes hyperframes@0.8.193 check                     # 0 erreur attendue
npx --yes hyperframes@0.8.193 snapshot --at …           # une image par scène, à regarder
npx --yes hyperframes@0.8.193 render                    # MP4 1080 × 1920
# puis normaliser le son à −14 LUFS / −1 dBTP (ffmpeg loudnorm) et livrer dans studio-v2/exports/
```

Faire écouter la voix au client avant le rendu final (voix anglophone : accent possible).

## Fichiers

- `voix.txt` — texte lu par Oxley (nombres en lettres, pas d'espace avant « ? » et « : »).
- `gabarit.tpl` — les 6 scènes, sous-titres karaoké, animations, aux couleurs Oddysee.
- `build.py` — assemble `index.html` : scènes, sous-titres, bruitages et musique calés sur la voix.
  `python3 build.py --estimation` = rythme estimé, **sans voix**, pour contrôler les images seulement.
- `outils/musique.py` — musique de fond originale (pulsation « compte à rebours »), recalculée à la durée.
- `assets/` — police Outfit, mascottes (une copie par apparition), logos, bruitages.

## Points de contrôle déjà validés (rythme estimé)

`hyperframes check` : 0 erreur (11 avertissements de structure « sous-composition », sans effet sur le rendu).
