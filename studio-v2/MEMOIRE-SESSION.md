# Mémoire de session — à lire au début de toute nouvelle conversation

Passation rédigée le 29/10/2026 pour reprendre le travail dans une nouvelle conversation, sans perdre ce qui a
été convenu avec le client (Alvarez Mouko, agence **Oddysee**, Marrakech). Elle complète les fichiers de
référence ci-dessous, qui restent la source de vérité.

## 1. À lire avant d'agir

| Fichier | Contenu |
|---|---|
| `CLAUDE.md` (racine) | Règles de session, contraintes de l'environnement |
| `.claude/skills/studio-v2/SKILL.md` | Démarrage d'une production |
| `studio-v2/PROTOCOLE.md` | Portes d'entrée, questions, types de contenu, livraison |
| `studio-v2/QUALITE.md` | Toutes les consignes qualité, datées (partie 2 = consignes du client) |
| `studio-v2/marque/oddysee/FICHE-MARQUE.md` | Fiche de l'agence |
| `studio-v2/marque/oddysee/mascottes/INDEX.md` | Catalogue des mascottes |
| `studio-v2/projets/oddysee-serie-60/README.md` | Calendrier de la série, mascottes déjà utilisées |
| `studio-v2/projets/oddysee-serie-60/SCRIPTS-J0x.md` | Scripts du jour |
| `reports/Plan 60 vidéos publicité IA.md` | Plan des 60 sujets, sources |
| `studio-v2/references/REF-03-medecin-anatomie-darija.md` | Format « médecin + anatomie » en darija |
| `studio-v2/marque/centre-readaptation-chine/FICHE-MARQUE.md` | Clinique cliente |

## 2. Règles de travail convenues dans la conversation

- **Langue** : répondre en français, simplement (le client n'est pas technicien).
- **Descriptions** : toujours coller les textes de publication **en entier dans la réponse**, jamais
  seulement le chemin du fichier (consigne du client).
- **Flux quotidien de la série 60** :
  1. Le client demande « donne-moi le script de la vidéo de 9 h / 12 h 30 / 15 h 30 / 18 h 30 » ou « de la
     prochaine vidéo ». Je livre, dans la réponse :
     - le texte ElevenLabs en bloc, avec les réglages (voix **Oxley - Evil Character**, Eleven v3, stabilité 50,
       similarité 75, vitesse 1.0) et le nom du fichier attendu ;
     - le tableau de ce qu'on verra à l'écran ;
     - les mascottes ;
     - le message privé AUDIT.

     J'écris aussi `voix.txt` et la section du `SCRIPTS-J0x.md`, puis je commite.
  2. Le client envoie le MP3 avec « genere la video ». Je monte la vidéo, je la rends, je la mixe et je
     l'exporte dans `studio-v2/exports/serie-60/`. Je l'envoie avec SendUserFile, avec toutes les descriptions
     dans la réponse, puis je commite.
- **Écriture** :
  - partir de la douleur du spectateur, puis la vraie cause, puis un levier de croissance ;
  - 56 à 65 mots ;
  - mot-clé **AUDIT** ;
  - exemples fictifs annoncés à l'écran ;
  - chiffres seulement s'ils sont sourcés et vérifiés le jour même.
- **Mascottes** : sept par vidéo, styles mélangés, jamais deux fois la même dans une journée. Relevé dans le
  README de la série.
- **Sécurité** :
  - ne jamais demander de clé d'API dans la conversation (`ELEVENLABS_API_KEY` uniquement par les réglages de
    l'environnement) ;
  - ne jamais demander de numéros de carte ;
  - aucune voix provisoire.
- **Dépôt** :
  - travailler sur la branche `claude/heygen-hyperframes-video-edit-24sk2m` ;
  - pas de nouvelle demande de fusion (la n° 1 existe) ;
  - ne pas toucher au fichier `claude.md` en minuscules ;
  - ne jamais mettre d'identifiant de modèle dans les commits ;
  - si l'envoi vers GitHub est refusé (403), le signaler, sans le contourner.

## 3. Fabrication d'une vidéo de la série 60 (recette éprouvée)

1. **Copier le projet** du dernier jour (le plus récent : `J04-33-devis-22h/`) vers
   `J0x-<ID>-<sujet>/` : `build.py`, `gabarit.tpl`, `vendor/`, `assets/` (polices, musique, sfx, logos), et
   les fichiers de config. Mettre à jour les identifiants dans `meta.json` et `package.json`.
2. **Mascottes** : copier les sept fichiers du catalogue dans `assets/img/m-s1a-…`, `m-s1b-…`, `m-s2-…` …
   `m-s6-…`.
3. **Horodater la voix** : `python3 ../../../../outils/aligner.py voix.mp3 voix.txt voix.transcript.json`.
   Contrôler l'enveloppe d'énergie : Whisper colle souvent « Commente Audit ». Corriger à la main dans le JSON.
4. **Adapter `build.py`** : le dictionnaire `C` (mots repères), `FORTS`, `tics`, `SFX` et, si besoin, les
   réglages suivants :
   - `ECART` 0,12 et `PAUSE_MAX` 0,30 / `PAUSE_COURTE` 0,24 si la partie B tombe en retard ;
   - ancre de la dernière phrase si la carte AUDIT reste moins d'une seconde.

   Objectif : « dérive des ancres » à 0,00 s.
5. **Gabarit** : remplacer les scènes S1 à S4 (CSS, HTML, JS). Garder le **premier** bloc CSS « éléments
   communs » (`.cam`, `.sur`, `.masc`) : le bloc propre à la vidéo commence au **second**. Adapter aussi :
   - le titre de la carte S5 (trois mots au plus) ;
   - les repères du badge et du rappel en S6.
6. **Contrôler** : `npx --yes hyperframes@0.8.193 check`.
   - Aucune erreur, aucun avertissement de lecture (`line_unread`), aucun avertissement de contraste.
   - Restent normalement 11 avertissements de structure, acceptés.
   - Puis prendre des instantanés aux moments clés et les regarder.
7. **Rendre** : `npx --yes hyperframes@0.8.193 render --fps 30 --quality looks --output renders/brut.mp4`
   (≈ 8 min, en arrière-plan).
8. **Mixer** : `python3 ../../../../outils/mixage.py . renders/brut.mp4 ../../../exports/serie-60/<nom>.mp4 --rapport …png --limite 0.66`.
   - Cible : −14 LUFS, crête vraie ≤ −1,5 dBTP.
   - Essayer 0,72 si le master reste sous −14,5 LUFS.
9. **Finaliser** : écrire `DESCRIPTIONS.md` et `FABRICATION.md`, mettre à jour le calendrier et le relevé des
   mascottes du README, commiter, envoyer.

## 4. État au 29/10/2026

**Sujets déjà traités (ne pas refaire)** : 13, N20, N02, N07, N06, 59, 34, N18, 31, 39, 18, N05, 24, 33.

| Jour | 9 h | 12 h 30 | 15 h 30 | 18 h 30 |
|---|---|---|---|---|
| J1 | 13 ✓ | N20 ✓ | — | N02 ✓ |
| J2 | N07 ✓ | N06 ✓ | 59 ✓ | 34 ✓ |
| J3 | N18 ✓ | 31 ✓ | 39 ✓ | — (le sujet 18 est passé au J4) |
| J4 | 18 ✓ | 33 ✓ | N05 ✓ | 24 ✓ |

**Prochaines étapes**
- Jour 5 : proposer quatre sujets du plan non traités, sous l'angle de la douleur, variés. Pistes : 14
  (« Tu accuses le ciblage ? »), 32 (prospect sans réponse), 26 (trois objections), 40 (rapport lisible
  en 30 s), N08 (méfiance au Maroc, chiffres à vérifier), 38 (messages à 23 h).

**Autre production livrée** : Centre de réadaptation de Chine, vidéo « lombalgie » en darija
(`studio-v2/exports/centre-chine/`). Questions toujours ouvertes avec le client :
- le fichier d'origine du logo de la clinique ;
- le badge Baicaotang sur la blouse du médecin ;
- l'ajout éventuel d'une musique.

**Blocage connu** : l'envoi vers GitHub est refusé (erreur 403, accès de Claude au dépôt). Le client doit
reconnecter GitHub sur https://claude.ai/connect-github. Tant que ce n'est pas fait, une nouvelle conversation
ne voit pas les commits restés en local.
