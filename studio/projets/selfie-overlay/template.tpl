<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Overlay selfie 9:16 — L'IA pour les fauchés</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      :root {
        --bleu: #007aff;
        --bleu-clair: #339dff;
        --encre: #111113;
        --encre-2: #2e2e32;
        --papier: #ffffff;
        --bord: #e4e4e6;
        --ambre: #fcbb00;
        --ambre-clair: #ffd236;
        --rouge: #e0483e;
        --gris: #828289;
      }
      body { margin: 0; background: {{FOND}}; font-family: "Inter", sans-serif; }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; }
      #fond { position: absolute; inset: 0; background: {{FOND}}; }

      .masque { opacity: 0; visibility: hidden; }

      /* ===== ZONE HAUTE : animations au-dessus de la tête (100 → 600 px) ===== */
      .zone-haute { position: absolute; top: 100px; left: 0; width: 1080px; height: 500px; }
      .centre { position: absolute; inset: 0; display: flex; flex-direction: column;
        align-items: center; justify-content: center; gap: 22px; }

      .carte {
        background: var(--papier); border: 4px solid var(--bord); border-radius: 30px;
        padding: 30px 44px; color: var(--encre); display: flex; align-items: center; gap: 26px;
      }
      .carte .titre { font-weight: 900; font-size: 62px; letter-spacing: -1.5px; line-height: 1.05; }
      .carte .sous { font-weight: 700; font-size: 32px; color: var(--gris); margin-top: 6px; }
      .col { flex-direction: column; gap: 8px; text-align: center; }

      .bleu { background: linear-gradient(180deg, #3ba0ff 0%, #007aff 55%, #0070ea 100%);
        border-color: #0070ea; color: #fff; }
      .bleu .titre, .bleu .sous { color: #fff; }
      .ambre { background: linear-gradient(180deg, var(--ambre-clair), var(--ambre));
        border-color: #e0a800; color: var(--encre); }
      .rouge { background: var(--rouge); border-color: #b8352c; color: #fff; }
      .rouge .titre { color: #fff; }
      .noir { background: var(--encre); border-color: #000; color: #fff; }
      .noir .titre { color: #fff; }
      .noir .sous { color: #b9b9c2; }

      .chip { font-weight: 900; font-size: 38px; padding: 16px 34px; border-radius: 999px;
        background: var(--papier); border: 4px solid var(--bord); color: var(--encre);
        display: inline-flex; align-items: center; gap: 14px; }
      .chip.bleu { border-color: #0070ea; }
      .chip.ambre { border-color: #e0a800; }
      .chip.rouge { border-color: #b8352c; }
      .rangee { display: flex; gap: 20px; justify-content: center; flex-wrap: wrap; }

      /* S1 titre */
      #s1-titre .titre { font-size: 72px; }
      #s1-partie { font-weight: 900; font-size: 42px; letter-spacing: 6px; }

      /* S2 Claude gratuit */
      #s2-prix { position: relative; }
      #s2-barre { position: absolute; left: 12px; right: 12px; top: 50%; height: 8px;
        background: var(--rouge); border-radius: 4px; transform: scaleX(0); transform-origin: left center; }

      /* S4 Gemma */
      #s4-marque .titre { font-size: 96px; letter-spacing: -3px; }
      #s4-google { font-weight: 800; font-size: 34px; letter-spacing: 3px; }

      /* S6 commente */
      #s6-cta .titre { font-size: 88px; }
      #s6-mot { background: var(--ambre); border-radius: 18px; padding: 6px 22px; color: var(--encre); }

      /* S7 communauté */
      #s7-avatars { display: flex; }
      #s7-avatars .av { width: 96px; height: 96px; border-radius: 50%; margin: 0 -12px;
        border: 5px solid var(--papier); display: grid; place-items: center;
        font-weight: 900; font-size: 38px; color: #fff; }

      /* S8 abonne-toi */
      #s8-cta .titre { font-size: 92px; }

      /* ===== SOUS-TITRES : bas de cadre, au-dessus des UI plateformes ===== */
      #captions { position: absolute; top: 0; left: 0; width: 1080px; height: 1920px; }
      .cap { position: absolute; left: 50px; right: 50px; top: 1420px; text-align: center;
        opacity: 0; visibility: hidden; }
      .cap .pill { display: inline-block; background: var(--encre); color: #fff;
        font-weight: 900; font-size: 56px; line-height: 1.26; padding: 20px 38px;
        border-radius: 24px; border: 4px solid #000; }
      .cap .kb { color: var(--bleu-clair); }
      .cap .ka { color: var(--ambre-clair); }
      .cap .kr { color: #ff8a80; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="selfie-overlay" data-start="0" data-width="1080" data-height="1920" data-duration="54.3">

      <div id="fond" class="clip" data-start="0" data-duration="54.3" data-track-index="0"></div>

      <div id="graphiques" class="clip zone-haute" data-start="0" data-duration="54.3" data-track-index="1">

        <!-- S1 · titre 0.35 → 4.35 -->
        <div class="centre">
          <div id="s1-titre" class="carte col noir masque">
            <div class="titre">L'IA pour les<br />personnes fauchées</div>
          </div>
          <div id="s1-partie" class="chip ambre masque">PARTIE 1</div>
        </div>

        <!-- S2 · Claude gratuit 4.6 → 8.05 -->
        <div class="centre" id="s2-wrap">
          <div id="s2-claude" class="carte col masque">
            <div class="titre">Claude</div>
            <div class="sous">accès sans payer</div>
          </div>
          <div class="rangee">
            <div id="s2-gratuit" class="chip ambre masque">100% GRATUIT</div>
            <div id="s2-prix" class="chip masque">ABONNEMENT<div id="s2-barre"></div></div>
          </div>
        </div>

        <!-- S3 · le piège 8.3 → 16.35 -->
        <div class="centre" id="s3-wrap">
          <div id="s3-alerte" class="carte rouge masque">
            <svg width="76" height="76" viewBox="0 0 48 48" fill="none">
              <path d="M24 6 L44 40 H4 Z" stroke="#fff" stroke-width="4" stroke-linejoin="round" />
              <path d="M24 19 v9" stroke="#fff" stroke-width="4" stroke-linecap="round" />
              <circle cx="24" cy="34" r="2.6" fill="#fff" />
            </svg>
            <div class="titre">Attention</div>
          </div>
          <div id="s3-faux" class="chip rouge masque" style="background:var(--rouge);color:#fff">Modèles déguisés en Claude</div>
          <div id="s3-data" class="chip noir masque" style="background:var(--encre);color:#fff;border-color:#000">⚠ tes données</div>
        </div>

        <!-- S4 · la solution 17.2 → 28.3 -->
        <div class="centre" id="s4-wrap">
          <div id="s4-marque" class="carte col bleu masque">
            <div class="titre">Gemma 4</div>
          </div>
          <div id="s4-google" class="chip masque">un outil de Google</div>
          <div class="rangee">
            <div id="s4-c1" class="chip bleu masque" style="background:#fff;color:var(--encre)">💻 100% en local</div>
            <div id="s4-c2" class="chip bleu masque" style="background:#fff;color:var(--encre)">🔒 sécurisé</div>
            <div id="s4-c3" class="chip ambre masque">∞ sans limite</div>
          </div>
        </div>

        <!-- S5 · le guide 28.6 → 35.9 -->
        <div class="centre" id="s5-wrap">
          <div id="s5-guide" class="carte col masque">
            <div class="titre">Le guide</div>
            <div class="sous">installation pas à pas</div>
          </div>
          <div id="s5-gratuit" class="chip ambre masque">COMPLÈTEMENT GRATUIT</div>
          <div id="s5-etapes" class="rangee masque">
            <div class="chip bleu" style="background:#fff;color:var(--encre)">1</div>
            <div class="chip bleu" style="background:#fff;color:var(--encre)">2</div>
            <div class="chip bleu" style="background:#fff;color:var(--encre)">3</div>
            <div class="chip bleu">étape par étape</div>
          </div>
        </div>

        <!-- S6 · commente IA 36.05 → 38.5 -->
        <div class="centre">
          <div id="s6-cta" class="carte col noir masque">
            <div class="titre">Commente <span id="s6-mot">IA</span></div>
            <div class="sous">en dessous de cette vidéo</div>
          </div>
          <svg id="s6-fleche" class="masque" width="80" height="80" viewBox="0 0 48 48" fill="none">
            <path d="M24 8 v30 m-11 -11 l11 11 11 -11" stroke="#fcbb00" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </div>

        <!-- S7 · communauté 38.7 → 48.2 -->
        <div class="centre" id="s7-wrap">
          <div id="s7-lien" class="carte bleu masque">
            <svg width="66" height="66" viewBox="0 0 48 48" fill="none">
              <path d="M20 28 a8 8 0 0 0 11 0 l7 -7 a8 8 0 0 0 -11 -11 l-3 3" stroke="#fff" stroke-width="4" stroke-linecap="round" />
              <path d="M28 20 a8 8 0 0 0 -11 0 l-7 7 a8 8 0 0 0 11 11 l3 -3" stroke="#fff" stroke-width="4" stroke-linecap="round" />
            </svg>
            <div class="titre">le lien</div>
          </div>
          <div id="s7-avatars" class="masque">
            <div class="av" style="background:#007aff">A</div>
            <div class="av" style="background:#fcbb00;color:#111113">K</div>
            <div class="av" style="background:#e0483e">S</div>
            <div class="av" style="background:#0066d6">M</div>
            <div class="av" style="background:#111113">+</div>
          </div>
          <div id="s7-membres" class="chip noir masque" style="background:var(--encre);color:#fff;border-color:#000">des centaines de membres</div>
          <div id="s7-ressource" class="chip ambre masque">ressource gratuite</div>
        </div>

        <!-- S8 · abonne-toi 49.9 → 54.2 -->
        <div class="centre">
          <div id="s8-cta" class="carte col ambre masque">
            <div class="titre">ABONNE-TOI</div>
          </div>
          <svg id="s8-cloche" class="masque" width="92" height="92" viewBox="0 0 48 48" fill="none">
            <path d="M24 6 a12 12 0 0 1 12 12 v8 l5 8 H7 l5 -8 v-8 A12 12 0 0 1 24 6 Z" stroke="#fcbb00" stroke-width="5" stroke-linejoin="round" />
            <path d="M19 40 a5 5 0 0 0 10 0" stroke="#fcbb00" stroke-width="5" />
          </svg>
        </div>
      </div>

      <div id="captions" class="clip" data-start="0" data-duration="54.3" data-track-index="2">
{{CAPTIONS_HTML}}
      </div>

      <!-- ===== EFFETS SONORES UNIQUEMENT (la voix reste sur votre vidéo d'origine) ===== -->
      <audio id="wh-1" src="assets/sfx/whoosh-short.mp3" data-start="0.25" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-2" src="assets/sfx/whoosh-short.mp3" data-start="4.45" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-3" src="assets/sfx/whoosh-short.mp3" data-start="8.18" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-4" src="assets/sfx/whoosh-short.mp3" data-start="17.10" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-5" src="assets/sfx/whoosh-short.mp3" data-start="28.45" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-6" src="assets/sfx/whoosh-short.mp3" data-start="35.92" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-7" src="assets/sfx/whoosh-short.mp3" data-start="38.58" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-8" src="assets/sfx/whoosh-short.mp3" data-start="49.78" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>

      <audio id="imp-1" src="assets/sfx/impact-bass-1.mp3" data-start="17.28" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="imp-2" src="assets/sfx/impact-bass-1.mp3" data-start="36.06" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="imp-3" src="assets/sfx/impact-bass-1.mp3" data-start="49.96" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>

      <audio id="err-1" src="assets/sfx/error.mp3" data-start="12.50" data-duration="1.20" data-track-index="13" data-volume="0.35"></audio>
      <audio id="notif-1" src="assets/sfx/notification.mp3" data-start="38.70" data-duration="2.00" data-track-index="13" data-volume="0.3"></audio>

      <audio id="pop-1" src="assets/sfx/pop.mp3" data-start="3.80" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-2" src="assets/sfx/pop.mp3" data-start="5.80" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-3" src="assets/sfx/pop.mp3" data-start="6.98" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-4" src="assets/sfx/pop.mp3" data-start="23.24" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-5" src="assets/sfx/pop.mp3" data-start="25.40" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-6" src="assets/sfx/pop.mp3" data-start="26.44" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-7" src="assets/sfx/pop.mp3" data-start="42.06" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>
      <audio id="pop-8" src="assets/sfx/pop.mp3" data-start="45.65" data-duration="0.72" data-track-index="14" data-volume="0.5"></audio>

      <audio id="clk-1" src="assets/sfx/click-soft.mp3" data-start="31.52" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="clk-2" src="assets/sfx/click-soft.mp3" data-start="31.92" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="clk-3" src="assets/sfx/click-soft.mp3" data-start="32.32" data-duration="0.36" data-track-index="15" data-volume="0.5"></audio>
      <audio id="spark-1" src="assets/sfx/sparkle.mp3" data-start="30.06" data-duration="1.80" data-track-index="17" data-volume="0.4"></audio>
      <audio id="riser-1" src="assets/sfx/riser.mp3" data-start="34.40" data-duration="1.60" data-media-start="7.6" data-track-index="16" data-volume="0.3"></audio>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });

      /* Entrées / sorties 100% opaques : aucun fondu d'alpha
         (indispensable pour un rendu transparent ou une incrustation propre). */
      function popIn(sel, t, d = 0.34) {
        tl.set(sel, { autoAlpha: 1 }, t);
        tl.fromTo(sel, { scale: 0 }, { scale: 1, duration: d, ease: "back.out(2)" }, t);
      }
      function popOut(sel, t, d = 0.2) {
        tl.to(sel, { scale: 0, duration: d, ease: "power2.in" }, t);
        tl.set(sel, { autoAlpha: 0 }, t + d);
      }

      /* S1 */
      popIn("#s1-titre", 0.35, 0.4);
      popIn("#s1-partie", 3.8, 0.3);
      popOut("#s1-titre", 4.15); popOut("#s1-partie", 4.18);

      /* S2 */
      popIn("#s2-claude", 4.6, 0.38);
      popIn("#s2-gratuit", 5.8, 0.32);
      popIn("#s2-prix", 6.98, 0.32);
      tl.fromTo("#s2-barre", { scaleX: 0 }, { scaleX: 1, duration: 0.26, ease: "power2.out" }, 7.34);
      popOut("#s2-claude", 7.85); popOut("#s2-gratuit", 7.88); popOut("#s2-prix", 7.91);

      /* S3 */
      popIn("#s3-alerte", 8.3, 0.36);
      tl.to("#s3-alerte", { rotate: 3, duration: 0.09, yoyo: true, repeat: 5, ease: "sine.inOut" }, 8.7);
      tl.set("#s3-alerte", { rotate: 0 }, 9.3);
      popIn("#s3-faux", 12.5, 0.34);
      popIn("#s3-data", 15.5, 0.34);
      popOut("#s3-alerte", 16.1); popOut("#s3-faux", 16.13); popOut("#s3-data", 16.16);

      /* S4 */
      popIn("#s4-marque", 17.28, 0.42);
      tl.to("#s4-marque", { scale: 1.05, duration: 0.5, yoyo: true, repeat: 3, ease: "sine.inOut" }, 17.8);
      popIn("#s4-google", 18.72, 0.3);
      popIn("#s4-c1", 23.24, 0.3);
      popIn("#s4-c2", 25.4, 0.3);
      popIn("#s4-c3", 26.44, 0.3);
      popOut("#s4-marque", 28.1); popOut("#s4-google", 28.13);
      popOut("#s4-c1", 28.16); popOut("#s4-c2", 28.19); popOut("#s4-c3", 28.22);

      /* S5 */
      popIn("#s5-guide", 28.6, 0.38);
      popIn("#s5-gratuit", 30.06, 0.32);
      popIn("#s5-etapes", 31.5, 0.34);
      popOut("#s5-guide", 35.62); popOut("#s5-gratuit", 35.65); popOut("#s5-etapes", 35.68);

      /* S6 */
      popIn("#s6-cta", 36.06, 0.4);
      popIn("#s6-fleche", 36.5, 0.3);
      tl.to("#s6-fleche", { y: 16, duration: 0.42, yoyo: true, repeat: 3, ease: "sine.inOut" }, 36.9);
      tl.set("#s6-fleche", { y: 0 }, 38.6);
      popOut("#s6-cta", 38.3); popOut("#s6-fleche", 38.33);

      /* S7 */
      popIn("#s7-lien", 38.7, 0.36);
      popOut("#s7-lien", 41.6);
      popIn("#s7-avatars", 42.06, 0.36);
      popIn("#s7-membres", 42.5, 0.32);
      popIn("#s7-ressource", 45.65, 0.32);
      popOut("#s7-avatars", 47.9); popOut("#s7-membres", 47.93); popOut("#s7-ressource", 47.96);

      /* S8 */
      popIn("#s8-cta", 49.96, 0.42);
      popIn("#s8-cloche", 50.4, 0.32);
      tl.to("#s8-cloche", { rotate: 14, duration: 0.1, yoyo: true, repeat: 7, transformOrigin: "50% 14%", ease: "sine.inOut" }, 50.8);
      tl.set("#s8-cloche", { rotate: 0 }, 51.7);
      tl.to("#s8-cta", { scale: 1.06, duration: 0.5, yoyo: true, repeat: 3, ease: "sine.inOut" }, 51.2);
      popOut("#s8-cta", 53.9); popOut("#s8-cloche", 53.93);

      /* ---------- sous-titres ---------- */
      {{CAPTIONS_TWEENS}}

      window.__timelines["selfie-overlay"] = tl;
    </script>
  </body>
</html>
