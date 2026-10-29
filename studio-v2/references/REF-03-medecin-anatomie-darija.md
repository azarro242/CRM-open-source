# Référence 03 — « Médecin + anatomie », textes en darija

- **Source** : demande du client du 2026-10-28. Il fournit quatre captures de style (vidéos du
  Centre de réadaptation de Chine), une image d'anatomie, la vidéo d'un médecin qui parle chinois
  (`002.mp4`), sa transcription et la page
  https://get-ads.agency/generated-page/medicine-chinoise/ (planche anatomique interactive).
- **Consigne** : « créer un nouveau format de vidéo que tu devras sauvegarder en mémoire » :
  - mêmes principes de création que la série Oddysee ;
  - style de transitions et d'animations des captures sur chaque personnage ;
  - anatomie utilisée comme sur le lien, en la faisant pivoter ;
  - textes et description en arabe ;
  - éléments « stop scroll » et animations pour captiver.
- **Premier projet** : `projets/centre-chine-lombalgie/` (lombalgie due à la position assise, 45 s).

| Fichier | Rôle |
|---|---|
| `img/ref03-01-puce-nom-icone.png` | Pastille blanche nom + icône ronde dégradée |
| `img/ref03-02-bulle-icone.png` | Bulle ronde flottante avec anneau |
| `img/ref03-03-carte-verre-coordonnees.webp` | Carte de verre sombre + carte d'adresse blanche |
| `img/ref03-04-puces-carte-fin.webp` | Fin de vidéo : pastilles « متابعة », « رعاية », carte, coordonnées |
| `img/ref03-anatomie.png` | Planche d'anatomie (face, profil, dos) de la page de référence |

---

## 1. Le type de contenu

**Reel « médecin + anatomie »**, 9:16, 30 à 60 s. Une vraie vidéo d'un praticien qui parle face
caméra ; **sa voix d'origine est conservée** (même en chinois). Ce qui la rend lisible au Maroc :

- **les textes animés sont les sous-titres** ;
- tout est **en darija** (écriture arabe).

Chaque phrase devient une carte de verre révélée mot à mot pendant qu'il parle. Dès qu'il cite une
partie du corps, une **planche d'anatomie** prend l'écran et le médecin passe en vignette.

## 2. Système visuel (relevé sur les captures)

**Palette**

| Rôle | Couleur |
|---|---|
| Vert | `#40ab75` |
| Turquoise | `#02a5a9` |
| Encre marine | `#21415a` |
| Fond clair menthe | dégradé radial `#ffffff` → `#e7f4f1` → `#cfe8e2`, trame de points turquoise |
| Douleur | rouge `#e5484d` |
| Points d'acupuncture | or `#f2b134` |
| Méridien des reins | bleu `#3b82f6` |

- Le dégradé de marque va du vert au turquoise.
- Pour du texte blanc sur un titre de planche, foncer le dégradé (`#1e7f55` → `#027f82`) pour un
  contraste ≥ 3:1.

**Police** : **Cairo** (arabe + latin, graisses 200–1000), vendorisée en `woff2` dans le projet.
Texte en `dir="rtl"`, téléphones en `dir="ltr"`.

**Composants**

1. **Pastille** (capture 01) :
   - forme : gélule blanche, texte marine 800 ;
   - icône : ronde à dégradé vert → turquoise, placée à droite (RTL) ;
   - entrée : pop avec rotation de 6°, puis flottement lent ;
   - placement : autour de la tête du médecin, jamais sur le visage.
2. **Bulle** (capture 02) : rond dégradé de 96 à 132 px, anneau blanc translucide, icône blanche,
   flottement et pulsation.
3. **Carte de verre / sous-titre** (capture 03) :
   - fond : verre sombre (flou + voile) ;
   - icône : rond dégradé de 116 px à droite ;
   - texte : titre blanc 54 px 800, révélé mot à mot ;
   - trait : souligné en dégradé qui se déroule.
4. **Carte d'adresse** (capture 03) :
   - fond blanc arrondi ;
   - lignes : « repère » (adresse), « téléphone » (numéros), séparateur fin ;
   - mention de prudence en petit.
5. **Fin** (capture 04) :
   - pastilles « متابعة » et « رعاية » ;
   - carte « خود موعدك دابا » ;
   - carte d'adresse ;
   - image figée du médecin.
6. **Logo de la clinique** : badge blanc arrondi en haut à gauche, sur toute la durée.

**Icônes** : tracés de type Lucide en SVG intégré, cohérents avec le sujet :

| Icône | Usage |
|---|---|
| horloge | bureau |
| chaise | position assise |
| colonne | dos |
| aiguille | acupuncture |
| lignes | méridiens |
| cible | points |
| feuille | soulagement |
| main | massage |
| ventouse | bocal posé sur la peau, sans battant pour ne pas ressembler à une cloche |
| lune | repos |
| cœur | soin |
| agenda | suivi |

## 3. La planche d'anatomie (comme sur la page de référence)

**Image et vues**
- Source : `anatomie.png`, la même que la page, avec ses trois vues (face, profil, dos).
- Elle est placée dans le repère de la page (viewBox `133 4 366 883`). Les zones de la page
  (`body-chart.html`, groupes `zone-…`) sont réutilisées telles quelles ; par exemple
  `zone-lombaires` en rouge pour la douleur.
- La planche est une carte blanche à gauche, avec :
  - un titre de section en haut (ex. « أسفل الظهر », « خطوط الطاقة ») ;
  - une légende à pastilles sous la vignette du médecin (« مكان الوجع », « خط المثانة »…).

**« 3D »** : l'image ne contient que trois vues, donc la rotation est une **bascule en `rotationY`**
(0 → 90°, changement de vue, −90° → 0) entre face, profil et dos. Il ne faut pas promettre au
client une rotation continue à 360° : il faudrait pour cela un vrai modèle 3D.

**Animations**
- **Zoom** sur la zone citée (épaules, dos, mollets, creux du genou), avec `scale`, `x` et `y` et
  l'ease `power3.inOut`.
- **Méridiens** tracés en direct : `pathLength=1`, dashoffset de 1 → 0.
- **Points d'acupuncture** : cœur blanc cerclé d'or avec un halo qui pulse ; ils apparaissent un
  par un quand le médecin les nomme.
- **Médecin en vignette** :
  - l'élément `<video>` lui-même est réduit (`scale` 0.3, coins arrondis), en haut à droite,
    dans un anneau turquoise ;
  - il revient plein cadre quand il ne parle plus d'anatomie.

## 4. Stop scroll et rétention

- **0–2 s** : la vidéo entre zoomée (1.22 → 1), avec un flash blanc.
- **Accroche** : une carte de verre pose la douleur en question, avec une pastille rouge « ! » qui
  pulse et une secousse. Exemple : « واش كيضرك ظهرك من القعدة؟ ».
- **Barre de progression** fine en haut, en dégradé.
- **Coups de zoom** sur le médecin aux mots forts : douleur, aiguilles, ventouses.
- **Rythme** : une nouveauté visuelle toutes les 1 à 2 s (pastille, bulle, bascule de vue, tracé,
  point).
- **Bruitages** légers sur chaque apparition (pop, whoosh, clic), toujours sous la voix.

## 5. Règles d'écriture (darija)

- Traduire **fidèlement** ce que dit le praticien, en darija courte et parlée. Exemples :
  - « اللي كيقعد ساعات طويلة ف البيرو » ;
  - « خط المثانة » ;
  - « خط الكلاوي » ;
  - « رمانة الرجل » ;
  - « ورا الركبة ».
- Noms des points : garder la transcription du nom chinois et ajouter l'emplacement en darija.
  Exemple : « وي تشونغ: ورا الركبة ».
- **Message de santé prudent** :
  - « كيعاونو يخففو » plutôt que « كيداويو » ;
  - jamais de promesse de guérison ;
  - mention finale : « الطب الصيني مكمّل، وماشي بديل على الطبيب ».
- Les sous-titres suivent le temps de la parole :
  - entrée 0,05 à 0,15 s avant la phrase ;
  - au moins 0,5 s + 0,3 s par mot à l'écran ;
  - au plus 6 à 7 mots par carte.
- La description de publication est en darija (voir `DESCRIPTIONS.md` du projet). Elle contient :
  - l'accroche de douleur, la méthode, l'adresse et les téléphones ;
  - la mention de prudence ;
  - un conseil de consulter si la douleur est forte ou descend dans la jambe ;
  - des hashtags arabes et français.

## 6. Son

- Voix d'origine du médecin à **−16 LUFS** : passe-haut à 80 Hz, compression douce.
- Bruitages −2 dB pendant la parole.
- Master à **−14 LUFS**, crête vraie ≤ −1,5 dBTP (`projets/centre-chine-lombalgie/mix.py`).
- Pas de musique par défaut, car le praticien parle presque sans pause. Elle peut s'ajouter sur
  demande, très basse.

## 7. Fabrication

1. `build.py` génère `index.html` et `mix.json` à partir des tables `SOUS`, `PUCES`, `BULLES`,
   `SFX`, des vues et des méridiens.
2. `gabarit.tpl` contient le CSS, la structure et la timeline GSAP.
3. Contrôle : `npx hyperframes@0.8.193 check`, puis des instantanés.
4. Rendu : `render --fps 30 --quality looks`.
5. Mixage : `python3 mix.py renders/brut.mp4 <sortie> --rapport <png>`.
6. Pour un nouveau sujet :
   - repérer les temps de parole (enveloppe d'énergie : Whisper découpe mal le chinois) ;
   - écrire `SCRIPT-DARIJA.md` (temps, chinois, traduction, darija, anatomie) ;
   - adapter les tables de `build.py` et la séquence anatomique de `gabarit.tpl`.
