<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Bandeau motion design 9:16 — Claude Code monte tes vidéos</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      :root {
        --bleu: #007aff;
        --bleu-clair: #4aa8ff;
        --bleu-pale: #a7d1ff;
        --ambre: #fcbb00;
        --ambre-clair: #ffd236;
        --rouge: #ff4d3d;
        --rouge-pale: #ff9d94;
        --papier: #ffffff;
        --ardoise: #1b1b20;
        --ardoise-2: #2a2a33;
        --gris: #9a9aa6;
      }
      body { margin: 0; background: {{FOND}}; font-family: "Inter", sans-serif; }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; }
      #fond { position: absolute; inset: 0; background: {{FOND}}; }

      /* ===== BANDEAU NOIR + séparation courbée en dégradé ===== */
      /* bandeau : noir plein jusqu'à 470 px, puis dégradé droit vers le transparent
         (aucune courbe, aucun trait — la vidéo apparaît en fondu dessous) */
      #bandeau { position: absolute; top: 0; left: 0; width: 1080px; height: 730px;
        background: linear-gradient(180deg, #000 0px, #000 470px, rgba(0, 0, 0, 0) 730px); }

      .masque { opacity: 0; visibility: hidden; }

      /* ===== SCÈNE D'ANIMATION (dans le bandeau) ===== */
      .scene { position: absolute; top: 62px; left: 0; width: 1080px; height: 396px; }
      .centre { position: absolute; inset: 0; display: flex; flex-direction: column;
        align-items: center; justify-content: center; gap: 18px; }
      .rangee { display: flex; gap: 16px; justify-content: center; align-items: center; }

      .kicker { font-weight: 900; font-size: 30px; letter-spacing: 7px; color: var(--gris); }
      .kicker.b { color: var(--bleu-clair); }
      .kicker.r { color: var(--rouge-pale); }
      .kicker.a { color: var(--ambre); }

      .titre { font-weight: 900; font-size: 74px; line-height: 1.02; letter-spacing: -2px;
        color: #fff; text-align: center; }
      .titre.md { font-size: 60px; }
      .titre.sm { font-size: 48px; }
      .titre .b { color: var(--bleu-clair); }
      .titre .a { color: var(--ambre-clair); }
      .titre .r { color: var(--rouge-pale); }

      .pave { background: var(--ardoise); border: 4px solid var(--ardoise-2); border-radius: 26px;
        padding: 22px 38px; display: flex; align-items: center; gap: 24px; }
      .pave.b { border-color: var(--bleu); }
      .pave.r { border-color: var(--rouge); background: #2a1210; }
      .pave.a { border-color: var(--ambre); background: #2a2110; }

      .chip { font-weight: 900; font-size: 34px; padding: 14px 30px; border-radius: 999px;
        display: inline-flex; align-items: center; gap: 12px;
        background: var(--ardoise); border: 4px solid var(--ardoise-2); color: #fff; }
      .chip.b { border-color: var(--bleu); color: var(--bleu-clair); }
      .chip.r { border-color: var(--rouge); color: var(--rouge-pale); }
      .chip.a { background: var(--ambre); border-color: var(--ambre-clair); color: #111; }
      .chip.plein-b { background: var(--bleu); border-color: var(--bleu-clair); color: #fff; }
      .chip.plein-r { background: var(--rouge); border-color: #ff8f84; color: #fff; }

      .barre-nulle { position: relative; }
      .barre-nulle .trait { position: absolute; left: 10px; right: 10px; top: 50%; height: 7px;
        background: var(--rouge); border-radius: 4px; transform: scaleX(0); transform-origin: left center; }

      /* modèles de langage (B8) */
      .mini { width: 108px; height: 108px; border-radius: 24px; background: var(--ardoise);
        border: 4px solid var(--ardoise-2); display: grid; place-items: center;
        font-weight: 900; font-size: 30px; color: var(--bleu-pale); }

      /* ordinateur local (B9) */
      #b9-pc { position: relative; }
      #b9-badge { position: absolute; left: 50%; top: 32px; transform: translateX(-50%);
        font-weight: 900; font-size: 26px; color: var(--bleu-clair); }

      /* avatars communauté */
      .avatars { display: flex; }
      .avatars .av { width: 88px; height: 88px; border-radius: 50%; margin: 0 -10px;
        border: 5px solid #000; display: grid; place-items: center;
        font-weight: 900; font-size: 34px; color: #fff; }

      /* ===== SOUS-TITRES (sur votre image, bas de cadre) ===== */
      #captions { position: absolute; top: 0; left: 0; width: 1080px; height: 1920px; }
      .cap { position: absolute; left: 46px; right: 46px; top: 1430px; text-align: center;
        opacity: 0; visibility: hidden; }
      .cap .pill { display: inline-block; background: #000; color: #fff;
        font-weight: 900; font-size: 54px; line-height: 1.24; padding: 18px 34px;
        border-radius: 22px; }
      .cap .kb { color: var(--bleu-clair); }
      .cap .ka { color: var(--ambre-clair); }
      .cap .kr { color: var(--rouge-pale); }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="selfie-overlay" data-start="0" data-width="1080" data-height="1920" data-duration="39.4">

      <div id="fond" class="clip" data-start="0" data-duration="39.4" data-track-index="0"></div>

      <!-- ===== bandeau noir dégradé ===== -->
      <div id="bande-wrap" class="clip" data-start="0" data-duration="39.4" data-track-index="1">
        <div id="bandeau"></div>
      </div>

            <!-- ===== ANIMATIONS ===== -->
      <div id="scenes" class="clip scene" data-start="0" data-duration="39.4" data-track-index="2">

        <!-- B1 · hook 0.05 → 3.5 -->
        <div class="centre">
          <div id="b1-kick" class="kicker a masque">LE SAVAIS-TU ?</div>
          <div id="b1-titre" class="titre masque"><span class="b">Claude Code</span><br />monte tes vidéos</div>
          <div id="b1-chip" class="chip masque">🎬 à ta place</div>
        </div>

        <!-- B2 · la preuve 3.55 → 8.7 -->
        <div class="centre">
          <div id="b2-kick" class="kicker b masque">LA PREUVE</div>
          <div id="b2-titre" class="titre md masque">Cette vidéo a été montée<br />par <span class="b">Claude Code</span></div>
          <div id="b2-chip" class="chip a masque">🙅 0 intervention humaine</div>
        </div>

        <!-- B3 · tout ce qu'il fait 8.8 → 13.9 -->
        <div class="centre">
          <div id="b3-titre" class="titre sm masque">Il a tout fait, tout seul</div>
          <div class="rangee">
            <div id="b3-c1" class="chip plein-b masque">💬 les sous-titres</div>
            <div id="b3-c2" class="chip plein-b masque">🔊 les effets sonores</div>
          </div>
          <div class="rangee">
            <div id="b3-c3" class="chip plein-b masque">✨ les transitions</div>
            <div id="b3-c4" class="chip a masque">bref, LA TOTALE</div>
          </div>
        </div>

        <!-- B4 · l'outil 13.95 → 17.25 -->
        <div class="centre">
          <div id="b4-kick" class="kicker masque">GRÂCE À UN SEUL OUTIL</div>
          <div id="b4-titre" class="titre masque">HyperFrames</div>
        </div>

        <!-- B5 · installation 17.3 → 19.1 -->
        <div class="centre">
          <div id="b5-titre" class="titre md masque">Tu l'installes dans<br />ton <span class="b">Claude Code</span></div>
        </div>

        <!-- B6 · comment ça marche 19.2 → 23.0 -->
        <div class="centre">
          <div id="b6-kick" class="kicker b masque">COMMENT ÇA MARCHE</div>
          <div id="b6-flux" class="rangee masque">
            <div class="chip">🎥 ta vidéo</div>
            <svg width="80" height="36" viewBox="0 0 45 20" fill="none"><path d="M2 10 h34 m-7 -7 l7 7 -7 7" stroke="#4aa8ff" stroke-width="3.4" stroke-linecap="round" stroke-linejoin="round"/></svg>
            <div class="chip plein-b">🎬 montage</div>
          </div>
          <div id="b6-auto" class="chip a masque">100% autonome</div>
        </div>

        <!-- B7 · si tu veux 23.1 → 24.3 -->
        <div class="centre">
          <div id="b7-titre" class="titre md masque">Tu veux l'installer ?</div>
        </div>

        <!-- B8 · le guide 24.4 → 28.25 -->
        <div class="centre">
          <div id="b8-kick" class="kicker a masque">J'AI CRÉÉ POUR TOI</div>
          <div id="b8-titre" class="titre masque">Le guide complet</div>
          <div class="rangee">
            <div id="b8-e1" class="chip plein-b masque">1</div>
            <div id="b8-e2" class="chip plein-b masque">2</div>
            <div id="b8-e3" class="chip plein-b masque">3</div>
            <div id="b8-etape" class="chip masque">étape par étape</div>
          </div>
        </div>

        <!-- B9 · commente 28.3 → 31.4 -->
        <div class="centre">
          <div id="b9-titre" class="titre masque">Commente <span class="a">ce que tu veux</span></div>
          <div id="b9-sous" class="chip masque">💬 en dessous de cette vidéo</div>
          <svg id="b9-fleche" class="masque" width="64" height="64" viewBox="0 0 48 48" fill="none">
            <path d="M24 8 v30 m-11 -11 l11 11 11 -11" stroke="#fcbb00" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </div>

        <!-- B10 · la ressource 31.5 → 34.05 -->
        <div class="centre">
          <div id="b10-kick" class="kicker b masque">ET JE T'ENVOIE</div>
          <div id="b10-titre" class="titre md masque">La ressource</div>
          <div id="b10-chip" class="chip a masque">🔓 gratuitement</div>
        </div>

        <!-- B11 · surtout 34.1 → 35.4 -->
        <div class="centre">
          <div id="b11-titre" class="titre md masque">Et surtout…</div>
        </div>

        <!-- B12 · abonne-toi 35.5 → 39.3 -->
        <div class="centre">
          <div id="b12-titre" class="titre masque"><span class="a">ABONNE-TOI</span></div>
          <svg id="b12-cloche" class="masque" width="84" height="84" viewBox="0 0 48 48" fill="none">
            <path d="M24 6 a12 12 0 0 1 12 12 v8 l5 8 H7 l5 -8 v-8 A12 12 0 0 1 24 6 Z" stroke="#fcbb00" stroke-width="5" stroke-linejoin="round" />
            <path d="M19 40 a5 5 0 0 0 10 0" stroke="#fcbb00" stroke-width="5" />
          </svg>
          <div id="b12-sous" class="chip masque">d'autres vidéos comme celle-ci</div>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="39.4" data-track-index="3">
{{CAPTIONS_HTML}}
      </div>

      <!-- ===== EFFETS SONORES (voix absente : elle reste sur votre vidéo) ===== -->
      <audio id="t01" src="assets/sfx/whoosh-short.mp3" data-start="0.02" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t02" src="assets/sfx/whoosh-short.mp3" data-start="3.48" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t03" src="assets/sfx/whoosh-short.mp3" data-start="8.72" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t04" src="assets/sfx/whoosh-short.mp3" data-start="13.88" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t05" src="assets/sfx/whoosh-short.mp3" data-start="17.26" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t06" src="assets/sfx/whoosh-short.mp3" data-start="19.14" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t07" src="assets/sfx/whoosh-short.mp3" data-start="23.04" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t08" src="assets/sfx/whoosh-short.mp3" data-start="24.34" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t09" src="assets/sfx/whoosh-short.mp3" data-start="28.26" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t10" src="assets/sfx/whoosh-short.mp3" data-start="31.40" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t11" src="assets/sfx/whoosh-short.mp3" data-start="34.06" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t12" src="assets/sfx/whoosh-short.mp3" data-start="35.44" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>

      <audio id="i1" src="assets/sfx/impact-bass-1.mp3" data-start="1.33" data-duration="2.11" data-track-index="12" data-volume="0.5"></audio>
      <audio id="i2" src="assets/sfx/impact-bass-1.mp3" data-start="16.30" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i3" src="assets/sfx/impact-bass-1.mp3" data-start="29.00" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i4" src="assets/sfx/impact-bass-1.mp3" data-start="35.46" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>

      <audio id="n1" src="assets/sfx/notification.mp3" data-start="31.62" data-duration="2.00" data-track-index="13" data-volume="0.28"></audio>

      <audio id="p1" src="assets/sfx/pop.mp3" data-start="2.22" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p2" src="assets/sfx/pop.mp3" data-start="6.88" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p3" src="assets/sfx/pop.mp3" data-start="9.76" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p4" src="assets/sfx/pop.mp3" data-start="10.76" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p5" src="assets/sfx/pop.mp3" data-start="11.89" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p6" src="assets/sfx/pop.mp3" data-start="13.08" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p7" src="assets/sfx/pop.mp3" data-start="17.38" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p8" src="assets/sfx/pop.mp3" data-start="19.99" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p9" src="assets/sfx/pop.mp3" data-start="22.09" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p10" src="assets/sfx/pop.mp3" data-start="24.99" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p11" src="assets/sfx/pop.mp3" data-start="29.94" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p12" src="assets/sfx/pop.mp3" data-start="32.73" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>

      <audio id="c1" src="assets/sfx/click-soft.mp3" data-start="26.36" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="c2" src="assets/sfx/click-soft.mp3" data-start="26.78" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="c3" src="assets/sfx/click-soft.mp3" data-start="27.20" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>

      <audio id="r1" src="assets/sfx/riser.mp3" data-start="27.70" data-duration="1.30" data-media-start="7.9" data-track-index="16" data-volume="0.28"></audio>
      <audio id="s1" src="assets/sfx/sparkle.mp3" data-start="33.22" data-duration="1.80" data-track-index="17" data-volume="0.38"></audio>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });

      /* Apparitions 100% opaques (aucun fondu d'alpha) : indispensable
         pour un calque transparent. */
      function popIn(sel, t, d = 0.32) {
        tl.set(sel, { autoAlpha: 1 }, t);
        tl.fromTo(sel, { scale: 0 }, { scale: 1, duration: d, ease: "back.out(2)" }, t);
      }
      function slideIn(sel, t, d = 0.3, dx = 90) {
        tl.set(sel, { autoAlpha: 1 }, t);
        tl.fromTo(sel, { x: dx, scale: 0.9 }, { x: 0, scale: 1, duration: d, ease: "power3.out" }, t);
      }
      function popOut(sel, t, d = 0.18) {
        tl.to(sel, { scale: 0, duration: d, ease: "power2.in" }, t);
        tl.set(sel, { autoAlpha: 0 }, t + d);
      }
      function sortie(liste, t) { liste.forEach((s, i) => popOut(s, t + i * 0.03)); }

      /* B1 · hook */
      popIn("#b1-kick", 0.05, 0.28);
      popIn("#b1-titre", 1.30, 0.42);
      tl.to("#b1-titre", { scale: 1.05, duration: 0.22, yoyo: true, repeat: 1, ease: "power2.inOut" }, 1.72);
      popIn("#b1-chip", 2.22, 0.3);
      sortie(["#b1-kick", "#b1-titre", "#b1-chip"], 3.30);

      /* B2 · la preuve */
      popIn("#b2-kick", 3.52, 0.28);
      slideIn("#b2-titre", 3.95, 0.34);
      popIn("#b2-chip", 6.88, 0.3);
      sortie(["#b2-kick", "#b2-titre", "#b2-chip"], 8.50);

      /* B3 · la liste */
      slideIn("#b3-titre", 8.80, 0.32);
      popIn("#b3-c1", 9.76, 0.28);
      popIn("#b3-c2", 10.76, 0.28);
      popIn("#b3-c3", 11.89, 0.28);
      popIn("#b3-c4", 13.08, 0.30);
      tl.to("#b3-c4", { scale: 1.08, duration: 0.3, yoyo: true, repeat: 1, ease: "sine.inOut" }, 13.42);
      sortie(["#b3-titre", "#b3-c1", "#b3-c2", "#b3-c3", "#b3-c4"], 13.70);

      /* B4 · HyperFrames */
      popIn("#b4-kick", 13.92, 0.28);
      popIn("#b4-titre", 16.30, 0.45);
      tl.to("#b4-titre", { scale: 1.06, duration: 0.45, yoyo: true, repeat: 1, ease: "sine.inOut" }, 16.80);
      sortie(["#b4-kick", "#b4-titre"], 17.08);

      /* B5 · installation */
      popIn("#b5-titre", 17.34, 0.36);
      sortie(["#b5-titre"], 18.94);

      /* B6 · comment ça marche */
      popIn("#b6-kick", 19.18, 0.28);
      slideIn("#b6-flux", 19.95, 0.32, 70);
      popIn("#b6-auto", 22.09, 0.32);
      tl.to("#b6-auto", { scale: 1.07, duration: 0.4, yoyo: true, repeat: 1, ease: "sine.inOut" }, 22.45);
      sortie(["#b6-kick", "#b6-flux", "#b6-auto"], 22.84);

      /* B7 · tu veux l installer */
      popIn("#b7-titre", 23.10, 0.34);
      sortie(["#b7-titre"], 24.14);

      /* B8 · le guide */
      popIn("#b8-kick", 24.38, 0.28);
      popIn("#b8-titre", 24.97, 0.40);
      popIn("#b8-e1", 26.34, 0.26);
      popIn("#b8-e2", 26.76, 0.26);
      popIn("#b8-e3", 27.18, 0.26);
      popIn("#b8-etape", 27.60, 0.28);
      sortie(["#b8-kick", "#b8-titre", "#b8-e1", "#b8-e2", "#b8-e3", "#b8-etape"], 28.06);

      /* B9 · commente */
      popIn("#b9-titre", 29.00, 0.40);
      popIn("#b9-sous", 29.55, 0.30);
      popIn("#b9-fleche", 29.94, 0.28);
      tl.to("#b9-fleche", { y: 14, duration: 0.4, yoyo: true, repeat: 1, ease: "sine.inOut" }, 30.25);
      tl.set("#b9-fleche", { y: 0 }, 31.30);
      sortie(["#b9-titre", "#b9-sous", "#b9-fleche"], 31.20);

      /* B10 · la ressource */
      popIn("#b10-kick", 31.44, 0.28);
      slideIn("#b10-titre", 32.05, 0.32);
      popIn("#b10-chip", 33.20, 0.30);
      sortie(["#b10-kick", "#b10-titre", "#b10-chip"], 33.88);

      /* B11 · et surtout */
      popIn("#b11-titre", 34.10, 0.32);
      sortie(["#b11-titre"], 35.20);

      /* B12 · abonne-toi */
      popIn("#b12-titre", 35.44, 0.42);
      popIn("#b12-cloche", 35.90, 0.30);
      tl.to("#b12-cloche", { rotate: 14, duration: 0.1, yoyo: true, repeat: 7, transformOrigin: "50% 14%", ease: "sine.inOut" }, 36.30);
      tl.set("#b12-cloche", { rotate: 0 }, 37.20);
      popIn("#b12-sous", 36.90, 0.30);
      tl.to("#b12-titre", { scale: 1.06, duration: 0.5, yoyo: true, repeat: 2, ease: "sine.inOut" }, 37.40);
      sortie(["#b12-titre", "#b12-cloche", "#b12-sous"], 39.00);

      /* ---------- sous-titres ---------- */
      {{CAPTIONS_TWEENS}}

      window.__timelines["selfie-overlay"] = tl;
    </script>
  </body>
</html>
