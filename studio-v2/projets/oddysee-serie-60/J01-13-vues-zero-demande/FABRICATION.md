# Fabrication — vidéo 13 « Dix mille vues… et zéro demande ? »

Gabarit : vidéo Meta v2 (même musique, même mixage). Voix Oxley fournie le 2026-10-26 (`voix.mp3`, 32,1 s).

**Livrée le 26/10/2026** : `studio-v2/exports/serie-60/J01-13-vues-zero-demande.mp4` — 32,2 s, 1080 × 1920, 30 i/s.
Son : −14,2 LUFS intégrés, crête vraie −1,8 dBTP ; voix 10,8 dB au-dessus de la musique pendant la parole
(min 8,6 dB, musique abaissée à −11 dB sous la voix au lieu de −10 dB) ; bruitage le plus fort −18,2 LUFS.

```bash
cd studio-v2/projets/oddysee-serie-60/J01-13-vues-zero-demande
python3 ../../../../outils/aligner.py voix.mp3 voix.txt voix.transcript.json --langue fr
python3 build.py
npx --yes hyperframes@0.8.193 check
npx --yes hyperframes@0.8.193 render --fps 30 --quality looks --output renders/brut.mp4
python3 ../../../../outils/mixage.py . renders/brut.mp4 ../../../exports/serie-60/J01-13-vues-zero-demande.mp4 \
        --rapport ../../../exports/serie-60/J01-13-vues-zero-demande-equilibre-sonore.png
```

## Ce qui change par rapport au gabarit v2

- **Pauses internes raccourcies** (`build.py`, `morceaux`) : une pause de plus de 0,45 s dans une phrase
  (0,55 s après « … ») est ramenée à 0,30 s ; Oxley marque de longues pauses (« Commente… Audit… »).
- **Horodatage corrigé à la main** pour trois mots mal placés par Whisper (« Audit », « rappelées »,
  « des clients »), d'après les silences mesurés par ffmpeg.
- **Six scènes** : compteur de vues · entonnoir (exemple fictif affiché) · nuit sans rappel ·
  checklist (passage calme) · commentaire « AUDIT » · abonnement.
- Calage : « Cherche la fuite » tombe sur l'entrée de la batterie (3,56 s), la checklist sur le passage
  calme (17,86 s), « Commente Audit » sur le retour de la batterie (23,83 s). La scène de nuit arrive
  1,5 s après le début de la partie B : les phrases 3 et 4 sont trop longues pour tenir avant.
