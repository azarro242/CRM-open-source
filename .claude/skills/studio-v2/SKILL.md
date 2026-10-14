---
name: studio-v2
description: >
  Point d'entrée de toute nouvelle production vidéo Studio V2 (qualité avancée) :
  vidéo à partir d'un prompt / script / storyboard, à partir d'images à animer, ou à
  partir d'une vidéo d'exemple, avec liens et ressources externes. À utiliser dès que
  l'utilisateur demande de créer, générer, monter ou animer une nouvelle vidéo.
  Impose les trois questions d'ouverture (format, voix off, sous-titres) avant de produire.
---

# Studio V2 — démarrage d'une production

Sources de vérité (à lire **avant** d'agir, dans cet ordre) :
1. `studio-v2/PROTOCOLE.md` — portes d'entrée, questions, déroulé, formats de livraison
2. `studio-v2/QUALITE.md` — exigences qualité (acquis V1 + éléments d'amélioration V2)
3. `.agents/skills/hyperframes/SKILL.md` — moteur de rendu

## Étapes

1. **Environnement** — lancer `bash outils/setup.sh`.
2. **Porte d'entrée** — identifier A (prompt), B (images) ou C (vidéo d'exemple).
   Rapatrier tous les éléments fournis dans `studio-v2/sources/<nom>/`.
3. **Questions d'ouverture** — poser via `AskUserQuestion`, en un seul appel, les
   questions dont la réponse n'est pas déjà explicite dans la demande :
   - Q1 Format / dimensions (et : vidéo complète ou calque à superposer)
   - Q2 Voix off
   - Q3 Sous-titres
   Option recommandée en premier, déduite de l'historique du client quand c'est possible.
4. **Brief** — copier `studio-v2/modeles/BRIEF.md` vers `studio-v2/projets/<nom>/BRIEF.md`,
   le remplir, et le récapituler au client (dit / déduit séparés).
5. **Production** — `hyperframes init` dans `studio-v2/projets/<nom>/`, puis composer en
   appliquant **chaque** règle de `QUALITE.md`.
6. **Contrôle** — `npm run check` sans erreur, puis un instantané par scène inspecté
   visuellement. Corriger avant le rendu.
7. **Livraison** — export dans `studio-v2/exports/`, `SendUserFile`, commit + push.

## Règles

- Ne jamais commencer la composition avant d'avoir les réponses aux trois questions.
- Toute nouvelle consigne qualité donnée par le client est ajoutée à `QUALITE.md`
  (partie 2, datée) **dans le même tour**, puis appliquée.
- Répondre en français.
