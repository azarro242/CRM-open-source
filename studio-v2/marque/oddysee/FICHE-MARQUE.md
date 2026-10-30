# Oddysee — fiche de marque pour les vidéos

Agence du client (fondateur : Alvarez Mouko). Fiche établie le 2026-10-24 à partir des quatre
pages fournies par le client, à exploiter **selon le sujet de chaque script** :

| Page | Contenu utile | Lien |
|---|---|---|
| Accueil | Promesse, chiffres clés, 5 services, méthode en 4 étapes, témoignages, FAQ | https://www.oddysee.fr/ |
| Web | Offre « site en 7 jours », comparatif agences locales, chiffres, prix, FAQ | https://www.oddysee.fr/web |
| À propos | Histoire du fondateur, mission / vision / valeurs, équipe | https://www.oddysee.fr/a-propos |
| Services | Les 5 expertises, GetAds et Oddcast | https://www.oddysee.fr/services |

Ressources du dossier : `logos/` (SVG noir et blanc), `polices/` (Outfit, toutes graisses),
`captures/site-oddysee-accueil.png`, `mascottes/` (voir `mascottes/INDEX.md`).

---

## 1. Identité visuelle (extraite du site)

| Rôle | Couleur |
|---|---|
| Violet de marque | `#632BC5` |
| Violet vif | `#6A3BE8` |
| Violet pâle | `#A877FF` |
| Lilas | `#E2D7F7` |
| Brume (fond clair) | `#F7F3FF` |
| Or (accent secondaire) | `#D4A847` / `#F0C860` |
| Encre | `#1D1D1D` |

- Police : **Outfit** (300 à 900), vendorisée dans `polices/`.
- Logo : `logos/logo-oddysee-noir.svg` sur fond clair, `logo-oddysee-blanc.svg` sur fond foncé.
- Corps des mascottes : violet ≈ `#5A14D2`.

## 2. Format vidéo Oddysee — « Reel mascotte » d'environ 25 s

Consigne du client du 2026-10-24 : vidéos d'**environ 25 secondes**, avec les mascottes, la voix
Oxley, en s'appuyant sur les modèles fournis (REF-01 et REF-02).

**Ce qu'on reprend de chaque référence**
- De **REF-02** (FUNL) : le système visuel — mascotte expressive tête photo N&B / corps en
  bâton, sous-titres karaoké, chiffre choc avec pastille de source, cartes sombres, vraies
  captures, gags visuels, enchaînement continu sans coupe franche, musique de fond permanente.
- De **REF-01** (Maxence Tison) : la durée courte et le **script publicitaire en 5 temps**,
  la synchronisation voix ↔ image au mot près, le produit montré en usage, la sobriété.

**Direction artistique par défaut** (aux couleurs d'Oddysee, à la place du sauge et du citron
de REF-02) — proposée, à confirmer sur la première vidéo :
- Fond **brume** `#F7F3FF` avec trame de points discrète et léger vignettage.
- Accent unique **violet** `#632BC5` : le mot prononcé du karaoké passe en encadré violet,
  texte blanc ; chiffres choc en violet.
- Cartes **encre** `#1D1D1D` à coins arrondis, texte blanc ; or `#F0C860` réservé aux badges
  (ex. « Meta Business Partner »).
- Titres en **Outfit 800 en capitales**, sous-titres karaoké Outfit 800.
- Variante **collage** : fond papier crème texturé + mascotte 26 (costume violet à liseré
  crème) pour les transitions.
- Logo Oddysee en signature finale.

**Gabarit d'écriture — 25 s, environ 55 à 65 mots**
(débit à recaler après le premier essai de la voix Oxley, plutôt lente et posée)

| Temps | Durée | Contenu | Mascotte |
|---|---|---|---|
| 1. Accroche | 0–3 s | Une douleur ou un fait précis qui touche le chef d'entreprise | émotion négative (problème) |
| 2. Retournement | 3–7 s | « Mais… » : la nuance ou la bonne nouvelle | stupéfait / surprise |
| 3. Solution Oddysee | 7–17 s | 2 ou 3 idées courtes, une animation chacune (capture réelle, carte) | sourire, désigne 22 |
| 4. Preuve | 17–21 s | Un chiffre du site, avec sa pastille de source | fier / sourire |
| 5. Appel à l'action + signature | 21–25 s | « Commente [MOT] » → ressource offerte, puis « abonne-toi » + raison, logo | victoire, rire, salut |

Si le client fournit une musique, elle fixe la durée et le rythme (voir `QUALITE.md`, 24/10).

Procédés REF-02 bienvenus s'ils tiennent dans 25 s : formule à retenir, mot détourné, humour
discret, dernière phrase qui reprend l'accroche (boucle).

## 3. Voix off des vidéos Oddysee

Choix du client (2026-10-24) : **Oxley - Evil Character** (ElevenLabs).

| Champ | Valeur |
|---|---|
| Identifiant (voice_id) | `2gPFXx8pN3Avh27Dw5Ma` |
| Profil | Homme mûr, accent américain, ton grave et inquiétant (« présage des événements funestes ») — voix multilingue |
| Fiche | https://elevenlabs.io/app/voice-library?voiceId=2gPFXx8pN3Avh27Dw5Ma |
| Génération | `python3 outils/elevenlabs.py generer --voix 2gPFXx8pN3Avh27Dw5Ma --texte script.txt --sortie studio-v2/projets/<nom>/voix.mp3 --langue fr` |

- La question d'ouverture Q2 est donc **déjà répondue** pour Oddysee : ElevenLabs, voix Oxley.
- C'est une voix anglophone : en français, un **léger accent** peut rester. Premier essai à
  faire écouter au client avant de monter toute la vidéo.
- Le ton « méchant » se prête à un contraste humoristique : accroche dramatique sur le problème,
  puis la solution Oddysee.
- Il faut la clé `ELEVENLABS_API_KEY` dans l'environnement (voir `PROTOCOLE.md` § 2).

## 4. Ce que dit Oddysee

- **Promesse** : « Nous aidons les chefs d'entreprise et entrepreneurs à obtenir plus de
  clients grâce à la publicité en ligne. » — [accueil](https://www.oddysee.fr/)
- **Positionnement** : « On connecte vos campagnes, votre site et vos contenus dans un seul
  écosystème […] faire de vous une figure d'autorité respectée sur votre marché. » — [accueil](https://www.oddysee.fr/)
- **Conviction du fondateur** : après trois échecs entrepreneuriaux, « aucune entreprise ne peut
  grandir sans clients ». — [à propos](https://www.oddysee.fr/a-propos)
- **Mission** : créer des systèmes digitaux qui font grandir. **Vision** : transformer chaque
  interaction en levier de croissance. **Valeurs** : exigence, performance, esprit collectif. — [à propos](https://www.oddysee.fr/a-propos)
- **Idée forte de la FAQ** : « la publicité seule ne suffit pas » — site, message, publicité et
  suivi travaillés ensemble. — [accueil](https://www.oddysee.fr/)
- **Honnêteté** : « Aucune agence sérieuse ne peut garantir un chiffre — c'est interdit par Meta
  et malhonnête. » — [web](https://www.oddysee.fr/web) → **ne jamais promettre de résultat chiffré
  dans un script.**
- **Comparatif** (page web) — *agences locales* : site vitrine statique, forfait, livrent puis
  disparaissent, design générique. *Oddysee* : site interactif, trafic + conversion, pilotage
  des campagnes Meta après livraison, animations premium. — [web](https://www.oddysee.fr/web)
- **Accroche de la page web** : « Vos concurrents sont déjà en ligne. Pas vous. » / « Chaque jour
  sans site web, c'est des clients qui achètent chez vos concurrents. » — [web](https://www.oddysee.fr/web)

## 5. Chiffres et preuves — toujours afficher la source

| Chiffre | Formulation du site | Source |
|---|---|---|
| **+1,9 M€** | de chiffre d'affaires généré pour nos clients en 3 ans | [accueil](https://www.oddysee.fr/) |
| **Meta Business Partner** | certifiée ; « première agence à détenir ce statut à Marrakech et au Maroc » | [accueil](https://www.oddysee.fr/) |
| **Depuis 2019** | le fondateur est certifié Meta Business Partner ; 6 mois chez Meta (juin–déc. 2020) | [à propos](https://www.oddysee.fr/a-propos) |
| **+600 000 €** | de budgets publicitaires gérés | [à propos](https://www.oddysee.fr/a-propos) |
| **+200** | entreprises accompagnées | [web](https://www.oddysee.fr/web) |
| **8 pays, 3 continents** | Amérique · Europe · Afrique | [web](https://www.oddysee.fr/web) |
| **7 jours** | de la commande au site en ligne (5 jours en urgence) | [web](https://www.oddysee.fr/web) |
| **+2 M** | de prospects générés pour nos clients | [web](https://www.oddysee.fr/web) |
| **7 à 14 jours** | délai habituel des premières demandes après mise en ligne | [web](https://www.oddysee.fr/web) |
| **< 3 mois** | « nos clients récupèrent en général leur investissement » | [web](https://www.oddysee.fr/web) |
| **102 000 € → 398 000 €** | volume de paiements 2024 → 2025 (×3,9), tableau de bord | [web](https://www.oddysee.fr/web) — ⚠ client concerné non précisé : à confirmer avant usage |
| **8 clients par mois** | « pour préserver la qualité de notre accompagnement » | [web](https://www.oddysee.fr/web) |

Pastille à l'écran : « Source : oddysee.fr » (+ la page). Étiqueter « CAPTURE RÉELLE » quand on
montre une capture du site.

## 6. Offre

**Les 5 expertises** — [services](https://www.oddysee.fr/services)
1. **Obtenir plus de clients** — campagnes Meta ciblées pour des demandes qualifiées en continu.
2. **Convertir vos visiteurs en clients** — sites et pages mobiles, rapides, orientés action.
3. **Devenir la référence de votre marché** — design, charte, direction artistique.
4. **Construire votre autorité en ligne** — contenus photo, vidéo, réseaux sociaux.
5. **Ne plus perdre un seul prospect** — suivi automatisé, relances WhatsApp et e-mail avec Get-Ads.

**Solutions maison** : **GetAds** (publicité et gestion des leads, https://www.get-ads.agency/),
**Oddcast** (réservation de studios, https://www.oddcast.fr/). — [services](https://www.oddysee.fr/services)

**Méthode en 4 étapes** : cadrage stratégique → stratégie et plan d'action → création et
réalisation → lancement et optimisation. — [accueil](https://www.oddysee.fr/)

**Site en 7 jours** — [web](https://www.oddysee.fr/web) : jours 1–2 cadrage (45 min d'échange) ·
jours 2–4 maquettes · jours 5–6 intégration (animations, WhatsApp, formulaires, tests mobile) ·
jour 7 mise en ligne + 30 min de formation. Arguments : animations au scroll, micro-interactions,
parcours pensé pour convertir, campagnes Meta derrière. Paiements : virement, Wave, Orange Money,
MTN Money, PayPal, Stripe.

## 7. Témoignages (vidéos sur le site)

| Personne | Profil | Citation |
|---|---|---|
| Safir Mebani | Fondateur, centre de formation, Montpellier | « En 3 semaines, j'ai eu plus de demandes qu'en 6 mois avant. » |
| Guylaine Conquet | Consultante formation, États-Unis | « Aujourd'hui, mes clients me disent que mon site donne confiance. » |
| Céline Goutil | Coach business, Guadeloupe | « J'ai récupéré mon investissement dès le premier mois. » |
| Gisele Balet | Entrepreneure | « J'hésitais depuis 2 ans à faire un site. En 7 jours, c'était fait. » |

Source : [accueil](https://www.oddysee.fr/) et [web](https://www.oddysee.fr/web).

**Références affichées** — logos clients : Puma, Adidas, Clinique Chifa Tasnime, Menara Mall,
Planète Montessori, Euro2C… ; projets web : Montessorie, Hubwell, Galerie des Tanneurs,
Caravanserai, Azergtours, NGBM. — [accueil](https://www.oddysee.fr/)

**Équipe** : Alvarez Mouko (fondateur & CEO), Hamza Outmassint et Imad El Qadi (développeurs
full stack), Redwan Outhouna (creative & marketing manager). — [à propos](https://www.oddysee.fr/a-propos)

## 8. Appels à l'action

- « Réserver mon audit stratégique offert » → https://www.oddysee.fr/votre-solution/web
- « Réponse WhatsApp sous 1 heure · lundi–samedi »
- « Démarrer maintenant » → https://www.oddysee.fr/contact
- Réseaux : Instagram `@oddysee_maroc`, LinkedIn `oddyseefr`, Facebook `oddysee.fr`

## 9. Quelle page exploiter selon le sujet du script

| Sujet de la vidéo | Page | Éléments à montrer |
|---|---|---|
| Publicité Meta, obtenir des clients | accueil, services | +1,9 M€, Meta Business Partner, +600 000 € gérés, service 01 |
| Site web, conversion | web | « Vos concurrents sont déjà en ligne », 7 jours, comparatif, témoignage Gisele Balet |
| Crédibilité, histoire, valeurs | à propos | trois échecs → conviction, Meta depuis 2019, équipe |
| Relance des prospects, automatisation | services | service 05, GetAds, WhatsApp |
| Image de marque, contenus | services | services 03 et 04, Oddcast |

## 10. Points à vérifier avec le client

- **Liste des 8 pays** : le bandeau de la page web cite la Côte d'Ivoire, la FAQ cite le Bénin à
  la place. Ne pas énumérer les pays tant que ce n'est pas tranché.
- **102 000 € → 398 000 €** : de quel client s'agit-il ? À préciser avant de l'afficher.
- **« Première agence Meta Business Partner au Maroc »** : affirmation du site, à afficher avec sa
  source.
