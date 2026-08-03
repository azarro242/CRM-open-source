<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Bandeau motion design 9:16 — L'IA pour les personnes fauchées</title>
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
    <div id="root" data-composition-id="selfie-overlay" data-start="0" data-width="1080" data-height="1920" data-duration="54.3">

      <div id="fond" class="clip" data-start="0" data-duration="54.3" data-track-index="0"></div>

      <!-- ===== bandeau noir dégradé ===== -->
      <div id="bande-wrap" class="clip" data-start="0" data-duration="54.3" data-track-index="1">
        <div id="bandeau"></div>
      </div>

      <!-- ===== ANIMATIONS ===== -->
      <div id="scenes" class="clip scene" data-start="0" data-duration="54.3" data-track-index="2">

        <!-- B1 · titre 0.3 → 4.3 -->
        <div class="centre">
          <div id="b1-kick" class="kicker a masque">PARTIE 1</div>
          <div id="b1-titre" class="titre masque">L'IA pour les<br />personnes <span class="a">fauchées</span></div>
          <div id="b1-poche" class="chip masque">👛 budget : 0 €</div>
        </div>

        <!-- B2 · Claude gratuit 4.5 → 8.1 -->
        <div class="centre">
          <div id="b2-kick" class="kicker b masque">CE QUE TU VAS OBTENIR</div>
          <div id="b2-titre" class="titre masque"><span class="b">Claude</span> gratuitement</div>
          <div class="rangee">
            <div id="b2-zero" class="chip a masque">0 € / mois</div>
            <div id="b2-abo" class="chip plein-r barre-nulle masque">ABONNEMENT<div class="trait"></div></div>
          </div>
        </div>

        <!-- B3 · le problème 8.3 → 12.4 -->
        <div class="centre">
          <div id="b3-kick" class="kicker r masque">⚠ ATTENTION</div>
          <div id="b3-titre" class="titre md masque">La plupart des astuces<br />sur internet sont <span class="r">des pièges</span></div>
        </div>

        <!-- B4 · faux Claude 12.5 → 15.4 -->
        <div class="centre">
          <div id="b4-titre" class="titre md masque">Des modèles <span class="r">chinois</span></div>
          <div class="rangee">
            <div id="b4-masque" class="chip plein-r masque">🎭 déguisés en « Claude »</div>
          </div>
          <div id="b4-vrai" class="chip r masque">≠ le vrai Claude</div>
        </div>

        <!-- B5 · données 15.5 → 16.9 -->
        <div class="centre">
          <div id="b5-titre" class="titre masque">Tes <span class="r">données</span> partent</div>
          <div id="b5-flux" class="rangee masque">
            <div class="chip">💻 toi</div>
            <svg width="90" height="40" viewBox="0 0 45 20" fill="none"><path d="M2 10 h34 m-7 -7 l7 7 -7 7" stroke="#ff4d3d" stroke-width="3.4" stroke-linecap="round" stroke-linejoin="round"/></svg>
            <div class="chip plein-r">serveur inconnu</div>
          </div>
        </div>

        <!-- B6 · la solution 17.2 → 20.5 -->
        <div class="centre">
          <div id="b6-kick" class="kicker b masque">LA VRAIE SOLUTION</div>
          <div id="b6-titre" class="titre masque">Gemma 4</div>
          <div id="b6-google" class="chip b masque">un outil de Google</div>
        </div>

        <!-- B7 · plusieurs modèles 20.6 → 23.1 -->
        <div class="centre">
          <div id="b7-kick" class="kicker masque">CE QU'IL CONTIENT</div>
          <div id="b7-titre" class="titre sm masque">Plusieurs modèles de langage</div>
          <div id="b7-minis" class="rangee masque">
            <div class="mini">IA<br />1</div>
            <div class="mini">IA<br />2</div>
            <div class="mini">IA<br />3</div>
            <div class="mini">IA<br />4</div>
          </div>
        </div>

        <!-- B8 · 100% local 23.2 → 25.3 -->
        <div class="centre">
          <div id="b8-titre" class="titre masque"><span class="b">100%</span> en local</div>
          <div id="b8-explique" class="rangee masque">
            <div class="chip b">💻 sur ton ordinateur</div>
            <div class="chip plein-r">☁ sans le cloud</div>
          </div>
        </div>

        <!-- B9 · sécurisé 25.4 → 26.4 -->
        <div class="centre">
          <div id="b9-titre" class="titre masque">🔒 <span class="b">Sécurisé</span></div>
          <div id="b9-sous" class="chip masque">tes données restent chez toi</div>
        </div>

        <!-- B10 · sans limite 26.5 → 28.3 -->
        <div class="centre">
          <div id="b10-titre" class="titre masque"><span class="a">Sans limite</span></div>
          <div id="b10-inf" class="chip a masque">∞ utilisation illimitée</div>
        </div>

        <!-- B11 · le guide 28.5 → 31.4 -->
        <div class="centre">
          <div id="b11-kick" class="kicker a masque">J'AI CRÉÉ POUR TOI</div>
          <div id="b11-titre" class="titre masque">Le guide complet</div>
          <div id="b11-gratuit" class="chip a masque">100% GRATUIT</div>
        </div>

        <!-- B12 · étapes 31.5 → 35.9 -->
        <div class="centre">
          <div id="b12-titre" class="titre sm masque">Installation étape par étape</div>
          <div class="rangee">
            <div id="b12-e1" class="chip plein-b masque">1 · télécharger</div>
            <div id="b12-e2" class="chip plein-b masque">2 · installer</div>
            <div id="b12-e3" class="chip plein-b masque">3 · utiliser</div>
          </div>
          <div id="b12-pc" class="chip masque">💻 sur ton ordinateur</div>
        </div>

        <!-- B13 · commente IA 36.0 → 38.4 -->
        <div class="centre">
          <div id="b13-titre" class="titre masque">Commente <span class="a">« IA »</span></div>
          <div id="b13-sous" class="chip masque">💬 en dessous de cette vidéo</div>
          <svg id="b13-fleche" class="masque" width="64" height="64" viewBox="0 0 48 48" fill="none">
            <path d="M24 8 v30 m-11 -11 l11 11 11 -11" stroke="#fcbb00" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </div>

        <!-- B14 · le lien 38.6 → 41.9 -->
        <div class="centre">
          <div id="b14-kick" class="kicker b masque">ENSUITE</div>
          <div id="b14-titre" class="titre md masque">Je t'envoie le <span class="b">lien</span></div>
          <div id="b14-sous" class="chip b masque">🔗 accès à la communauté</div>
        </div>

        <!-- B15 · communauté 42.0 → 45.5 -->
        <div class="centre">
          <div id="b15-avatars" class="avatars masque">
            <div class="av" style="background:#007aff">A</div>
            <div class="av" style="background:#fcbb00;color:#111">K</div>
            <div class="av" style="background:#ff4d3d">S</div>
            <div class="av" style="background:#0066d6">M</div>
            <div class="av" style="background:#2a2a33">+</div>
          </div>
          <div id="b15-titre" class="titre md masque">Des <span class="b">centaines</span> de membres</div>
          <div id="b15-sous" class="chip masque">une communauté autour de l'IA</div>
        </div>

        <!-- B16 · ressource gratuite 45.6 → 48.2 -->
        <div class="centre">
          <div id="b16-titre" class="titre md masque">Tu récupères la ressource</div>
          <div id="b16-chip" class="chip a masque">🔓 et tu l'utilises gratuitement</div>
        </div>

        <!-- B17 · première fois 48.3 → 49.7 -->
        <div class="centre">
          <div id="b17-titre" class="titre md masque">👋 Première fois ici ?</div>
        </div>

        <!-- B18 · abonne-toi 49.9 → 54.2 -->
        <div class="centre">
          <div id="b18-titre" class="titre masque"><span class="a">ABONNE-TOI</span></div>
          <svg id="b18-cloche" class="masque" width="84" height="84" viewBox="0 0 48 48" fill="none">
            <path d="M24 6 a12 12 0 0 1 12 12 v8 l5 8 H7 l5 -8 v-8 A12 12 0 0 1 24 6 Z" stroke="#fcbb00" stroke-width="5" stroke-linejoin="round" />
            <path d="M19 40 a5 5 0 0 0 10 0" stroke="#fcbb00" stroke-width="5" />
          </svg>
          <div id="b18-sous" class="chip masque">d'autres vidéos comme celle-ci</div>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="54.3" data-track-index="3">
{{CAPTIONS_HTML}}
      </div>

      <!-- ===== EFFETS SONORES (voix absente : elle reste sur votre vidéo) ===== -->
      <audio id="t01" src="assets/sfx/whoosh-short.mp3" data-start="0.20" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t02" src="assets/sfx/whoosh-short.mp3" data-start="4.42" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t03" src="assets/sfx/whoosh-short.mp3" data-start="8.20" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t04" src="assets/sfx/whoosh-short.mp3" data-start="12.42" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t05" src="assets/sfx/whoosh-short.mp3" data-start="15.42" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t06" src="assets/sfx/whoosh-short.mp3" data-start="17.10" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t07" src="assets/sfx/whoosh-short.mp3" data-start="20.52" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t08" src="assets/sfx/whoosh-short.mp3" data-start="23.14" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t09" src="assets/sfx/whoosh-short.mp3" data-start="25.32" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t10" src="assets/sfx/whoosh-short.mp3" data-start="26.40" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t11" src="assets/sfx/whoosh-short.mp3" data-start="28.44" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t12" src="assets/sfx/whoosh-short.mp3" data-start="31.42" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t13" src="assets/sfx/whoosh-short.mp3" data-start="35.94" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t14" src="assets/sfx/whoosh-short.mp3" data-start="38.52" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t15" src="assets/sfx/whoosh-short.mp3" data-start="41.94" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t16" src="assets/sfx/whoosh-short.mp3" data-start="45.54" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t17" src="assets/sfx/whoosh-short.mp3" data-start="48.24" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="t18" src="assets/sfx/whoosh-short.mp3" data-start="49.80" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>

      <audio id="i1" src="assets/sfx/impact-bass-1.mp3" data-start="2.15" data-duration="2.11" data-track-index="12" data-volume="0.5"></audio>
      <audio id="i2" src="assets/sfx/impact-bass-1.mp3" data-start="17.30" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i3" src="assets/sfx/impact-bass-1.mp3" data-start="36.04" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="i4" src="assets/sfx/impact-bass-1.mp3" data-start="49.98" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>

      <audio id="e1" src="assets/sfx/error.mp3" data-start="8.32" data-duration="1.20" data-track-index="13" data-volume="0.32"></audio>
      <audio id="e2" src="assets/sfx/error.mp3" data-start="15.52" data-duration="1.20" data-track-index="13" data-volume="0.32"></audio>
      <audio id="e3" src="assets/sfx/notification.mp3" data-start="38.70" data-duration="2.00" data-track-index="13" data-volume="0.28"></audio>

      <audio id="p1" src="assets/sfx/pop.mp3" data-start="3.78" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p2" src="assets/sfx/pop.mp3" data-start="5.82" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p3" src="assets/sfx/pop.mp3" data-start="6.96" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p4" src="assets/sfx/pop.mp3" data-start="13.00" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p5" src="assets/sfx/pop.mp3" data-start="18.70" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p6" src="assets/sfx/pop.mp3" data-start="21.60" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p7" src="assets/sfx/pop.mp3" data-start="24.10" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p8" src="assets/sfx/pop.mp3" data-start="27.00" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p9" src="assets/sfx/pop.mp3" data-start="30.05" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p10" src="assets/sfx/pop.mp3" data-start="42.04" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p11" src="assets/sfx/pop.mp3" data-start="45.66" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>
      <audio id="p12" src="assets/sfx/pop.mp3" data-start="48.32" data-duration="0.72" data-track-index="14" data-volume="0.45"></audio>

      <audio id="c1" src="assets/sfx/click-soft.mp3" data-start="31.90" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="c2" src="assets/sfx/click-soft.mp3" data-start="32.60" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="c3" src="assets/sfx/click-soft.mp3" data-start="33.30" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="c4" src="assets/sfx/click-soft.mp3" data-start="43.10" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>

      <audio id="r1" src="assets/sfx/riser.mp3" data-start="34.45" data-duration="1.55" data-media-start="7.6" data-track-index="16" data-volume="0.28"></audio>
      <audio id="s1" src="assets/sfx/sparkle.mp3" data-start="29.98" data-duration="1.80" data-track-index="17" data-volume="0.38"></audio>
      <audio id="s2" src="assets/sfx/sparkle.mp3" data-start="46.30" data-duration="1.80" data-track-index="17" data-volume="0.34"></audio>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });

      /* Apparitions 100% opaques (aucun fondu d'alpha) : indispensable
         pour un calque transparent et une incrustation propre. */
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

      /* B1 · titre */
      popIn("#b1-kick", 0.2, 0.3);
      popIn("#b1-titre", 0.5, 0.42);
      tl.to("#b1-titre", { scale: 1.05, duration: 0.22, yoyo: true, repeat: 1, ease: "power2.inOut" }, 2.15);
      popIn("#b1-poche", 3.78, 0.3);
      sortie(["#b1-kick", "#b1-titre", "#b1-poche"], 4.12);

      /* B2 · Claude gratuit */
      popIn("#b2-kick", 4.42, 0.28);
      slideIn("#b2-titre", 4.7, 0.34);
      popIn("#b2-zero", 5.82, 0.3);
      popIn("#b2-abo", 6.96, 0.3);
      tl.fromTo("#b2-abo .trait", { scaleX: 0 }, { scaleX: 1, duration: 0.24, ease: "power2.out" }, 7.3);
      sortie(["#b2-kick", "#b2-titre", "#b2-zero", "#b2-abo"], 7.9);

      /* B3 · le problème */
      popIn("#b3-kick", 8.2, 0.3);
      tl.to("#b3-kick", { rotate: 3, duration: 0.08, yoyo: true, repeat: 5, ease: "sine.inOut" }, 8.6);
      tl.set("#b3-kick", { rotate: 0 }, 9.2);
      slideIn("#b3-titre", 8.55, 0.36);
      sortie(["#b3-kick", "#b3-titre"], 12.2);

      /* B4 · faux Claude */
      popIn("#b4-titre", 12.42, 0.34);
      popIn("#b4-masque", 13.0, 0.32);
      popIn("#b4-vrai", 13.62, 0.3);
      sortie(["#b4-titre", "#b4-masque", "#b4-vrai"], 15.2);

      /* B5 · données */
      popIn("#b5-titre", 15.45, 0.32);
      slideIn("#b5-flux", 15.75, 0.3, 70);
      sortie(["#b5-titre", "#b5-flux"], 16.85);

      /* B6 · la solution */
      popIn("#b6-kick", 17.1, 0.28);
      popIn("#b6-titre", 17.3, 0.45);
      tl.to("#b6-titre", { scale: 1.06, duration: 0.5, yoyo: true, repeat: 3, ease: "sine.inOut" }, 17.85);
      popIn("#b6-google", 18.7, 0.3);
      sortie(["#b6-kick", "#b6-titre", "#b6-google"], 20.3);

      /* B7 · plusieurs modèles */
      popIn("#b7-kick", 20.52, 0.28);
      slideIn("#b7-titre", 20.75, 0.32);
      tl.set("#b7-minis", { autoAlpha: 1 }, 21.55);
      tl.fromTo("#b7-minis .mini", { scale: 0 }, { scale: 1, duration: 0.3, ease: "back.out(2.2)", stagger: 0.13 }, 21.55);
      sortie(["#b7-kick", "#b7-titre", "#b7-minis"], 22.94);
      tl.set("#b7-minis .mini", { scale: 1 }, 23.12);

      /* B8 · 100% local */
      popIn("#b8-titre", 23.14, 0.34);
      slideIn("#b8-explique", 24.08, 0.3, 70);
      sortie(["#b8-titre", "#b8-explique"], 25.12);

      /* B9 · sécurisé */
      popIn("#b9-titre", 25.32, 0.32);
      popIn("#b9-sous", 25.72, 0.28);
      sortie(["#b9-titre", "#b9-sous"], 26.22);

      /* B10 · sans limite */
      popIn("#b10-titre", 26.4, 0.32);
      popIn("#b10-inf", 26.98, 0.3);
      sortie(["#b10-titre", "#b10-inf"], 28.16);

      /* B11 · le guide */
      popIn("#b11-kick", 28.44, 0.28);
      popIn("#b11-titre", 28.7, 0.38);
      popIn("#b11-gratuit", 30.03, 0.32);
      tl.to("#b11-gratuit", { scale: 1.08, duration: 0.4, yoyo: true, repeat: 1, ease: "sine.inOut" }, 30.4);
      sortie(["#b11-kick", "#b11-titre", "#b11-gratuit"], 31.2);

      /* B12 · étapes */
      slideIn("#b12-titre", 31.42, 0.32);
      popIn("#b12-e1", 31.88, 0.28);
      popIn("#b12-e2", 32.58, 0.28);
      popIn("#b12-e3", 33.28, 0.28);
      popIn("#b12-pc", 34.2, 0.3);
      sortie(["#b12-titre", "#b12-e1", "#b12-e2", "#b12-e3", "#b12-pc"], 35.62);

      /* B13 · commente IA */
      popIn("#b13-titre", 36.04, 0.4);
      popIn("#b13-sous", 36.5, 0.3);
      popIn("#b13-fleche", 36.8, 0.28);
      tl.to("#b13-fleche", { y: 14, duration: 0.4, yoyo: true, repeat: 3, ease: "sine.inOut" }, 37.1);
      tl.set("#b13-fleche", { y: 0 }, 38.3);
      sortie(["#b13-titre", "#b13-sous", "#b13-fleche"], 38.24);

      /* B14 · le lien */
      popIn("#b14-kick", 38.52, 0.28);
      slideIn("#b14-titre", 38.74, 0.34);
      popIn("#b14-sous", 39.6, 0.3);
      sortie(["#b14-kick", "#b14-titre", "#b14-sous"], 41.72);

      /* B15 · communauté */
      tl.set("#b15-avatars", { autoAlpha: 1 }, 41.94);
      tl.fromTo("#b15-avatars .av", { scale: 0 }, { scale: 1, duration: 0.32, ease: "back.out(2.4)", stagger: 0.1 }, 41.94);
      popIn("#b15-titre", 42.5, 0.36);
      popIn("#b15-sous", 43.1, 0.3);
      sortie(["#b15-avatars", "#b15-titre", "#b15-sous"], 45.28);
      tl.set("#b15-avatars .av", { scale: 1 }, 45.5);

      /* B16 · ressource */
      slideIn("#b16-titre", 45.54, 0.34);
      popIn("#b16-chip", 46.3, 0.3);
      sortie(["#b16-titre", "#b16-chip"], 48.0);

      /* B17 · première fois */
      popIn("#b17-titre", 48.24, 0.34);
      sortie(["#b17-titre"], 49.5);

      /* B18 · abonne-toi */
      popIn("#b18-titre", 49.96, 0.42);
      popIn("#b18-cloche", 50.4, 0.3);
      tl.to("#b18-cloche", { rotate: 14, duration: 0.1, yoyo: true, repeat: 7, transformOrigin: "50% 14%", ease: "sine.inOut" }, 50.8);
      tl.set("#b18-cloche", { rotate: 0 }, 51.7);
      popIn("#b18-sous", 51.4, 0.3);
      tl.to("#b18-titre", { scale: 1.06, duration: 0.5, yoyo: true, repeat: 2, ease: "sine.inOut" }, 51.9);
      sortie(["#b18-titre", "#b18-cloche", "#b18-sous"], 53.9);

      /* ---------- sous-titres ---------- */
      {{CAPTIONS_TWEENS}}

      window.__timelines["selfie-overlay"] = tl;
    </script>
  </body>
</html>
