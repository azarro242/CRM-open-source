# Fabrication — VSL YouTube Oddysee « Différence d'expertise »

Type : `references/REF-04-youtube-motion-design.md` (brief client V2, trois vidéos de référence).
Format : 1920 × 1080, 30 i/s, 3 min 23 s (voix 3 min 21 s + 2 s d'écran final).
Exports : `studio-v2/exports/vsl-youtube/` — version sous-titrée, version sans sous-titres, `.srt`.

## Chaîne de fabrication

1. `voix.txt` : le script, une phrase par ligne (L00 à L31) ; `voix.mp3` : la voix du client (sans retouche).
2. `python3 realigner.py voix.mp3 voix.txt voix.transcript.json` : horodatage mot à mot **par fenêtres de
   6 à 14 s** coupées aux vraies pauses. L'outil commun `outils/aligner.py` (une seule passe) dérivait sur
   cette voix de 3 min 21 : fins de phrases jusqu'à 3 s trop tôt (« … et les transformer en clients »
   placé à 172 s au lieu de 176 s). Contrôle : débit par phrase entre 2 et 4 mots/s, écarts couverts par
   des silences.
3. `python3 build.py` → `index.html`, `sous-titres.srt`, `sfx.json`. `--sans-sous` : même montage sans le
   texte incrusté.
4. `npx --yes hyperframes@0.8.193 check` : 0 erreur ; restent les avertissements de structure (sections
   imbriquées, fichier long) et des chevauchements voulus (factures sur le calendrier, créneau commun).
5. Rendu : `npx --yes hyperframes@0.8.193 render --fps 30 --quality looks --output renders/brut.mp4 .`
   (≈ 1 h).
6. `python3 mix.py renders/brut.mp4 sortie.mp4 [renders/brut-sans.mp4 sortie-sans.mp4]` : voix (légère
   compression), musique du client en boucle (fondus de 2,5 s) ≈ 16 dB sous la voix et effacée quand
   elle parle, 56 bruitages plafonnés à 12 dB sous la voix (consigne client du 29/10 : contrôle mesuré,
   bruitage le plus fort −30,8 LUFS momentané pour une voix à −18,8 LUFS) ; −14 LUFS, crête vraie −1,5 dBTP.

## Direction artistique

- Langage des références : cartes de verre et connexions (A), interfaces inclinées, zooms, curseur et clics
  (B), personne au centre de son système (C). Transitions par continuité (fondus enchaînés entre groupes de
  scènes, objets qui se transforment).
- Fond clair : la photo de ciel envoyée par le client, floutée et teintée lilas, avec halos qui dérivent.
  Fond sombre (douleur, Oddysee, Meta, engagement, capacité, fin) : d'après la page d'accueil d'oddysee.fr.
- Sous-titres intégrés (modèle réf. B) : la phrase s'écrit mot à mot au rythme de la voix et glisse
  latéralement ; mots clés en violet, accents en sérif italique (Instrument Serif) comme « *Maximize* » (réf. A).
  La question du prospect (S25) s'écrit dans la bulle et n'est pas doublée en sous-titre.
- Police Outfit (marque), logo Oddysee en haut à gauche, masqué quand le logo est au centre.

## Médias utilisés

| Source | Fichiers |
|---|---|
| Bibliothèque « Face Avatar » (2 zips, 130 images uniques après dédoublonnage) | portraits recadrés `p-debutant`, `p-amateur`, `p-pro`, `p-expert`, `p-dirigeant`, `p-g1` à `p-g7` |
| Photos envoyées dans la conversation | `ciel.jpg` (fond clair, scène « Pendant que tu dors »), `site-hero.jpg`, `logo-onde.jpg` |
| Site oddysee.fr (récupérés le 29/10/2026) | logos Adidas, Puma, Planète Montessori, Menara Mall, Clinique Chifa ; badge Meta Business Partner ; photos d'équipe (Alvarez Mouko, Hamza Outmassint, Imad El Qadi) ; maquettes et captures des projets (Planète Montessori, Hubwell, Caravan Seraï, Azergtours, NGBM) ; page contact (reconstruite en S29) |
| Studio | Outfit, Instrument Serif (vendorisée), musique client de la série 60, bruitages |

Écartés volontairement : images de la bibliothèque montrant des personnalités publiques reconnaissables ou des
affiches avec texte (risque de faux endossement), extractpics « vidéos témoignages » (non demandés ici).

## Manques et substitutions

- **Face caméra** : aucune vidéo fournie → personnes en portraits ronds (bibliothèque) et photo du fondateur
  (site) en S13 et S20.
- **Vraies réunions, tournages, coulisses (S16)** : non fournis → maquettes des projets publiées sur le site.
- **Proches et sommeil (S15)** : pas de photos → carte graphique « Avec tes proches », photo de ciel du client
  pour la nuit.
- **Page de réservation (S29)** : le site renvoie vers un formulaire « Vérifiez si on peut travailler avec
  vous » → page contact reconstruite à l'identique, agenda de réservation illustratif (mention à l'écran).
- **Grille d'audit (S26–S28)** : pas de vraie grille → carte typographique Situation / Blocages / Opportunités,
  actions sans contenu inventé.
- **Musique** : génération ElevenLabs impossible (clé refusée, erreur 401) → musique client de la série 60
  (30 s) en boucle avec fondus. À remplacer si une piste longue est fournie.
- **Fichiers Illustrator** : aucun reçu.

## À valider avant diffusion (affirmations du script, non vérifiées par le studio)

- Références Adidas, Puma, Montessori, Menara Mall (logos repris du site oddysee.fr).
- « Meta Business Partner depuis plus de cinq ans » et formation à Dublin (badge repris du site).
- Travail « avec de grandes agences et des influenceurs majeurs de la francophonie » (aucun nom affiché).
- Lien de réservation réel dans la description YouTube (la vidéo dit « le bouton sous cette vidéo »).
- Droits des photos de la bibliothèque « Face Avatar » (images issues de Pinterest).
