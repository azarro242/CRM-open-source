# Analyse de la musique fournie (v2)

Fichier : `assets/musique/musique-client.mp3` — MP3 320 kb/s, stéréo, **30,06 s**.
Mesures : librosa (temps, attaques, énergie par bande), ffmpeg ebur128, Whisper (recherche de chant).

| Mesure | Résultat |
|---|---|
| Tempo | **≈ 121 BPM** (un temps toutes les 0,496 s) — 61 temps sur le morceau |
| Chant | **Aucun** (Whisper : « musique entraînante ») → aucune voix ne concurrence la voix off |
| Volume | −15,0 LUFS intégrés, crête −0,5 dBFS, plage dynamique 4,9 LU |
| Caractère | Entraînant, grosse caisse marquée, médiums présents (d'où un creux de 3 dB vers 2,8 kHz au mixage pour laisser passer la voix) |

## Structure (repères au temps près)

| Temps | Section | Énergie | Utilisation dans la vidéo |
|---|---|---|---|
| 0,00 – 3,06 | Intro, la basse disparaît vers 1,6 s | moyenne, creux à 2 s | Accroche « Le 30 octobre, Meta change ses règles ? » |
| **3,06** | Entrée de la batterie | **forte** | **« FAUX. »** + tampon + flash |
| 3,06 – 10,89 | Partie A | forte, accent à 4,90 | Repoussé au 20 novembre · Mercredi 28 (la nuit tombe) |
| **10,89** | Partie B (après un petit break à 10 s) | forte, sommet à 16 s | **Le clic → page Instagram, pas ton site** (la croix tombe sur le sommet) |
| **17,37 – 23,34** | **Passage calme** (la basse s'efface) | faible | **Le réglage** : la voix ressort seule, fond assombri, concentration |
| 21,7 – 23,34 | Montée | croissante | Montée sonore + suspense avant le retour |
| **23,34** | Retour de la batterie | **forte** | **« Commente META »** : le mot se tape lettre par lettre sur 4 temps |
| 23,34 – 28,6 | Partie C | forte | Le guide offert arrive en message privé |
| 28,6 – 30,06 | Fin | décroissante | « Abonne-toi » + logo, badge Meta Business Partner |

Grille complète des temps : `assets/musique/grille.json` (générée par `build.py`).
