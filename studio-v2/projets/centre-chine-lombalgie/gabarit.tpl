<!doctype html>
<html lang="ar">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Centre de réadaptation de Chine — Mal au dos à force d'être assis (darija)</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      :root {
        --vert: #40ab75;
        --turquoise: #02a5a9;
        --nuit: #21415a;
        --rouge: #e5484d;
        --or: #f2b134;
        --bleu: #3b82f6;
        --degrade: linear-gradient(135deg, #40ab75 0%, #02a5a9 100%);
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1080px; height: 1920px; overflow: hidden; background: #e7f4f1; }
      body { font-family: "Cairo", sans-serif; color: var(--nuit); }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; }
      .clip { position: absolute; inset: 0; }

      /* ---------- fond (visible quand le médecin passe en vignette) ---------- */
      #fond-base { position: absolute; inset: 0;
        background: radial-gradient(circle at 50% 30%, #ffffff 0%, #e7f4f1 55%, #cfe8e2 100%); }
      #fond-points { position: absolute; inset: 0;
        background-image: radial-gradient(circle, rgba(2, 165, 169, 0.16) 2.4px, transparent 3px); background-size: 42px 42px; }

      /* ---------- vidéo du médecin et image figée de fin ---------- */
      #medecin, #fige { position: absolute; left: 0; top: 0; width: 1080px; height: 1920px; object-fit: cover; }
      #medecin { box-shadow: 0 40px 90px rgba(10, 40, 50, 0.35); }

      /* ---------- éléments communs ---------- */
      .verre { background: rgba(22, 34, 42, 0.58); backdrop-filter: blur(18px) saturate(140%);
        border: 2px solid rgba(255, 255, 255, 0.2); border-radius: 40px; box-shadow: 0 24px 60px rgba(0, 0, 0, 0.25); }
      .rond { display: flex; align-items: center; justify-content: center; border-radius: 50%; background: var(--degrade); flex: none; }

      #barre { position: absolute; left: 0; right: 0; top: 0; height: 12px; background: rgba(255, 255, 255, 0.35); }
      #barre-rempli { display: block; width: 100%; height: 12px; background: linear-gradient(270deg, #40ab75, #02a5a9);
        transform-origin: 100% 50%; }

      #logo { position: absolute; left: 36px; top: 150px; width: 176px; height: 210px; padding: 10px; border-radius: 30px;
        background: #fff; box-shadow: 0 16px 36px rgba(0, 0, 0, 0.22); }
      #logo img { display: block; width: 156px; height: 190px; }

      /* ---------- accroche (stop-scroll) ---------- */
      #accroche { position: absolute; left: 50px; right: 50px; top: 920px; padding: 28px 30px; display: flex; align-items: center; gap: 26px; }
      #accroche-ic { width: 124px; height: 124px; background: linear-gradient(135deg, #ff6b6b 0%, #e5484d 100%);
        box-shadow: 0 0 0 10px rgba(229, 72, 77, 0.25); }
      #accroche-ic b { font-weight: 900; font-size: 84px; line-height: 1; color: #fff; }
      #accroche-txt { flex: 1; font-weight: 900; font-size: 64px; line-height: 1.25; color: #fff; }

      /* ---------- sous-titres = textes animés ---------- */
      .sous { position: absolute; left: 50px; right: 50px; top: 1250px; padding: 24px 30px 30px; display: flex; align-items: center;
        gap: 26px; background: rgba(22, 34, 42, 0.58); backdrop-filter: blur(18px) saturate(140%);
        border: 2px solid rgba(255, 255, 255, 0.2); border-radius: 40px; box-shadow: 0 24px 60px rgba(0, 0, 0, 0.25); }
      .sous-ic { display: flex; align-items: center; justify-content: center; width: 116px; height: 116px; border-radius: 50%;
        background: var(--degrade); flex: none; box-shadow: 0 0 0 8px rgba(64, 171, 117, 0.22); }
      .sous-txt { flex: 1; }
      .sous-titre { font-weight: 800; font-size: 54px; line-height: 1.32; color: #fff; }
      .mot { display: inline-block; }
      .sous-trait { display: block; width: 260px; height: 8px; margin-top: 12px; border-radius: 4px;
        background: linear-gradient(270deg, #02a5a9, #40ab75); transform-origin: 100% 50%; }

      /* ---------- pastilles et bulles autour du médecin ---------- */
      .puce { position: absolute; height: 84px; padding: 0 12px 0 32px; display: flex; align-items: center; gap: 16px;
        border-radius: 42px; background: #fff; box-shadow: 0 14px 32px rgba(0, 0, 0, 0.2); font-weight: 800; font-size: 40px;
        color: var(--nuit); white-space: nowrap; }
      .puce-ic { display: flex; align-items: center; justify-content: center; width: 62px; height: 62px; border-radius: 50%;
        background: var(--degrade); flex: none; }
      .bulle { position: absolute; display: flex; align-items: center; justify-content: center; border-radius: 50%;
        background: var(--degrade); box-shadow: 0 16px 36px rgba(2, 165, 169, 0.38), 0 0 0 8px rgba(255, 255, 255, 0.35); }

      /* ---------- médecin en vignette ---------- */
      #pip-anneau { position: absolute; left: 709px; top: 193px; width: 338px; height: 590px; border-radius: 40px;
        border: 7px solid var(--turquoise); box-shadow: 0 0 0 5px rgba(255, 255, 255, 0.85), 0 24px 50px rgba(0, 40, 50, 0.3); }

      /* ---------- planche d'anatomie ---------- */
      #ana { position: absolute; left: 36px; top: 330px; width: 660px; height: 900px; border-radius: 40px; overflow: hidden;
        background: rgba(255, 255, 255, 0.95); box-shadow: 0 30px 70px rgba(10, 40, 50, 0.28); }
      .ana-tete { position: absolute; right: 24px; top: 22px; height: 64px; padding: 0 28px; border-radius: 32px; background: linear-gradient(135deg, #1e7f55, #027f82);
        color: #fff; font-weight: 800; font-size: 36px; line-height: 64px; white-space: nowrap; }
      #ana-vue { position: absolute; left: 20px; top: 100px; width: 620px; height: 780px; overflow: hidden; border-radius: 28px;
        background: radial-gradient(circle at 50% 40%, #ffffff 0%, #f1f7f6 70%, #e3efed 100%); }
      #ana-zoom, #ana-plateau, .vue { position: absolute; left: 0; top: 0; width: 620px; height: 780px; }
      .planche { display: block; width: 620px; height: 780px; }
      .zone-douleur { fill: rgba(229, 72, 77, 0.42); stroke: #e5484d; stroke-width: 3; opacity: 0; }
      .meridien { fill: none; stroke-width: 5; stroke-linecap: round; stroke-linejoin: round; }
      .point { opacity: 0; }
      .point-halo { fill: rgba(242, 177, 52, 0.4); }
      .point-coeur { fill: #fff; stroke: #f2b134; stroke-width: 4; }

      #leg { position: absolute; left: 708px; top: 812px; width: 340px; height: 420px; }
      .leg { position: absolute; right: 0; height: 72px; padding: 0 18px 0 24px; display: flex; align-items: center; gap: 14px;
        border-radius: 36px; background: #fff; box-shadow: 0 12px 28px rgba(0, 0, 0, 0.16); font-weight: 800; font-size: 32px;
        color: var(--nuit); white-space: nowrap; }
      .leg i { display: block; width: 40px; height: 10px; border-radius: 5px; flex: none; }
      .leg i.rondelle { width: 26px; height: 26px; border-radius: 50%; border: 5px solid #f2b134; background: #fff; }

      /* ---------- fin : rendez-vous et coordonnées ---------- */
      #fin-carte { position: absolute; left: 50px; right: 50px; top: 1110px; padding: 24px 30px 30px; display: flex; align-items: center; gap: 26px; }
      #fin-ic { width: 116px; height: 116px; box-shadow: 0 0 0 8px rgba(64, 171, 117, 0.22); }
      #fin-titre { font-weight: 900; font-size: 58px; line-height: 1.25; color: #fff; }
      #fin-sous { margin-top: 4px; font-weight: 700; font-size: 36px; color: rgba(255, 255, 255, 0.88); }
      #fin-trait { display: block; width: 260px; height: 8px; margin-top: 14px; border-radius: 4px;
        background: linear-gradient(270deg, #02a5a9, #40ab75); transform-origin: 100% 50%; }
      #fin-adresse { position: absolute; left: 50px; right: 50px; top: 1336px; padding: 22px 28px; border-radius: 36px; background: #fff;
        box-shadow: 0 20px 48px rgba(0, 0, 0, 0.22); }
      .ligne-a { display: flex; align-items: center; gap: 18px; }
      .ligne-a .rond { width: 64px; height: 64px; }
      .adresse { font-weight: 700; font-size: 32px; line-height: 1.38; color: var(--nuit); }
      .tel { font-weight: 900; font-size: 42px; color: var(--nuit); letter-spacing: 1px; }
      #fin-sep { display: block; height: 2px; margin: 14px 0; background: #e5eef0; }
      #fin-mention { margin-top: 12px; font-weight: 700; font-size: 28px; color: #5d7282; }

      #flash { position: absolute; inset: 0; background: #fff; opacity: 0; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="centre-chine-lombalgie" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-points"></div>
      </section>

      <video id="medecin" class="clip" src="assets/video/medecin.mp4" data-start="0" data-duration="{{FIN_VIDEO}}" data-track-index="1"
        data-has-audio="true" data-volume="1" playsinline></video>
      <img id="fige" class="clip" src="assets/img/derniere-image.jpg" alt="" data-start="41.9" data-duration="{{FIGE_DUREE}}" data-track-index="2" />

      <section id="ui" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="10">
        <svg width="0" height="0" style="position: absolute" aria-hidden="true"><defs>
          <filter id="lueur" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="3" result="b" /><feMerge><feMergeNode in="b" /><feMergeNode in="SourceGraphic" /></feMerge></filter>
        </defs></svg>

        <div id="barre"><i id="barre-rempli"></i></div>
        <div id="logo"><img src="assets/img/logo-centre-chine.png" alt="Centre de réadaptation de Chine — Marrakech" /></div>

        <div id="accroche" class="verre" dir="rtl" data-layout-allow-overlap>
          <i id="accroche-ic" class="rond">{{IC_ALERTE}}</i>
          <div id="accroche-txt">واش كيضرك ظهرك من القعدة؟</div>
        </div>

        <div id="pip-anneau"></div>

        <div id="ana" data-layout-allow-overlap>
          <div class="ana-tete" id="at-1" dir="rtl">أسفل الظهر</div>
          <div class="ana-tete" id="at-2" dir="rtl">خطوط الطاقة</div>
          <div class="ana-tete" id="at-3" dir="rtl">سلسلة الظهر</div>
          <div class="ana-tete" id="at-4" dir="rtl">نقط ف الرجل</div>
          <div id="ana-vue">
            <div id="ana-zoom" data-layout-allow-overflow><div id="ana-plateau">
              <div class="vue" id="v-face">{{SVG_FACE}}</div>
              <div class="vue" id="v-profil">{{SVG_PROFIL}}</div>
              <div class="vue" id="v-dos">{{SVG_DOS}}</div>
            </div></div>
          </div>
        </div>

        <div id="leg" data-layout-allow-overlap>
          <div class="leg" id="lg-douleur" dir="rtl" style="top: 0px"><i style="background: #e5484d"></i>مكان الوجع</div>
          <div class="leg" id="lg-vessie" dir="rtl" style="top: 0px"><i style="background: #00b5a3"></i>خط المثانة</div>
          <div class="leg" id="lg-rein" dir="rtl" style="top: 86px"><i style="background: #3b82f6"></i>خط الكلاوي</div>
          <div class="leg" id="lg-dumai" dir="rtl" style="top: 172px"><i style="background: #f2b134"></i>خط السلسلة</div>
          <div class="leg" id="lg-chengshan" dir="rtl" style="top: 0px"><i class="rondelle"></i>تشنغشان</div>
          <div class="leg" id="lg-chengjin" dir="rtl" style="top: 86px"><i class="rondelle"></i>تشنغجين</div>
          <div class="leg" id="lg-weizhong" dir="rtl" style="top: 172px"><i class="rondelle"></i>وي تشونغ</div>
        </div>

{{PUCES}}
{{BULLES}}

        <div id="sous-zone">
{{SOUS}}
        </div>

        <div id="fin-carte" class="verre" dir="rtl" data-layout-allow-overlap>
          <i id="fin-ic" class="rond">{{IC_COEUR}}</i>
          <div><div id="fin-titre">خود موعدك دابا</div><div id="fin-sous">الإبر الصينية · الماساج · الحجامة</div><i id="fin-trait"></i></div>
        </div>
        <div id="fin-adresse" dir="rtl" data-layout-allow-overlap>
          <div class="ligne-a"><i class="rond">{{IC_REPERE}}</i><div class="adresse">شارع مولاي عبد الله، عرصة باطا، إقامة ميمون، محل 28 بجانب حمام السلامة · جليز - مراكش</div></div>
          <i id="fin-sep"></i>
          <div class="ligne-a"><i class="rond">{{IC_TEL}}</i><div class="tel" dir="ltr">0688858490 · 0786112907</div></div>
          <div id="fin-mention">الطب الصيني مكمّل، وماشي بديل على الطبيب.</div>
        </div>

        <div id="flash"></div>
      </section>

{{AUDIO}}
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const D = {{DATA}};
      const tl = gsap.timeline({ paused: true });

      // ---------- outils ----------
      function pop(sel, t, o) {
        o = o || {};
        tl.fromTo(sel, { scale: o.de || 0.4, autoAlpha: 0, rotation: o.rot || 0 },
          { scale: 1, autoAlpha: 1, rotation: 0, duration: o.d || 0.36, ease: o.ease || "back.out(2.2)", immediateRender: o.ir !== false }, t);
      }
      function sort(sel, t, d) { tl.to(sel, { scale: 0.6, autoAlpha: 0, duration: d || 0.25, ease: "power2.in" }, t); }
      function flash(t, force) {
        tl.to("#flash", { opacity: force || 0.6, duration: 0.06, ease: "power2.out" }, t);
        tl.to("#flash", { opacity: 0, duration: 0.3, ease: "power2.in" }, t + 0.06);
      }
      function flotte(sel, a, z, amp) {
        const n = Math.max(0, Math.floor((z - a) / 1.2) - 1);
        if (n > 0) tl.to(sel, { y: -(amp || 10), duration: 1.2, ease: "sine.inOut", yoyo: true, repeat: n }, a);
      }
      function secousse(sel, t, a) {
        [[a, -0.6 * a], [-0.8 * a, 0.5 * a], [0.5 * a, 0.4 * a], [-0.3 * a, -0.3 * a], [0, 0]]
          .forEach((v, i) => tl.to(sel, { x: v[0], y: v[1], duration: 0.05, ease: "none" }, t + i * 0.05));
      }
      // coup de zoom sur le médecin (plein cadre seulement)
      function choc(t, s) { tl.fromTo("#medecin", { scale: s || 1.07 }, { scale: 1, duration: 0.45, ease: "power3.out", immediateRender: false }, t); }

      // ---------- médecin en vignette / plein cadre ----------
      function vignette(t) {
        tl.set("#medecin", { transformOrigin: "100% 0%" }, t);
        tl.to("#medecin", { scale: 0.3, x: -40, y: 200, borderRadius: 110, duration: 0.55, ease: "power3.inOut" }, t);
        tl.fromTo("#pip-anneau", { autoAlpha: 0, scale: 1.12 }, { autoAlpha: 1, scale: 1, duration: 0.3, ease: "back.out(2)", immediateRender: false }, t + 0.45);
        flash(t + 0.05, 0.35);
      }
      function plein(t) {
        tl.to("#pip-anneau", { autoAlpha: 0, duration: 0.15 }, t);
        tl.to("#medecin", { scale: 1, x: 0, y: 0, borderRadius: 0, duration: 0.55, ease: "power3.inOut" }, t);
        tl.set("#medecin", { transformOrigin: "50% 38%" }, t + 0.56);
        flash(t + 0.45, 0.3);
      }

      // ---------- planche d'anatomie ----------
      // repère de la page (viewBox 133 4 366 883) → pixels de la fenêtre 620 × 780
      const ECH = Math.min(620 / 366, 780 / 883), X0 = (620 - 366 * ECH) / 2;
      function zoom(cx, cy, z, t, d) {
        const px = X0 + (cx - 133) * ECH, py = (cy - 4) * ECH;
        tl.to("#ana-zoom", { scale: z, x: (310 - px) * z, y: (390 - py) * z, duration: d || 0.6, ease: "power3.inOut" }, t);
      }
      // rotation : la planche tourne sur elle-même, la vue change quand elle est de profil (90°)
      function bascule(de, vers, t, d) {
        tl.to("#ana-plateau", { rotationY: 90, duration: d, ease: "power2.in" }, t);
        tl.set("#v-" + de, { autoAlpha: 0 }, t + d);
        tl.set("#v-" + vers, { autoAlpha: 1 }, t + d);
        tl.fromTo("#ana-plateau", { rotationY: -90 }, { rotationY: 0, duration: d, ease: "power2.out", immediateRender: false }, t + d);
      }
      function anaEntre(t) {
        tl.fromTo("#ana", { autoAlpha: 0, x: -90, scale: 0.92, rotationY: -28 },
          { autoAlpha: 1, x: 0, scale: 1, rotationY: 0, duration: 0.55, ease: "power3.out", immediateRender: false }, t);
      }
      function anaSort(t) { tl.to("#ana", { autoAlpha: 0, x: -90, scale: 0.92, rotationY: -28, duration: 0.35, ease: "power2.in" }, t); }
      function trace(sel, t, d) { tl.fromTo(sel, { attr: { "stroke-dashoffset": 1 } }, { attr: { "stroke-dashoffset": 0 }, duration: d, ease: "power1.inOut" }, t); }
      function points(cls, t, pas) {
        document.querySelectorAll("." + cls).forEach((p, i) => {
          tl.fromTo(p, { opacity: 0, scale: 0.2, transformOrigin: "50% 50%" }, { opacity: 1, scale: 1, duration: 0.3, ease: "back.out(3)" }, t + i * (pas || 0));
        });
      }
      function pulse(sel, t, z) {
        const n = Math.max(0, Math.floor((z - t) / 0.5) - 1);
        if (n > 0) tl.to(sel, { scale: 1.35, transformOrigin: "50% 50%", duration: 0.25, ease: "sine.inOut", yoyo: true, repeat: n }, t);
      }

      // ---------- état initial ----------
      tl.set("#medecin", { transformOrigin: "50% 38%" }, 0);
      tl.set("#ana-plateau", { transformPerspective: 1400 }, 0);
      gsap.set("#ana", { transformPerspective: 1600, autoAlpha: 0 });
      gsap.set(["#v-face", "#v-dos", "#pip-anneau", ".ana-tete", ".leg", "#fin-carte", "#fin-adresse"], { autoAlpha: 0 });
      tl.set("#v-profil", { autoAlpha: 1 }, 0);
      tl.fromTo("#barre-rempli", { scaleX: 0 }, { scaleX: 1, duration: D.duree, ease: "none" }, 0);

      // ---------- 0 s · accroche stop-scroll ----------
      tl.fromTo("#medecin", { scale: 1.22 }, { scale: 1, duration: 0.8, ease: "power3.out" }, 0);
      flash(0.0, 0.7);
      pop("#accroche", 0.08, { de: 0.7, ease: "back.out(1.8)" });
      tl.fromTo("#accroche-ic", { scale: 1 }, { scale: 1.16, duration: 0.22, ease: "sine.inOut", yoyo: true, repeat: 5 }, 0.45);
      secousse("#accroche", 0.5, 10);
      tl.to("#accroche", { y: -60, autoAlpha: 0, duration: 0.3, ease: "power2.in" }, 1.95);
      pop("#logo", 0.25, { de: 0.6 });

      // ---------- sous-titres : cartes en verre, mots révélés pendant la parole ----------
      D.sous.forEach(([id, a, z, s0, s1]) => {
        const el = document.getElementById(id);
        tl.fromTo(el, { autoAlpha: 0, y: 46, scale: 0.96 }, { autoAlpha: 1, y: 0, scale: 1, duration: 0.3, ease: "back.out(1.6)" }, a);
        tl.fromTo(el.querySelector(".sous-ic"), { scale: 0.3, rotation: -40 }, { scale: 1, rotation: 0, duration: 0.4, ease: "back.out(2.4)" }, a + 0.05);
        tl.fromTo(el.querySelector(".sous-trait"), { scaleX: 0 }, { scaleX: 1, duration: 0.4, ease: "power3.out" }, a + 0.15);
        const mots = el.querySelectorAll(".mot");
        const duree = Math.max(0.5, (s1 - s0) * 0.85);
        mots.forEach((m, i) => tl.fromTo(m, { autoAlpha: 0, y: 16 }, { autoAlpha: 1, y: 0, duration: 0.2, ease: "power2.out" },
          Math.max(a + 0.08, s0 + i * duree / mots.length)));
        tl.to(el, { autoAlpha: 0, y: -26, duration: 0.2, ease: "power2.in" }, z - 0.2);
      });

      // ---------- pastilles et bulles ----------
      D.puces.forEach(([id, a, z]) => {
        pop("#" + id, a, { de: 0.4, rot: 6 });
        flotte("#" + id, a + 0.4, z, 8);
        if (z < D.duree) sort("#" + id, z - 0.25);
      });
      D.bulles.forEach(([id, a, z]) => {
        pop("#" + id, a, { de: 0.2, rot: -30, ease: "back.out(2.8)" });
        flotte("#" + id, a + 0.4, z, 14);
        if (z < D.duree) sort("#" + id, z - 0.25);
      });

      // ---------- coups de zoom sur les mots forts ----------
      choc(7.6, 1.06);
      choc(13.1, 1.07);
      choc(34.95, 1.07);

      // ---------- 9,45 s · le mal de dos : planche de profil puis de dos ----------
      vignette(9.45);
      anaEntre(9.6);
      pop("#at-1", 9.8, { de: 0.6 });
      tl.to("#z-lombes", { opacity: 1, duration: 0.25 }, 9.85);
      pop("#lg-douleur", 9.95, { de: 0.6 });
      bascule("profil", "dos", 10.2, 0.18);
      tl.to("#z-lombaires", { opacity: 1, duration: 0.2 }, 10.4);
      zoom(316, 356, 1.9, 10.5, 0.5);
      tl.to("#z-lombaires", { opacity: 0.35, duration: 0.25, ease: "sine.inOut", yoyo: true, repeat: 3 }, 10.6);
      anaSort(11.75);
      sort("#lg-douleur", 11.75, 0.2);
      plein(11.75);
      tl.set(["#at-1", "#z-lombaires"], { autoAlpha: 0 }, 12.2);
      tl.set("#ana-zoom", { scale: 1, x: 0, y: 0 }, 12.2);

      // ---------- 15,7 s · méridiens : vessie (dos), reins (face), vaisseau gouverneur (dos) ----------
      vignette(15.7);
      anaEntre(15.85);
      pop("#at-2", 15.95, { de: 0.6 });
      trace("#m-vessie-g", 16.2, 1.7);
      trace("#m-vessie-d", 16.25, 1.7);
      pop("#lg-vessie", 16.5, { de: 0.6 });
      bascule("dos", "profil", 18.2, 0.17);
      bascule("profil", "face", 18.54, 0.17);
      trace("#m-rein-g", 18.95, 0.8);
      trace("#m-rein-d", 19.0, 0.8);
      pop("#lg-rein", 18.95, { de: 0.6 });
      bascule("face", "profil", 20.55, 0.15);
      bascule("profil", "dos", 20.85, 0.15);
      tl.to("#at-2", { autoAlpha: 0, duration: 0.15 }, 20.9);
      pop("#at-3", 21.0, { de: 0.6 });
      trace("#m-dumai", 21.15, 1.15);
      pop("#lg-dumai", 21.2, { de: 0.6 });
      points("pt-dm", 22.35, 0.2);
      pulse(".pt-dm .point-halo", 23.4, 24.4);

      // ---------- 24 s · points à distance : la jambe ----------
      ["#lg-vessie", "#lg-rein", "#lg-dumai"].forEach((l, i) => sort(l, 24.3 + i * 0.05, 0.2));
      tl.to("#at-3", { autoAlpha: 0, duration: 0.15 }, 24.45);
      pop("#at-4", 24.55, { de: 0.6 });
      zoom(322, 700, 1.95, 24.55, 0.8);
      points("pt-chengshan", 26.6, 0.08);
      pop("#lg-chengshan", 26.6, { de: 0.6 });
      pulse(".pt-chengshan .point-halo", 27.0, 31.0);
      points("pt-chengjin", 28.1, 0.08);
      pop("#lg-chengjin", 28.1, { de: 0.6 });
      pulse(".pt-chengjin .point-halo", 28.5, 31.0);
      zoom(320, 640, 2.5, 29.4, 0.5);
      points("pt-weizhong", 29.55, 0.08);
      pop("#lg-weizhong", 29.55, { de: 0.6 });
      pulse(".pt-weizhong .point-halo", 29.95, 31.0);
      anaSort(31.1);
      ["#lg-chengshan", "#lg-chengjin", "#lg-weizhong"].forEach((l, i) => sort(l, 31.1 + i * 0.04, 0.2));
      plein(31.1);

      // ---------- 40 s · rendez-vous et coordonnées (image figée à partir de 41,9 s) ----------
      tl.fromTo("#fin-carte", { autoAlpha: 0, y: 70, scale: 0.95 }, { autoAlpha: 1, y: 0, scale: 1, duration: 0.4, ease: "back.out(1.6)" }, 40.0);
      tl.fromTo("#fin-ic", { scale: 0.3, rotation: -40 }, { scale: 1, rotation: 0, duration: 0.45, ease: "back.out(2.4)" }, 40.05);
      tl.fromTo("#fin-trait", { scaleX: 0 }, { scaleX: 1, duration: 0.4, ease: "power3.out" }, 40.2);
      tl.fromTo("#fin-adresse", { autoAlpha: 0, y: 70 }, { autoAlpha: 1, y: 0, duration: 0.4, ease: "back.out(1.6)" }, 40.4);
      tl.fromTo("#fin-ic", { scale: 1 }, { scale: 1.1, duration: 0.4, ease: "sine.inOut", yoyo: true, repeat: 5, immediateRender: false }, 40.8);
      tl.fromTo("#logo", { scale: 1 }, { scale: 1.08, duration: 0.18, ease: "power2.out", yoyo: true, repeat: 1, immediateRender: false }, 40.0);
      tl.fromTo("#fige", { scale: 1 }, { scale: 1.04, duration: D.duree - 41.9, ease: "none" }, 41.9);

      window.__timelines["centre-chine-lombalgie"] = tl;
    </script>
  </body>
</html>
