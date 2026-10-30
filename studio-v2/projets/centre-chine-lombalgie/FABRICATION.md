# Fabrication — Centre de réadaptation de Chine · lombalgie (45 s)

Format : `references/REF-03-medecin-anatomie-darija.md` · Clinique : `marque/centre-readaptation-chine/FICHE-MARQUE.md`

## Sources (`studio-v2/sources/centre-chine-lombalgie/`)

| Fichier | Contenu |
|---|---|
| `video-medecin.mp4` | Vidéo du médecin (1080 × 1920, 41,97 s, voix chinoise à −23,5 LUFS) |
| `transcription-zh.rtf` / `.txt` | Transcription chinoise fournie par le client |
| `captures-style/` | Les quatre captures de style |
| `anatomie-client.jpg` | Image d'anatomie envoyée par le client |
| `reference-page/` | Planche de la page de référence (`anatomie.png`), ses zones (`body-chart.html`, `zones.json`) et le logo Baicaotang |

## Étapes

1. **Temps de parole** — Whisper (`small`, chinois) ne découpe pas les mots. Les phrases ont été
   calées à partir des jetons horodatés (`-ojf`) et de l'enveloppe d'énergie (RMS, seuil par
   percentile). Résultat : 19 segments, détaillés dans `SCRIPT-DARIJA.md`.
2. **Script darija** (`SCRIPT-DARIJA.md`) — chinois, traduction fidèle, texte à l'écran, animation.
3. **`python3 build.py`** — génère `index.html` et `mix.json` à partir des tables :
   - `SOUS` : 13 cartes-sous-titres ;
   - `PUCES` : 9 pastilles ;
   - `BULLES` : 4 bulles ;
   - `SFX` : 37 bruitages ;
   - `VUES`, `MERIDIENS`, `POINTS` : la planche d'anatomie.
4. **Contrôle** — `npx hyperframes@0.8.193 check` : 0 erreur. Les 3 avertissements restants sont
   structurels (taille du fichier, sous-compositions) et acceptés.
5. **Rendu** — `npx hyperframes@0.8.193 render --fps 30 --quality looks --output renders/brut.mp4`.
6. **Mixage** —
   `python3 mix.py renders/brut.mp4 ../../exports/centre-chine/centre-chine-lombalgie.mp4 --rapport ../../exports/centre-chine/centre-chine-lombalgie-equilibre-sonore.png --limite 0.66`.
   Résultat : −14,4 LUFS intégrés, crête vraie −1,9 dBTP (avec `--limite 0.72`, la crête montait à −1,4 dBTP).
   Les bruitages sont remontés de 8 dB (`--sfx 8`) : sans ce gain, ils restaient vers −35 LUFS, inaudibles sous la voix.

## Séquence anatomique

| Temps (s) | Ce qui se passe |
|---|---|
| 9,45 | Le médecin passe en vignette. Planche de profil, zone lombaire en rouge. |
| 10,2 | Bascule vers le dos, zoom sur le bas du dos. |
| 11,75 | Retour plein cadre. |
| 15,7 | Vue de dos. |
| 16,2 | Tracé du méridien de la vessie. |
| 18,2 | Bascules vers le profil puis la face. |
| 18,95 | Tracé du méridien des reins. |
| 20,55 | Retour au dos. |
| 21,15 | Ligne de la colonne (Du Mai). |
| 22,35 | Cinq points sur la colonne. |
| 24,55 | Zoom sur les jambes. |
| 26,6 | Point Chengshan. |
| 28,1 | Point Chengjin. |
| 29,4 | Zoom sur le creux du genou, point Weizhong. |
| 31,1 | Retour plein cadre. |

## Corrections après instantanés

- Pastilles « القعدة الطويلة » et « الإبر الصينية » descendues à `top: 900`, pour ne plus couvrir
  le visage.
- Bulle lune déplacée sous la pastille « جسم مرتاح ».
- Icône ventouse redessinée en bocal posé sur la peau : l'ancienne ressemblait à une cloche.
- Sous-titre k7 raccourci en « ونقط بعيدة على الوجع » et prolongé jusqu'à 26,2 s, pour respecter
  le temps de lecture.
- Titres de planche passés sur un dégradé plus foncé (contraste ≥ 3:1).
- États initiaux cachés posés par `gsap.set`, hors de la timeline.
