<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1920, height=1080" />
    <title>Uthopia — habillage fond vert 16:9</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      :root {
        --vert-chroma: #00ff00;
        --bleu: #007aff;
        --bleu-clair: #339dff;
        --bleu-fonce: #0066d6;
        --encre: #111113;
        --encre-2: #2e2e32;
        --papier: #ffffff;
        --bord: #e4e4e6;
        --ambre: #fcbb00;
        --ambre-clair: #ffd236;
        --gris: #828289;
      }
      body { margin: 0; background: var(--vert-chroma); font-family: "Inter", sans-serif; }
      #root { position: relative; width: 1920px; height: 1080px; overflow: hidden; }
      #fond-vert { position: absolute; inset: 0; background: var(--vert-chroma); }

      .masque { opacity: 0; visibility: hidden; }

      /* ---- zone graphique : au-dessus des sous-titres ---- */
      .graphique { position: absolute; top: 0; left: 0; width: 1920px; height: 820px; }
      .centre { position: absolute; inset: 0; display: flex; align-items: center; justify-content: center; gap: 40px; }

      .carte {
        background: var(--papier); border: 3px solid var(--bord); border-radius: 28px;
        padding: 44px 60px; display: flex; align-items: center; gap: 34px; color: var(--encre);
      }
      .carte .titre { font-weight: 900; font-size: 62px; letter-spacing: -1px; }
      .carte .sous { font-weight: 600; font-size: 34px; color: var(--gris); margin-top: 8px; }
      .carte svg { flex: none; }

      .chip-bleu {
        background: linear-gradient(180deg, #3ba0ff 0%, #007aff 55%, #0070ea 100%);
        color: #fff; border: none;
      }
      .chip-bleu .titre { color: #fff; }

      /* G2 tuiles outils */
      #g2-grille { display: grid; grid-template-columns: repeat(4, 150px); gap: 26px; }
      .tuile { width: 150px; height: 150px; border-radius: 26px; background: var(--papier);
        border: 3px solid var(--bord); display: grid; place-items: center; }

      /* G6 statistiques */
      .stat { flex-direction: column; gap: 8px; padding: 40px 54px; text-align: center; }
      .stat .chiffre { font-weight: 900; font-size: 78px; color: var(--bleu); letter-spacing: -2px; }
      .stat .legende { font-weight: 700; font-size: 30px; color: var(--encre-2); }

      /* G7 déclaration */
      #g7-carte { flex-direction: column; gap: 6px; padding: 54px 80px; }
      #g7-carte .titre { font-size: 76px; }
      #g7-carte .titre em { font-style: normal; color: var(--bleu); }

      /* G8 étapes */
      .etape-rond { width: 130px; height: 130px; border-radius: 50%; display: grid; place-items: center;
        font-weight: 900; font-size: 62px; color: #fff;
        background: linear-gradient(180deg, #3ba0ff 0%, #007aff 55%, #0070ea 100%); }
      .etape-fleche { color: var(--encre); }
      #g8-legende { position: absolute; left: 0; right: 0; top: 640px; text-align: center;
        font-weight: 900; font-size: 52px; color: var(--encre); }
      #g8-legende span { background: var(--papier); border: 3px solid var(--bord);
        border-radius: 18px; padding: 14px 34px; display: inline-block; }

      /* G9 vidéos sans résultat */
      #g9-pile { display: flex; gap: 30px; }
      .mini-video { width: 190px; height: 120px; border-radius: 20px; background: var(--papier);
        border: 3px solid var(--bord); display: grid; place-items: center; color: var(--bleu); }
      #g9-zero { flex-direction: column; gap: 4px; padding: 36px 54px; border-color: var(--encre); }
      #g9-zero .titre { font-size: 52px; }
      #g9-zero .titre b { color: #e0483e; }

      /* G10 Utopia */
      #g10-carte { flex-direction: column; gap: 10px; padding: 64px 110px; border-radius: 36px; }
      #g10-carte .label { font-weight: 800; font-size: 34px; letter-spacing: 8px; color: #cfe6ff; }
      #g10-carte .marque { font-weight: 900; font-size: 132px; letter-spacing: 4px; color: #fff; }
      #g10-carte .tagline { font-weight: 700; font-size: 34px; color: #e3f1ff; }

      /* G11 piliers */
      .pilier { padding: 30px 48px; border-radius: 999px; gap: 22px; }
      .pilier .titre { font-size: 44px; }

      /* G12 CTA */
      #g12-gratuit { border: none; background: linear-gradient(180deg, var(--ambre-clair), var(--ambre));
        flex-direction: column; gap: 2px; padding: 44px 64px; }
      #g12-gratuit .titre { font-size: 64px; }
      #g12-formation { flex-direction: column; gap: 2px; padding: 44px 64px; }
      #g12-formation .titre { font-size: 64px; color: #fff; }
      #g12-formation .sous { color: #dcecff; }

      /* ---- sous-titres ---- */
      #captions { position: absolute; top: 0; left: 0; width: 1920px; height: 1080px; }
      .cap { position: absolute; left: 100px; right: 100px; top: 856px; text-align: center;
        opacity: 0; visibility: hidden; }
      .cap .pill { display: inline-block; background: var(--encre); color: #fff;
        font-weight: 800; font-size: 50px; line-height: 1.3; padding: 20px 44px;
        border-radius: 22px; letter-spacing: 0.2px; }
      .cap .kb { color: var(--bleu-clair); }
      .cap .ka { color: var(--ambre-clair); }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="uthopia-vert" data-start="0" data-width="1920" data-height="1080" data-duration="132.5">

      <!-- fond vert chroma intégral -->
      <div id="fond-vert" class="clip" data-start="0" data-duration="132.5" data-track-index="0"></div>

      <!-- ============ COUCHE GRAPHIQUE (une apparition à la fois) ============ -->
      <div id="graphiques" class="clip graphique" data-start="0" data-duration="132.5" data-track-index="1">

        <!-- G1 · l'IA va trop vite 3.2 → 10.3 -->
        <div class="centre"><div id="g1" class="carte masque">
          <svg width="110" height="110" viewBox="0 0 48 48" fill="none">
            <rect x="12" y="12" width="24" height="24" rx="5" stroke="#007aff" stroke-width="3" />
            <rect x="19" y="19" width="10" height="10" rx="2" fill="#007aff" />
            <path d="M18 12 V5 M24 12 V5 M30 12 V5 M18 43 V36 M24 43 V36 M30 43 V36 M12 18 H5 M12 24 H5 M12 30 H5 M43 18 H36 M43 24 H36 M43 30 H36" stroke="#007aff" stroke-width="3" stroke-linecap="round" />
          </svg>
          <div><div class="titre">L'IA va trop vite ?</div><div class="sous">La pression est réelle…</div></div>
        </div></div>

        <!-- G2 · nouveaux outils chaque semaine 10.55 → 23.6 -->
        <div class="centre" id="g2-wrap"><div id="g2-grille">
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="8" stroke="#007aff" stroke-width="2.4"/><path d="M12 8 v4 l3 2" stroke="#007aff" stroke-width="2.4" stroke-linecap="round"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><path d="M6 18 L12 5 L18 18" stroke="#fcbb00" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/><path d="M8.5 13.5 h7" stroke="#fcbb00" stroke-width="2.4"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><rect x="5" y="5" width="14" height="14" rx="3" stroke="#0066d6" stroke-width="2.4"/><path d="M9 12 l2.2 2.2 L15.5 9.5" stroke="#0066d6" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><path d="M12 4 l2.2 5 5.3.5 -4 3.6 1.2 5.2 L12 15.6 7.3 18.3 8.5 13.1 4.5 9.5 9.8 9 Z" stroke="#339dff" stroke-width="2.2" stroke-linejoin="round"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><path d="M5 19 V10 M10 19 V5 M15 19 v-6 M20 19 V8" stroke="#e0607f" stroke-width="2.4" stroke-linecap="round"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><path d="M13 3 L6 14 h5 l-1 7 7-11 h-5 Z" stroke="#fcbb00" stroke-width="2.2" stroke-linejoin="round"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><circle cx="9" cy="9" r="4.5" stroke="#007aff" stroke-width="2.4"/><path d="M12.5 12.5 L20 20" stroke="#007aff" stroke-width="2.4" stroke-linecap="round"/></svg></div>
          <div class="tuile masque"><svg width="72" height="72" viewBox="0 0 24 24" fill="none"><rect x="4" y="6" width="16" height="12" rx="3" stroke="#0066d6" stroke-width="2.4"/><path d="M10 10.5 l4 1.5 -4 1.5 Z" fill="#0066d6"/></svg></div>
        </div></div>

        <!-- G3 · par où commencer 23.85 → 33.5 -->
        <div class="centre"><div id="g3" class="carte masque">
          <svg width="110" height="110" viewBox="0 0 48 48" fill="none">
            <circle cx="24" cy="24" r="19" stroke="#007aff" stroke-width="3" />
            <path d="M18 19 a6 6 0 1 1 8.5 5.5 c-1.8.8-2.5 1.8-2.5 3.5" stroke="#007aff" stroke-width="3" stroke-linecap="round" />
            <circle cx="24" cy="34" r="1.8" fill="#007aff" />
          </svg>
          <div><div class="titre">Par où commencer ?</div><div class="sous">Trop d'informations, zéro repère</div></div>
        </div></div>

        <!-- G4 · aucun code requis 33.7 → 43.3 -->
        <div class="centre"><div id="g4" class="carte masque">
          <svg width="110" height="110" viewBox="0 0 48 48" fill="none">
            <path d="M16 16 L8 24 L16 32 M32 16 L40 24 L32 32" stroke="#111113" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
            <path d="M6 42 L42 6" stroke="#e0483e" stroke-width="4" stroke-linecap="round" />
          </svg>
          <div><div class="titre">Pas développeur ?</div><div class="sous">Aucune compétence technique</div></div>
        </div></div>

        <!-- G5 · réservé à une élite 43.45 → 46.1 -->
        <div class="centre"><div id="g5" class="carte masque">
          <svg width="100" height="100" viewBox="0 0 48 48" fill="none">
            <rect x="10" y="20" width="28" height="20" rx="5" stroke="#111113" stroke-width="3" />
            <path d="M16 20 v-4 a8 8 0 0 1 16 0 v4" stroke="#111113" stroke-width="3" />
            <circle cx="24" cy="30" r="3" fill="#111113" />
          </svg>
          <div class="titre">Réservé à une élite ?</div>
        </div></div>

        <!-- G6 · statistiques 46.4 → 64.1 -->
        <div class="centre" id="g6-wrap">
          <div id="g6-a" class="carte stat masque"><div class="chiffre">2 ans</div><div class="legende">de pratique quotidienne</div></div>
          <div id="g6-b" class="carte stat masque"><div class="chiffre">100+ h</div><div class="legende">de contenus &amp; formations</div></div>
          <div id="g6-c" class="carte stat masque"><div class="chiffre">100+</div><div class="legende">entreprises accompagnées</div></div>
        </div>

        <!-- G7 · pas en retard 64.3 → 72.6 -->
        <div class="centre"><div id="g7-carte" class="carte masque">
          <div class="titre">Le problème, ce n'est pas <em>ton retard</em>.</div>
          <div class="sous">C'est l'absence de méthode.</div>
        </div></div>

        <!-- G8 · étape par étape 72.85 → 88.7 -->
        <div class="centre" id="g8-wrap">
          <div id="g8-e1" class="etape-rond masque">1</div>
          <svg id="g8-f1" class="etape-fleche masque" width="70" height="40" viewBox="0 0 35 20" fill="none"><path d="M2 10 h26 m-6 -6 l6 6 -6 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
          <div id="g8-e2" class="etape-rond masque">2</div>
          <svg id="g8-f2" class="etape-fleche masque" width="70" height="40" viewBox="0 0 35 20" fill="none"><path d="M2 10 h26 m-6 -6 l6 6 -6 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
          <div id="g8-e3" class="etape-rond masque">3</div>
        </div>
        <div id="g8-legende" class="masque"><span>Une méthode <b style="color:var(--bleu)">étape par étape</b></span></div>

        <!-- G9 · rien de concret 88.95 → 97.6 -->
        <div class="centre" id="g9-wrap" style="flex-direction:column;gap:34px">
          <div id="g9-pile">
            <div class="mini-video masque"><svg width="52" height="52" viewBox="0 0 24 24" fill="none"><path d="M9 8 l8 4 -8 4 Z" fill="currentColor"/></svg></div>
            <div class="mini-video masque"><svg width="52" height="52" viewBox="0 0 24 24" fill="none"><path d="M9 8 l8 4 -8 4 Z" fill="currentColor"/></svg></div>
            <div class="mini-video masque"><svg width="52" height="52" viewBox="0 0 24 24" fill="none"><path d="M9 8 l8 4 -8 4 Z" fill="currentColor"/></svg></div>
            <div class="mini-video masque"><svg width="52" height="52" viewBox="0 0 24 24" fill="none"><path d="M9 8 l8 4 -8 4 Z" fill="currentColor"/></svg></div>
          </div>
          <div id="g9-zero" class="carte masque"><div class="titre">Des dizaines de vidéos… <b>rien de concret</b></div></div>
        </div>

        <!-- G10 · révélation Utopia 97.9 → 108.3 -->
        <div class="centre"><div id="g10-carte" class="carte chip-bleu masque">
          <div class="label">LE PROJET</div>
          <div class="marque">UTOPIA</div>
          <div class="tagline">L'IA, simplement — même en partant de zéro</div>
        </div></div>

        <!-- G11 · les 4 piliers 108.6 → 124.1 -->
        <div class="centre" id="g11-wrap" style="flex-wrap:wrap;align-content:center;gap:34px;padding:0 320px">
          <div id="g11-a" class="carte pilier masque"><svg width="54" height="54" viewBox="0 0 24 24" fill="none"><path d="M12 4 a6 6 0 0 1 6 6 c0 2.5-1.5 3.6-2.5 4.8 -.7.8-.9 1.7-.9 2.7 h-5.2 c0-1-.2-1.9-.9-2.7 C7.5 13.6 6 12.5 6 10 a6 6 0 0 1 6-6 Z" stroke="#007aff" stroke-width="2.4" stroke-linejoin="round"/><path d="M10 21 h4" stroke="#007aff" stroke-width="2.4" stroke-linecap="round"/></svg><div class="titre">Comprendre</div></div>
          <div id="g11-b" class="carte pilier masque"><svg width="54" height="54" viewBox="0 0 24 24" fill="none"><path d="M13 3 L6 14 h5 l-1 7 7-11 h-5 Z" stroke="#007aff" stroke-width="2.2" stroke-linejoin="round"/></svg><div class="titre">Utiliser</div></div>
          <div id="g11-c" class="carte pilier masque"><svg width="54" height="54" viewBox="0 0 24 24" fill="none"><path d="M4 19 L10 13 l3 3 L20 9" stroke="#007aff" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/><path d="M15 9 h5 v5" stroke="#007aff" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/></svg><div class="titre">Développer</div></div>
          <div id="g11-d" class="carte pilier masque"><svg width="54" height="54" viewBox="0 0 24 24" fill="none"><circle cx="9" cy="14" r="5" stroke="#fcbb00" stroke-width="2.4"/><path d="M12.5 10.5 L20 3 M17 6 h3 M17 6 v3" stroke="#fcbb00" stroke-width="2.4" stroke-linecap="round"/></svg><div class="titre">Compétence clé</div></div>
        </div>

        <!-- G12 · CTA final 124.35 → 132.2 -->
        <div class="centre" id="g12-wrap">
          <div id="g12-gratuit" class="carte masque"><div class="titre">Ressources</div><div class="titre">100% GRATUITES</div></div>
          <div id="g12-formation" class="carte chip-bleu masque"><div class="titre">La formation →</div><div class="sous">accessible &amp; organisée pour tous</div></div>
        </div>
      </div>

      <!-- ============ SOUS-TITRES ============ -->
      <div id="captions" class="clip" data-start="0" data-duration="132.5" data-track-index="2">
{{CAPTIONS_HTML}}
      </div>

      <!-- ============ AUDIO ============ -->
      <audio id="vo" src="Audio-Uthopia.mp3" data-start="0" data-track-index="10" data-volume="1"></audio>

      <audio id="wh-1" src="assets/sfx/whoosh-short.mp3" data-start="3.15" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-2" src="assets/sfx/whoosh-short.mp3" data-start="10.50" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-3" src="assets/sfx/whoosh-short.mp3" data-start="23.80" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-4" src="assets/sfx/whoosh-short.mp3" data-start="33.65" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-5" src="assets/sfx/whoosh-short.mp3" data-start="43.40" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-6" src="assets/sfx/whoosh-short.mp3" data-start="64.25" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-7" src="assets/sfx/whoosh-short.mp3" data-start="72.80" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-8" src="assets/sfx/whoosh-short.mp3" data-start="88.90" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-9" src="assets/sfx/whoosh-short.mp3" data-start="108.55" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>
      <audio id="wh-10" src="assets/sfx/whoosh-short.mp3" data-start="124.30" data-duration="0.57" data-track-index="11" data-volume="0.45"></audio>

      <audio id="imp-1" src="assets/sfx/impact-bass-1.mp3" data-start="64.35" data-duration="2.11" data-track-index="12" data-volume="0.5"></audio>
      <audio id="imp-2" src="assets/sfx/impact-bass-1.mp3" data-start="98.00" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="imp-3" src="assets/sfx/impact-bass-1.mp3" data-start="128.80" data-duration="2.11" data-track-index="12" data-volume="0.5"></audio>

      <audio id="pop-1" src="assets/sfx/pop.mp3" data-start="10.90" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-2" src="assets/sfx/pop.mp3" data-start="46.60" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-3" src="assets/sfx/pop.mp3" data-start="50.05" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-4" src="assets/sfx/pop.mp3" data-start="54.95" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="clk-1" src="assets/sfx/click-soft.mp3" data-start="73.15" data-duration="0.36" data-track-index="13" data-volume="0.5"></audio>
      <audio id="clk-2" src="assets/sfx/click-soft.mp3" data-start="74.05" data-duration="0.36" data-track-index="13" data-volume="0.5"></audio>
      <audio id="clk-3" src="assets/sfx/click-soft.mp3" data-start="74.95" data-duration="0.36" data-track-index="13" data-volume="0.5"></audio>
      <audio id="clk-4" src="assets/sfx/click-soft.mp3" data-start="89.55" data-duration="0.36" data-track-index="13" data-volume="0.5"></audio>
      <audio id="clk-5" src="assets/sfx/click-soft.mp3" data-start="90.25" data-duration="0.36" data-track-index="13" data-volume="0.5"></audio>
      <audio id="clk-6" src="assets/sfx/click-soft.mp3" data-start="90.95" data-duration="0.36" data-track-index="13" data-volume="0.5"></audio>
      <audio id="pop-5" src="assets/sfx/pop.mp3" data-start="94.30" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-6" src="assets/sfx/pop.mp3" data-start="108.95" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-7" src="assets/sfx/pop.mp3" data-start="111.30" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-8" src="assets/sfx/pop.mp3" data-start="113.85" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-9" src="assets/sfx/pop.mp3" data-start="117.35" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>
      <audio id="pop-10" src="assets/sfx/pop.mp3" data-start="124.75" data-duration="0.72" data-track-index="13" data-volume="0.45"></audio>

      <audio id="riser-1" src="assets/sfx/riser.mp3" data-start="95.20" data-duration="2.80" data-media-start="6.5" data-track-index="14" data-volume="0.28"></audio>
      <audio id="spark-1" src="assets/sfx/sparkle.mp3" data-start="98.55" data-duration="1.80" data-track-index="14" data-volume="0.4"></audio>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });

      /* Entrées/sorties SANS fondu d'opacité (incrustation chroma) :
         apparition = pop d'échelle opaque ; disparition = rétrécissement puis set. */
      function popIn(sel, t, d = 0.4) {
        tl.set(sel, { autoAlpha: 1 }, t);
        tl.fromTo(sel, { scale: 0 }, { scale: 1, duration: d, ease: "back.out(1.9)" }, t);
      }
      function popOut(sel, t, d = 0.22) {
        tl.to(sel, { scale: 0, duration: d, ease: "power2.in" }, t);
        tl.set(sel, { autoAlpha: 0 }, t + d);
      }

      /* G1 */ popIn("#g1", 3.2); popOut("#g1", 10.28);
      /* G2 */
      tl.set("#g2-grille .tuile", { autoAlpha: 1 }, 10.55);
      tl.fromTo("#g2-grille .tuile", { scale: 0 }, { scale: 1, duration: 0.38, ease: "back.out(2)", stagger: 0.16 }, 10.55);
      tl.to("#g2-grille .tuile", { y: -8, duration: 0.5, ease: "sine.inOut", yoyo: true, repeat: 3, stagger: 0.1 }, 13.4);
      popOut("#g2-grille", 23.55);
      tl.set("#g2-grille .tuile", { autoAlpha: 0 }, 23.8);
      /* G3 */ popIn("#g3", 23.85); popOut("#g3", 33.42);
      /* G4 */ popIn("#g4", 33.7); popOut("#g4", 43.18);
      /* G5 */ popIn("#g5", 43.45); popOut("#g5", 46.12);
      /* G6 */ popIn("#g6-a", 46.6); popIn("#g6-b", 50.05); popIn("#g6-c", 54.95);
      popOut("#g6-a", 64.02); popOut("#g6-b", 64.05); popOut("#g6-c", 64.08);
      /* G7 */ popIn("#g7-carte", 64.35, 0.45); popOut("#g7-carte", 72.58);
      /* G8 */
      popIn("#g8-e1", 73.15, 0.32); popIn("#g8-f1", 73.6, 0.25);
      popIn("#g8-e2", 74.05, 0.32); popIn("#g8-f2", 74.5, 0.25);
      popIn("#g8-e3", 74.95, 0.32); popIn("#g8-legende", 75.6, 0.35);
      popOut("#g8-e1", 88.6); popOut("#g8-f1", 88.62); popOut("#g8-e2", 88.64);
      popOut("#g8-f2", 88.66); popOut("#g8-e3", 88.68); popOut("#g8-legende", 88.62);
      /* G9 */
      popIn("#g9-pile .mini-video:nth-child(1)", 89.55, 0.3);
      popIn("#g9-pile .mini-video:nth-child(2)", 90.25, 0.3);
      popIn("#g9-pile .mini-video:nth-child(3)", 90.95, 0.3);
      popIn("#g9-pile .mini-video:nth-child(4)", 91.6, 0.3);
      popIn("#g9-zero", 94.3, 0.4);
      popOut("#g9-pile", 97.55); popOut("#g9-zero", 97.58);
      tl.set("#g9-pile .mini-video", { autoAlpha: 0 }, 97.9);
      /* G10 */
      popIn("#g10-carte", 98.0, 0.5);
      tl.to("#g10-carte", { scale: 1.04, duration: 0.6, ease: "sine.inOut", yoyo: true, repeat: 3 }, 99.0);
      popOut("#g10-carte", 108.28);
      /* G11 */
      popIn("#g11-a", 108.95, 0.35); popIn("#g11-b", 111.3, 0.35);
      popIn("#g11-c", 113.85, 0.35); popIn("#g11-d", 117.35, 0.35);
      popOut("#g11-a", 124.0); popOut("#g11-b", 124.03); popOut("#g11-c", 124.06); popOut("#g11-d", 124.09);
      /* G12 */
      popIn("#g12-gratuit", 124.75, 0.4);
      popIn("#g12-formation", 128.85, 0.45);
      tl.to("#g12-formation", { scale: 1.05, duration: 0.5, ease: "sine.inOut", yoyo: true, repeat: 4 }, 129.6);
      popOut("#g12-gratuit", 131.95); popOut("#g12-formation", 131.98);

      /* ---------- sous-titres ---------- */
      {{CAPTIONS_TWEENS}}

      window.__timelines["uthopia-vert"] = tl;
    </script>
  </body>
</html>
