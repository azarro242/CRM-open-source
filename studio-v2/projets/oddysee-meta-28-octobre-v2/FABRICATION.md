# Fabrication v2 — montage piloté par la musique

En attente : **la nouvelle voix Oxley** (texte dans `SCRIPT.md`). Tout le reste est prêt.

## Dès réception de la voix (`voix.mp3`)

```bash
cd studio-v2/projets/oddysee-meta-28-octobre-v2
python3 ../../../outils/aligner.py voix.mp3 voix.txt voix.transcript.json --langue fr   # mots horodatés
python3 build.py                                    # phrases posées sur les temps, scènes, sons
npx --yes hyperframes@0.8.193 check                 # 0 erreur attendue
npx --yes hyperframes@0.8.193 snapshot --at …       # une image par moment clé, à regarder
npx --yes hyperframes@0.8.193 render --fps 30 --quality looks --output renders/brut.mp4
python3 ../../../outils/mixage.py . renders/brut.mp4 ../../exports/oddysee-meta-28-octobre-v2.mp4 \
        --rapport ../../exports/oddysee-meta-28-octobre-v2-equilibre-sonore.png
```

## Fichiers

- `ANALYSE-MUSIQUE.md` — tempo, sections, repères au temps près.
- `voix.txt` — texte lu par Oxley (une phrase par ligne = un segment replacé sur la musique).
- `build.py` — grille rythmique (librosa, cache `assets/musique/grille.json`), placement des
  phrases (ancres : 3,06 · 10,89 · 17,37 · 23,34 s), scènes, sous-titres, bruitages égalisés,
  enveloppe de la musique ; écrit `index.html` (aperçu) et `mix.json` (mixage).
  `--estimation` : rythme estimé sans voix, pour contrôler les images.
- `gabarit.tpl` — 7 scènes, animations au tempo, aux couleurs Oddysee.
- `outils/mixage.py` (racine du dépôt) — mixage final : voix −16 LUFS compressée, musique creusée
  à 2,8 kHz et abaissée sous la voix (−10 dB / −4,5 dB dans les respirations), bruitages ramenés
  à la même crête puis dosés par catégorie, master −14 LUFS / crête ≤ −1,5 dBTP, rapport PNG.
- `apercu-v2.jpg` — 11 images clés (rythme estimé).
