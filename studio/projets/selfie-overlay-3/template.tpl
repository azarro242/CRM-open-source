<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Bandeau 50/50 — GPT Ads</title>
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
        --vert-ok: #35d07f;
        --ardoise: #1b1b20;
        --ardoise-2: #2a2a33;
        --gris: #9a9aa6;
      }
      body { margin: 0; background: {{FOND}}; font-family: "Inter", sans-serif; }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; }
      #fond { position: absolute; inset: 0; background: {{FOND}}; }

      /* ===== BANDEAU : moitié haute exactement (split à 960 px) =====
         noir plein jusqu'à 880, dégradé droit jusqu'à 1060 → le fondu est
         centré sur la mi-hauteur, la moitié basse reste libre pour la vidéo. */
      #bandeau { position: absolute; top: 0; left: 0; width: 1080px; {{BANDEAU}} }

      .masque { opacity: 0; visibility: hidden; }

      /* ===== SCÈNE : descendue sous l'interface Instagram (170 → 690) ===== */
      .scene { position: absolute; top: 170px; left: 0; width: 1080px; height: 520px; }
      .centre { position: absolute; inset: 0; display: flex; flex-direction: column;
        align-items: center; justify-content: center; gap: 20px; }
      .rangee { display: flex; gap: 16px; justify-content: center; align-items: center; }

      .kicker { font-weight: 900; font-size: 32px; letter-spacing: 7px; color: var(--gris); }
      .kicker.b { color: var(--bleu-clair); }
      .kicker.r { color: var(--rouge-pale); }
      .kicker.a { color: var(--ambre); }

      .titre { font-weight: 900; font-size: 76px; line-height: 1.03; letter-spacing: -2px;
        color: #fff; text-align: center; }
      .titre.md { font-size: 62px; }
      .titre.sm { font-size: 50px; }
      .titre .b { color: var(--bleu-clair); }
      .titre .a { color: var(--ambre-clair); }
      .titre .r { color: var(--rouge-pale); }

      .chip { font-weight: 900; font-size: 36px; padding: 15px 32px; border-radius: 999px;
        display: inline-flex; align-items: center; gap: 12px;
        background: var(--ardoise); border: 4px solid var(--ardoise-2); color: #fff; }
      .chip.b { border-color: var(--bleu); color: var(--bleu-clair); }
      .chip.r { border-color: var(--rouge); color: var(--rouge-pale); }
      .chip.a { background: var(--ambre); border-color: var(--ambre-clair); color: #111; }
      .chip.plein-b { background: var(--bleu); border-color: var(--bleu-clair); color: #fff; }

      /* chiffre-choc */
      .stat { font-weight: 900; font-size: 122px; letter-spacing: -4px; color: var(--bleu-clair);
        line-height: 1; }
      .stat.a { color: var(--ambre-clair); }

      /* 1 personne sur 10 */
      #b7-pers { display: flex; gap: 12px; }
      #b7-pers .p { width: 58px; height: 58px; border-radius: 50%;
        background: var(--ardoise-2); border: 3px solid #3a3a45; }
      #b7-pers .p.on { background: var(--bleu); border-color: var(--bleu-clair); }

      /* barres de trafic */
      #b8-barres { display: flex; gap: 18px; align-items: flex-end; height: 190px; }
      #b8-barres .bar { width: 74px; border-radius: 14px 14px 6px 6px;
        background: linear-gradient(180deg, #4aa8ff, #007aff); transform-origin: bottom center; }

      /* ===== SOUS-TITRES : dans le bas du bandeau noir (jamais sur le visage) ===== */
      #captions { position: absolute; top: 0; left: 0; width: 1080px; height: 1920px; }
      .cap { position: absolute; left: 46px; right: 46px; top: 716px; text-align: center;
        opacity: 0; visibility: hidden; }
      .cap .pill { display: inline-block; background: #000; color: #fff;
        font-weight: 900; font-size: 48px; line-height: 1.22; padding: 14px 30px;
        border-radius: 20px; }
      .cap .kb { color: var(--bleu-clair); }
      .cap .ka { color: var(--ambre-clair); }
      .cap .kr { color: var(--rouge-pale); }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="gpt-ads" data-start="0" data-width="1080" data-height="1920" data-duration="56.1">

      <div id="fond" class="clip" data-start="0" data-duration="56.1" data-track-index="0"></div>

      <div id="bande-wrap" class="clip" data-start="0" data-duration="56.1" data-track-index="1">
        <div id="bandeau"></div>
      </div>

      <div id="scenes" class="clip scene" data-start="0" data-duration="56.1" data-track-index="2">

        <!-- B1 · hook 0.15 → 2.6 -->
        <div class="centre">
          <div id="b1-kick" class="kicker a masque">TU NE LE SAIS PEUT-ÊTRE PAS…</div>
          <div id="b1-titre" class="titre md masque">Mais cette semaine,<br />tout vient de changer</div>
        </div>

        <!-- B2 · l'annonce 2.72 → 6.0 -->
        <div class="centre">
          <div id="b2-kick" class="kicker b masque">CETTE SEMAINE</div>
          <div id="b2-titre" class="titre masque"><span class="b">ChatGPT</span> lance</div>
          <div id="b2-chip" class="chip plein-b masque">📢 sa plateforme publicitaire</div>
        </div>

        <!-- B3 · GPT Ads 6.12 → 8.4 -->
        <div class="centre">
          <div id="b3-kick" class="kicker masque">J'AI NOMMÉ</div>
          <div id="b3-titre" class="titre masque">GPT Ads</div>
        </div>

        <!-- B4 · concrètement 8.56 → 10.6 -->
        <div class="centre">
          <div id="b4-titre" class="titre md masque">Concrètement,<br />qu'est-ce que <span class="a">ça change</span> ?</div>
        </div>

        <!-- B5 · 2 milliards 10.74 → 15.3 -->
        <div class="centre">
          <div id="b5-kick" class="kicker b masque">AUJOURD'HUI · CHATGPT</div>
          <div id="b5-stat" class="stat masque">2 milliards</div>
          <div id="b5-chip" class="chip b masque">de prompts par jour</div>
        </div>

        <!-- B6 · 700 millions 15.42 → 18.3 -->
        <div class="centre">
          <div id="b6-stat" class="stat masque">700 millions</div>
          <div id="b6-chip" class="chip b masque">d'utilisateurs par semaine</div>
        </div>

        <!-- B7 · 1 sur 10 18.44 → 21.1 -->
        <div class="centre">
          <div id="b7-titre" class="titre md masque"><span class="b">1 personne sur 10</span></div>
          <div id="b7-pers" class="masque">
            <div class="p on"></div><div class="p"></div><div class="p"></div><div class="p"></div><div class="p"></div>
            <div class="p"></div><div class="p"></div><div class="p"></div><div class="p"></div><div class="p"></div>
          </div>
          <div id="b7-chip" class="chip masque">utilise ChatGPT</div>
        </div>

        <!-- B8 · le volume 21.2 → 26.4 -->
        <div class="centre">
          <div id="b8-kick" class="kicker masque">IMAGINE LE VOLUME</div>
          <div id="b8-barres" class="masque">
            <div class="bar" style="height:70px"></div>
            <div class="bar" style="height:110px"></div>
            <div class="bar" style="height:150px"></div>
            <div class="bar" style="height:190px"></div>
          </div>
          <div id="b8-chip" class="chip a masque">📈 un trafic énorme</div>
        </div>

        <!-- B9 · game changer 26.52 → 30.6 -->
        <div class="centre">
          <div id="b9-kick" class="kicker a masque">MON AVIS</div>
          <div id="b9-titre" class="titre masque">Un <span class="a">game changer</span></div>
          <div id="b9-chip" class="chip masque">🏢 pour les entreprises</div>
        </div>

        <!-- B10 · publicité 30.7 → 33.7 -->
        <div class="centre">
          <div id="b10-titre" class="titre md masque">Pour tous ceux qui font<br />de la <span class="b">publicité</span> en ligne</div>
        </div>

        <!-- B11 · concurrence 33.85 → 39.5 -->
        <div class="centre">
          <div id="b11-kick" class="kicker b masque">CE QUE ÇA APPORTE</div>
          <div class="rangee">
            <div id="b11-c1" class="chip plein-b masque">✨ de la nouveauté</div>
            <div id="b11-c2" class="chip a masque">⚔ de la concurrence</div>
          </div>
          <div class="rangee">
            <div id="b11-meta" class="chip masque">Meta Ads</div>
            <div id="b11-google" class="chip masque">Google Ads</div>
          </div>
        </div>

        <!-- B12 · le guide 39.62 → 46.1 -->
        <div class="centre">
          <div id="b12-kick" class="kicker a masque">J'AI CRÉÉ POUR TOI</div>
          <div id="b12-titre" class="titre md masque">Le guide <span class="a">100% gratuit</span></div>
          <div id="b12-chip" class="chip plein-b masque">🚀 prendre en main GPT Ads</div>
        </div>

        <!-- B13 · commente 46.24 → 48.0 -->
        <div class="centre">
          <div id="b13-titre" class="titre masque">Commente <span class="a">« IA »</span></div>
          <div id="b13-sous" class="chip masque">💬 en dessous de cette vidéo</div>
        </div>

        <!-- B14 · la ressource 48.12 → 51.0 -->
        <div class="centre">
          <div id="b14-kick" class="kicker b masque">ET JE T'ENVOIE</div>
          <div id="b14-titre" class="titre md masque">L'accès à la ressource</div>
          <div id="b14-chip" class="chip a masque">🔓 gratuitement</div>
        </div>

        <!-- B15 · abonne-toi 51.12 → 56.0 -->
        <div class="centre">
          <div id="b15-titre" class="titre masque"><span class="a">ABONNE-TOI</span></div>
          <svg id="b15-cloche" class="masque" width="88" height="88" viewBox="0 0 48 48" fill="none">
            <path d="M24 6 a12 12 0 0 1 12 12 v8 l5 8 H7 l5 -8 v-8 A12 12 0 0 1 24 6 Z" stroke="#fcbb00" stroke-width="5" stroke-linejoin="round" />
            <path d="M19 40 a5 5 0 0 0 10 0" stroke="#fcbb00" stroke-width="5" />
          </svg>
          <div id="b15-sous" class="chip masque">d'autres vidéos comme celle-ci</div>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="56.1" data-track-index="3">
{{CAPTIONS_HTML}}
      </div>

      <!-- ===== EFFETS SONORES (sans la voix) ===== -->
      <audio id="t01" src="assets/sfx/whoosh-short.mp3" data-start="0.10" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t02" src="assets/sfx/whoosh-short.mp3" data-start="2.70" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t03" src="assets/sfx/whoosh-short.mp3" data-start="6.10" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t04" src="assets/sfx/whoosh-short.mp3" data-start="8.54" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t05" src="assets/sfx/whoosh-short.mp3" data-start="10.72" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t06" src="assets/sfx/whoosh-short.mp3" data-start="15.40" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t07" src="assets/sfx/whoosh-short.mp3" data-start="18.42" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t08" src="assets/sfx/whoosh-short.mp3" data-start="21.18" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t09" src="assets/sfx/whoosh-short.mp3" data-start="26.50" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t10" src="assets/sfx/whoosh-short.mp3" data-start="30.68" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t11" src="assets/sfx/whoosh-short.mp3" data-start="33.83" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t12" src="assets/sfx/whoosh-short.mp3" data-start="39.60" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t13" src="assets/sfx/whoosh-short.mp3" data-start="46.22" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t14" src="assets/sfx/whoosh-short.mp3" data-start="48.10" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t15" src="assets/sfx/whoosh-short.mp3" data-start="51.10" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>

      <audio id="i1" src="assets/sfx/impact-bass-1.mp3" data-start="7.28" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i2" src="assets/sfx/impact-bass-1.mp3" data-start="13.13" data-duration="2.11" data-track-index="12" data-volume="0.5"></audio>
      <audio id="i3" src="assets/sfx/impact-bass-1.mp3" data-start="28.39" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i4" src="assets/sfx/impact-bass-1.mp3" data-start="46.27" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i5" src="assets/sfx/impact-bass-1.mp3" data-start="51.68" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>

      <audio id="n1" src="assets/sfx/notification.mp3" data-start="48.39" data-duration="2.00" data-track-index="13" data-volume="0.28"></audio>

      <audio id="p01" src="assets/sfx/pop.mp3" data-start="0.88" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p02" src="assets/sfx/pop.mp3" data-start="3.17" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p03" src="assets/sfx/pop.mp3" data-start="4.42" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p04" src="assets/sfx/pop.mp3" data-start="9.22" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p05" src="assets/sfx/pop.mp3" data-start="12.92" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p06" src="assets/sfx/pop.mp3" data-start="15.44" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p07" src="assets/sfx/pop.mp3" data-start="16.55" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p08" src="assets/sfx/pop.mp3" data-start="18.86" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p09" src="assets/sfx/pop.mp3" data-start="22.91" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p10" src="assets/sfx/pop.mp3" data-start="24.24" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p11" src="assets/sfx/pop.mp3" data-start="29.78" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p12" src="assets/sfx/pop.mp3" data-start="32.24" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p13" src="assets/sfx/pop.mp3" data-start="34.88" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p14" src="assets/sfx/pop.mp3" data-start="36.31" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p15" src="assets/sfx/pop.mp3" data-start="38.53" data-duration="0.33" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p16" src="assets/sfx/pop.mp3" data-start="38.88" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p17" src="assets/sfx/pop.mp3" data-start="41.17" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p18" src="assets/sfx/pop.mp3" data-start="43.35" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p19" src="assets/sfx/pop.mp3" data-start="46.83" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p20" src="assets/sfx/pop.mp3" data-start="49.58" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>

      <audio id="c1" src="assets/sfx/click-soft.mp3" data-start="19.41" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="c2" src="assets/sfx/click-soft.mp3" data-start="19.90" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>

      <audio id="r1" src="assets/sfx/riser.mp3" data-start="44.95" data-duration="1.30" data-media-start="7.9" data-track-index="16" data-volume="0.28"></audio>
      <audio id="s1" src="assets/sfx/sparkle.mp3" data-start="41.92" data-duration="1.80" data-track-index="17" data-volume="0.38"></audio>
      <audio id="s2" src="assets/sfx/sparkle.mp3" data-start="50.03" data-duration="1.80" data-track-index="17" data-volume="0.34"></audio>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });

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

      /* B1 */
      popIn("#b1-kick", 0.12, 0.3);
      slideIn("#b1-titre", 0.88, 0.34);
      sortie(["#b1-kick", "#b1-titre"], 2.50);

      /* B2 */
      popIn("#b2-kick", 2.72, 0.28);
      popIn("#b2-titre", 3.17, 0.4);
      popIn("#b2-chip", 4.42, 0.32);
      sortie(["#b2-kick", "#b2-titre", "#b2-chip"], 5.86);

      /* B3 · GPT Ads */
      popIn("#b3-kick", 6.12, 0.28);
      popIn("#b3-titre", 7.28, 0.45);
      tl.to("#b3-titre", { scale: 1.07, duration: 0.45, yoyo: true, repeat: 1, ease: "sine.inOut" }, 7.75);
      sortie(["#b3-kick", "#b3-titre"], 8.30);

      /* B4 */
      popIn("#b4-titre", 8.56, 0.36);
      tl.to("#b4-titre", { scale: 1.04, duration: 0.25, yoyo: true, repeat: 1, ease: "power2.inOut" }, 9.22);
      sortie(["#b4-titre"], 10.44);

      /* B5 · 2 milliards */
      popIn("#b5-kick", 10.74, 0.28);
      popIn("#b5-stat", 12.92, 0.42);
      tl.to("#b5-stat", { scale: 1.06, duration: 0.35, yoyo: true, repeat: 1, ease: "sine.inOut" }, 13.36);
      popIn("#b5-chip", 13.90, 0.3);
      sortie(["#b5-kick", "#b5-stat", "#b5-chip"], 15.16);

      /* B6 · 700 millions */
      popIn("#b6-stat", 15.44, 0.42);
      popIn("#b6-chip", 16.55, 0.3);
      sortie(["#b6-stat", "#b6-chip"], 18.16);

      /* B7 · 1 sur 10 */
      popIn("#b7-titre", 18.44, 0.36);
      tl.set("#b7-pers", { autoAlpha: 1 }, 18.86);
      tl.fromTo("#b7-pers .p", { scale: 0 }, { scale: 1, duration: 0.24, ease: "back.out(2.2)", stagger: 0.07 }, 18.86);
      tl.to("#b7-pers .p.on", { scale: 1.25, duration: 0.28, yoyo: true, repeat: 1, ease: "sine.inOut" }, 19.86);
      popIn("#b7-chip", 19.94, 0.3);
      sortie(["#b7-titre", "#b7-pers", "#b7-chip"], 20.92);
      tl.set("#b7-pers .p", { scale: 1 }, 21.16);

      /* B8 · volume */
      popIn("#b8-kick", 21.20, 0.28);
      tl.set("#b8-barres", { autoAlpha: 1 }, 22.00);
      tl.fromTo("#b8-barres .bar", { scaleY: 0 }, { scaleY: 1, duration: 0.4, ease: "power3.out", stagger: 0.22 }, 22.00);
      popIn("#b8-chip", 24.22, 0.32);
      sortie(["#b8-kick", "#b8-barres", "#b8-chip"], 26.24);
      tl.set("#b8-barres .bar", { scaleY: 1 }, 26.46);

      /* B9 · game changer */
      popIn("#b9-kick", 26.52, 0.28);
      popIn("#b9-titre", 28.39, 0.42);
      tl.to("#b9-titre", { scale: 1.06, duration: 0.4, yoyo: true, repeat: 1, ease: "sine.inOut" }, 28.85);
      popIn("#b9-chip", 29.78, 0.3);
      sortie(["#b9-kick", "#b9-titre", "#b9-chip"], 30.42);

      /* B10 */
      slideIn("#b10-titre", 30.70, 0.34);
      sortie(["#b10-titre"], 33.55);

      /* B11 · concurrence */
      popIn("#b11-kick", 33.85, 0.28);
      popIn("#b11-c1", 34.88, 0.3);
      popIn("#b11-c2", 36.31, 0.3);
      popIn("#b11-meta", 38.50, 0.28);
      popIn("#b11-google", 38.90, 0.28);
      sortie(["#b11-kick", "#b11-c1", "#b11-c2", "#b11-meta", "#b11-google"], 39.42);

      /* B12 · le guide */
      popIn("#b12-kick", 39.62, 0.28);
      popIn("#b12-titre", 41.17, 0.4);
      tl.to("#b12-titre", { scale: 1.05, duration: 0.35, yoyo: true, repeat: 1, ease: "sine.inOut" }, 41.90);
      popIn("#b12-chip", 43.35, 0.32);
      sortie(["#b12-kick", "#b12-titre", "#b12-chip"], 45.94);

      /* B13 · commente */
      popIn("#b13-titre", 46.27, 0.4);
      popIn("#b13-sous", 46.83, 0.3);
      sortie(["#b13-titre", "#b13-sous"], 47.86);

      /* B14 · la ressource */
      popIn("#b14-kick", 48.12, 0.28);
      slideIn("#b14-titre", 48.72, 0.32);
      popIn("#b14-chip", 49.58, 0.3);
      sortie(["#b14-kick", "#b14-titre", "#b14-chip"], 50.86);

      /* B15 · abonne-toi */
      popIn("#b15-titre", 51.66, 0.42);
      popIn("#b15-cloche", 52.10, 0.3);
      tl.to("#b15-cloche", { rotate: 14, duration: 0.1, yoyo: true, repeat: 7, transformOrigin: "50% 14%", ease: "sine.inOut" }, 52.50);
      tl.set("#b15-cloche", { rotate: 0 }, 53.40);
      popIn("#b15-sous", 53.10, 0.3);
      tl.to("#b15-titre", { scale: 1.06, duration: 0.5, yoyo: true, repeat: 2, ease: "sine.inOut" }, 53.60);
      sortie(["#b15-titre", "#b15-cloche", "#b15-sous"], 55.70);

      /* ---------- sous-titres ---------- */
      {{CAPTIONS_TWEENS}}

      window.__timelines["gpt-ads"] = tl;
    </script>
  </body>
</html>
