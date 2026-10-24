# Fabrication — vidéo « Le 30 octobre ? Faux. »

Tout est prêt sauf la voix : la mise en scène se cale automatiquement sur les mots de la voix.

## Dans la session où `ELEVENLABS_API_KEY` est disponible

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
