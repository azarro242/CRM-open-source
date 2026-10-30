<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Oddysee — Meta : le 30 octobre ? Faux.</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      :root {
        --violet: #632bc5;
        --violet-vif: #6a3be8;
        --violet-pale: #a877ff;
        --lilas: #e2d7f7;
        --brume: #f7f3ff;
        --or: #f0c860;
        --or-fonce: #d4a847;
        --encre: #1d1d1d;
        --gris: #6f6a7a;
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1080px; height: 1920px; overflow: hidden; background: var(--brume); }
      body { font-family: "Outfit", sans-serif; color: var(--encre); }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; }
      .clip { position: absolute; inset: 0; }
      .plein { position: absolute; inset: 0; }
      .cache { opacity: 0; visibility: hidden; }

      /* ---------- fond ---------- */
      #fond-base { position: absolute; inset: 0; background: var(--brume); }
      #fond-points { position: absolute; left: -80px; top: -80px; width: 1240px; height: 2160px;
        background-image: radial-gradient(circle, rgba(99, 43, 197, 0.17) 2.4px, transparent 3px);
        background-size: 40px 40px; }
      #fond-vignette { position: absolute; inset: 0;
        background: radial-gradient(ellipse 78% 62% at 50% 44%, rgba(247, 243, 255, 0) 52%, rgba(74, 26, 150, 0.24) 100%); }

      /* ---------- entête permanente ---------- */
      #entete-logo-n, #entete-logo-b { position: absolute; left: 60px; top: 196px; height: 50px; width: auto; }
      #entete-pastille { position: absolute; right: 60px; top: 192px; height: 58px; padding: 0 26px 0 22px;
        display: flex; align-items: center; gap: 14px; background: #fff; border: 3px solid var(--violet);
        border-radius: 40px; font-weight: 800; font-size: 28px; letter-spacing: 2px; color: var(--violet); }
      #entete-point { display: block; width: 16px; height: 16px; border-radius: 50%; background: var(--violet-vif); }

      /* ---------- éléments communs des scènes ---------- */
      .cam, .sec, .kb { position: absolute; inset: 0; }
      .sur { position: absolute; left: 60px; right: 60px; top: 292px; text-align: center; font-weight: 900;
        font-size: 50px; letter-spacing: 2px; text-transform: uppercase; color: var(--encre); }
      .sur-trait { display: block; width: 180px; height: 10px; margin: 14px auto 0; border-radius: 6px;
        background: var(--violet); }
      .masc { position: absolute; width: 373px; height: 560px; }
      .masc img { display: block; width: 373px; height: 560px; }
      .halo { position: absolute; left: 6px; top: -6px; width: 360px; height: 360px; border-radius: 50%;
        background: radial-gradient(circle, rgba(226, 215, 247, 0.95) 0%, rgba(226, 215, 247, 0) 70%); }
      .source { position: absolute; height: 58px; padding: 0 24px; display: flex; align-items: center;
        border-radius: 30px; background: rgba(29, 29, 29, 0.86); color: #fff; font-weight: 600; font-size: 28px;
        letter-spacing: 0.3px; white-space: nowrap; }
      .source b { color: var(--or); font-weight: 800; margin-right: 10px; }

      /* ---------- S1 · accroche ---------- */
      #s1-carte { position: absolute; left: 90px; top: 410px; width: 900px; height: 540px; padding: 44px 56px;
        border-radius: 44px; background: var(--encre); box-shadow: 0 34px 70px rgba(40, 10, 90, 0.35); }
      #s1-label { font-weight: 700; font-size: 28px; letter-spacing: 4px; color: var(--lilas); text-transform: uppercase; }
      #s1-date { position: relative; display: block; width: 640px; margin-top: 6px; font-weight: 900; font-size: 270px;
        line-height: 1; letter-spacing: -6px; color: var(--violet-pale); }
      #s1-barre { position: absolute; left: -10px; top: 128px; width: 660px; height: 26px; border-radius: 14px;
        background: var(--or); transform-origin: left center; }
      #s1-titre { margin-top: 18px; font-weight: 800; font-size: 60px; line-height: 1.05; color: #fff;
        text-transform: uppercase; }
      #s1-faux { position: absolute; left: 280px; top: 560px; width: 520px; height: 230px; display: flex;
        align-items: center; justify-content: center; border-radius: 30px; border: 10px solid #fff;
        background: var(--violet-vif); color: #fff; font-weight: 900; font-size: 170px; letter-spacing: 4px;
        box-shadow: 0 24px 50px rgba(40, 10, 90, 0.45); }
      #s1-m { right: 4px; top: 905px; }

      /* ---------- S2 · repoussé ---------- */
      .cal { position: absolute; width: 500px; height: 560px; border-radius: 40px; background: #fff; overflow: hidden;
        box-shadow: 0 30px 60px rgba(40, 10, 90, 0.25); }
      .cal-tete { height: 120px; display: flex; align-items: center; justify-content: center; background: var(--violet);
        color: #fff; font-weight: 800; font-size: 48px; letter-spacing: 3px; }
      .cal-jour { display: block; text-align: center; font-weight: 900; font-size: 300px; line-height: 1.05;
        letter-spacing: -8px; color: var(--encre); }
      .cal-pied { text-align: center; font-weight: 700; font-size: 34px; letter-spacing: 6px; color: var(--gris); }
      #s2-nov { left: 290px; top: 410px; }
      #s2-nov .cal-tete { background: var(--violet-vif); }
      #s2-nov .cal-jour { color: var(--violet); }
      #s2-oct { left: 250px; top: 400px; }
      #s2-oct .cal-tete { background: var(--encre); }
      #s2-rature { position: absolute; left: 70px; top: 290px; width: 360px; height: 24px; border-radius: 12px;
        background: var(--violet-vif); transform-origin: left center; }
      #s2-tampon { position: absolute; left: 700px; top: 660px; height: 84px; padding: 0 34px; display: flex;
        align-items: center; border-radius: 20px; background: var(--or); color: var(--encre); font-weight: 900;
        font-size: 44px; letter-spacing: 3px; box-shadow: 0 16px 34px rgba(40, 10, 90, 0.3); }
      #s2-src { right: 40px; top: 1080px; }
      #s2-m { left: 0px; top: 900px; }

      /* ---------- S3 · mercredi 28 ---------- */
      #s3-nuit { position: absolute; inset: 0; transform-origin: 50% 100%;
        background: radial-gradient(circle at 50% 40%, #44198f 0%, #241048 46%, #141019 100%); }
      #s3-sur { color: #fff; }
      #s3-sur .sur-trait { background: var(--or); }
      #s3-cadran { position: absolute; left: 230px; top: 460px; width: 620px; height: 620px; }
      #s3-ticks { position: absolute; inset: 0; }
      .tick { position: absolute; left: 304px; top: 0; width: 12px; height: 46px; border-radius: 6px;
        background: rgba(226, 215, 247, 0.55); transform-origin: 6px 310px; }
      #s3-aiguille { position: absolute; left: 303px; top: 40px; width: 14px; height: 270px; border-radius: 7px;
        background: var(--or); transform-origin: 7px 270px; }
      #s3-mercredi { position: absolute; left: 0; right: 0; top: 560px; text-align: center; font-weight: 800;
        font-size: 64px; letter-spacing: 10px; color: var(--lilas); }
      #s3-28 { position: absolute; left: 0; right: 0; top: 610px; text-align: center; font-weight: 900; font-size: 330px;
        line-height: 1; letter-spacing: -8px; color: #fff; }
      #s3-octobre { position: absolute; left: 0; right: 0; top: 942px; text-align: center; font-weight: 800;
        font-size: 50px; letter-spacing: 12px; color: var(--violet-pale); }
      #s3-bloque { position: absolute; left: 70px; top: 1150px; height: 110px; padding: 0 40px 0 30px; display: flex;
        align-items: center; gap: 24px; border-radius: 26px; background: var(--or); color: var(--encre);
        font-weight: 900; font-size: 50px; letter-spacing: 1px; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.35); }
      #s3-cadenas { position: relative; width: 56px; height: 70px; }
      #s3-anse { position: absolute; left: 10px; top: 0; width: 36px; height: 40px; border: 8px solid var(--encre);
        border-bottom: none; border-radius: 20px 20px 0 0; }
      #s3-corps { position: absolute; left: 0; top: 30px; width: 56px; height: 40px; border-radius: 10px;
        background: var(--encre); }
      #s3-m { right: 10px; top: 930px; }

      /* ---------- S4 · la page dans Instagram ---------- */
      #s4-tel { position: absolute; left: 70px; top: 390px; width: 470px; height: 870px; padding: 18px;
        border-radius: 64px; background: var(--encre); box-shadow: 0 34px 70px rgba(40, 10, 90, 0.35); }
      #s4-ecran { position: relative; width: 434px; height: 834px; border-radius: 48px; overflow: hidden; background: #fff; }
      #s4-appbar { height: 92px; padding: 30px 28px 0; font-weight: 800; font-size: 32px; color: var(--encre); }
      #s4-post-tete { height: 74px; display: flex; align-items: center; gap: 14px; padding: 0 22px; }
      #s4-avatar { width: 50px; height: 50px; border-radius: 50%; background: var(--violet); }
      #s4-compte { font-weight: 700; font-size: 30px; line-height: 1.05; }
      #s4-compte span { display: block; font-weight: 500; font-size: 28px; color: var(--gris); }
      #s4-visuel { position: relative; width: 434px; height: 400px;
        background: linear-gradient(150deg, var(--lilas) 0%, var(--violet-pale) 100%); }
      #s4-sac { position: absolute; left: 137px; top: 90px; width: 160px; height: 190px; }
      #s4-cta { height: 76px; margin: 0; display: flex; align-items: center; justify-content: space-between;
        padding: 0 26px; background: var(--violet); color: #fff; font-weight: 800; font-size: 28px; }
      .ligne { height: 16px; border-radius: 8px; background: #e7e3ee; margin: 18px 24px 0; }
      #s4-tap { position: absolute; left: 330px; top: 600px; width: 90px; height: 90px; border-radius: 50%;
        border: 8px solid rgba(29, 29, 29, 0.55); background: rgba(29, 29, 29, 0.18); }
      #s4-feuille { position: absolute; left: 0; bottom: 0; width: 434px; height: 650px; padding: 18px 22px;
        border-radius: 36px 36px 0 0; background: #fff; box-shadow: 0 -18px 40px rgba(40, 10, 90, 0.28); }
      #s4-poignee { width: 70px; height: 8px; border-radius: 4px; background: #d8d3e2; margin: 0 auto 18px; }
      #s4-dansapp { display: inline-block; height: 40px; padding: 0 16px; line-height: 40px; border-radius: 20px;
        background: var(--lilas); color: var(--violet); font-weight: 800; font-size: 28px; letter-spacing: 1px; }
      #s4-produit { display: flex; gap: 16px; margin-top: 18px; }
      #s4-produit-img { width: 150px; height: 150px; border-radius: 22px;
        background: linear-gradient(150deg, var(--lilas), var(--violet-pale)); }
      #s4-produit-txt { flex: 1; padding-top: 10px; }
      #s4-produit-txt b { display: block; font-weight: 800; font-size: 30px; }
      #s4-sugg-titre { margin-top: 24px; font-weight: 800; font-size: 28px; letter-spacing: 1px; color: var(--violet); }
      #s4-sugg { display: flex; gap: 14px; margin-top: 12px; }
      .sugg { position: relative; width: 120px; height: 150px; border-radius: 18px; background: #efeaf8; }
      .sugg i { position: absolute; left: 10px; bottom: 10px; height: 38px; padding: 0 12px; line-height: 38px;
        border-radius: 19px; background: var(--or); color: var(--encre); font-style: normal; font-weight: 800;
        font-size: 28px; }
      #s4-insta { position: absolute; left: 470px; top: 430px; height: 76px; padding: 0 28px; display: flex;
        align-items: center; border-radius: 22px; background: var(--violet); color: #fff; font-weight: 900;
        font-size: 32px; letter-spacing: 1px; box-shadow: 0 18px 36px rgba(40, 10, 90, 0.3); }
      #s4-site { position: absolute; left: 590px; top: 560px; width: 430px; height: 300px; border-radius: 26px;
        background: #fff; overflow: hidden; box-shadow: 0 24px 50px rgba(40, 10, 90, 0.22); }
      #s4-site-barre { height: 54px; display: flex; align-items: center; gap: 8px; padding: 0 18px; background: #efeaf8; }
      #s4-site-barre i { display: block; width: 13px; height: 13px; border-radius: 50%; background: #cfc8de; }
      #s4-url { margin-left: 10px; height: 32px; padding: 0 16px; line-height: 32px; border-radius: 16px; background: #fff;
        font-weight: 700; font-size: 28px; color: var(--encre); }
      #s4-site-bouton { margin: 24px 24px 0; width: 210px; height: 56px; border-radius: 14px; background: var(--violet);
        color: #fff; font-weight: 800; font-size: 28px; line-height: 56px; text-align: center; }
      #s4-site-legende { position: absolute; left: 600px; top: 878px; font-weight: 800; font-size: 30px;
        letter-spacing: 2px; color: var(--gris); text-transform: uppercase; }
      #s4-croix { position: absolute; left: 740px; top: 600px; width: 150px; height: 150px; border-radius: 50%;
        background: var(--encre); color: #fff; font-weight: 900; font-size: 96px; line-height: 150px; text-align: center;
        box-shadow: 0 18px 40px rgba(0, 0, 0, 0.35); }
      #s4-reco { position: absolute; left: 70px; top: 1280px; height: 54px; padding: 0 22px; line-height: 48px;
        border: 3px solid var(--encre); border-radius: 27px; font-weight: 800; font-size: 28px; letter-spacing: 3px;
        color: var(--encre); }
      #s4-m { right: 0px; top: 920px; }

      /* ---------- S5 · le réglage ---------- */
      #s5-panneau { position: absolute; left: 60px; top: 400px; width: 960px; height: 470px; padding: 36px 40px;
        border-radius: 40px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }
      #s5-chemin { display: flex; flex-wrap: wrap; align-items: center; gap: 10px 12px; }
      .puce { height: 56px; padding: 0 22px; line-height: 56px; border-radius: 28px; background: var(--lilas);
        color: var(--violet); font-weight: 800; font-size: 30px; white-space: nowrap; }
      .fleche { font-weight: 900; font-size: 30px; color: var(--violet-pale); }
      #s5-reglage { position: absolute; left: 40px; right: 40px; top: 250px; height: 170px; padding: 0 30px;
        display: flex; align-items: center; justify-content: space-between; border-radius: 28px; background: var(--brume); }
      #s5-nom { font-weight: 900; font-size: 48px; color: var(--encre); }
      #s5-nom span { display: block; font-weight: 600; font-size: 28px; color: var(--gris); margin-top: 4px; }
      #s5-inter { position: relative; width: 176px; height: 94px; border-radius: 47px; background: var(--violet); }
      #s5-bouton { position: absolute; left: 92px; top: 10px; width: 74px; height: 74px; border-radius: 50%;
        background: #fff; box-shadow: 0 6px 14px rgba(0, 0, 0, 0.2); }
      #s5-etat { position: absolute; right: 70px; top: 190px; height: 52px; padding: 0 20px; line-height: 52px;
        border-radius: 26px; background: var(--encre); color: #fff; font-weight: 800; font-size: 30px; letter-spacing: 2px; }
      #s5-curseur { position: absolute; left: 0; top: 0; width: 64px; height: 64px; }
      #s5-ab { position: absolute; left: 60px; top: 920px; width: 640px; height: 220px; }
      .ab { position: absolute; top: 0; width: 280px; height: 210px; padding: 26px; border-radius: 30px; color: #fff; }
      .ab b { display: block; font-weight: 900; font-size: 50px; letter-spacing: 1px; }
      .ab span { display: block; margin-top: 10px; font-weight: 700; font-size: 30px; }
      #s5-a { left: 0; background: var(--violet); }
      #s5-b { left: 360px; background: var(--encre); }
      #s5-vs { position: absolute; left: 272px; top: 62px; width: 96px; height: 96px; border-radius: 50%;
        background: var(--or); color: var(--encre); font-weight: 900; font-size: 38px; line-height: 96px; text-align: center; }
      #s5-src { left: 60px; top: 1166px; width: 620px; height: auto; padding: 12px 24px; white-space: normal;
        line-height: 1.25; border-radius: 24px; display: block; }
      #s5-m { right: 0px; top: 900px; }

      /* ---------- S6 · partage + signature ---------- */
      #s6-dm { position: absolute; left: 90px; top: 400px; width: 900px; height: 440px; padding: 30px 36px;
        border-radius: 40px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }
      #s6-dm-tete { display: flex; align-items: center; gap: 16px; font-weight: 800; font-size: 30px; }
      #s6-dest { height: 50px; padding: 0 20px; line-height: 50px; border-radius: 25px; background: var(--lilas);
        color: var(--violet); font-weight: 800; font-size: 30px; }
      #s6-bulle { position: absolute; right: 36px; top: 112px; width: 330px; height: 220px; border-radius: 30px 30px 8px 30px;
        background: var(--violet); padding: 16px; }
      #s6-mini { width: 298px; height: 150px; border-radius: 18px; background: var(--encre); padding: 14px 18px; color: #fff; }
      #s6-mini b { display: block; font-weight: 900; font-size: 58px; color: var(--violet-pale); line-height: 1; }
      #s6-mini span { display: inline-block; margin-top: 10px; height: 38px; padding: 0 14px; line-height: 38px;
        border-radius: 10px; background: var(--violet-vif); font-weight: 900; font-size: 28px; }
      #s6-envoye { position: absolute; right: 40px; top: 346px; font-weight: 800; font-size: 32px; color: var(--violet); }
      #s6-avion-zone { position: absolute; left: 36px; top: 300px; width: 104px; height: 104px; border-radius: 50%;
        background: var(--violet); }
      #s6-avion { position: absolute; left: 22px; top: 24px; width: 60px; height: 56px; }
      #s6-logo { position: absolute; left: 420px; top: 900px; width: 560px; height: auto; }
      #s6-badge { position: absolute; left: 470px; top: 1130px; height: 70px; padding: 0 28px; display: flex;
        align-items: center; border-radius: 35px; background: var(--or); color: var(--encre); font-weight: 900;
        font-size: 28px; letter-spacing: 2px; }
      #s6-audit { position: absolute; left: 400px; top: 1222px; width: 640px; text-align: center; font-weight: 700;
        font-size: 30px; color: var(--encre); }
      #s6-m { left: 10px; top: 900px; }

      /* ---------- sous-titres karaoké ---------- */
      #st-zone { position: absolute; left: 50px; right: 50px; top: 1462px; height: 180px; }
      .st { position: absolute; left: 0; right: 0; top: 0; display: flex; flex-wrap: wrap; justify-content: center;
        gap: 6px 18px; opacity: 0; visibility: hidden; }
      .m { display: inline-block; padding: 4px 16px 6px; border-radius: 16px; font-weight: 900; font-size: 74px;
        line-height: 1.08; text-transform: uppercase; color: var(--encre); white-space: nowrap;
        background-color: rgba(99, 43, 197, 0); }

      /* ---------- transitions ---------- */
      #flash { position: absolute; inset: 0; opacity: 0;
        background: radial-gradient(circle at 50% 46%, rgba(168, 119, 255, 0.95) 0%, rgba(99, 43, 197, 0.85) 45%, rgba(99, 43, 197, 0) 100%); }
      #eclair { position: absolute; inset: 0; opacity: 0; background: #fff; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="oddysee-meta" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-points"></div>
        <div id="fond-vignette"></div>
      </section>

      <!-- S1 · accroche -->
      <section id="s1" class="clip" {{S1}} data-track-index="1">
        <div class="cam" id="s1-cam"><div class="sec" id="s1-sec"><div class="kb" id="s1-kb">
          <div data-layout-allow-overlap class="sur" id="s1-sur">Alerte Meta Ads<i class="sur-trait" id="s1-trait"></i></div>
          <div id="s1-carte" data-layout-allow-overlap>
            <div id="s1-label">Partout sur ton fil cette semaine</div>
            <div id="s1-date">30/10<i id="s1-barre"></i></div>
            <div id="s1-titre">Meta change ses règles</div>
          </div>
          <div class="masc" id="s1-m"><img id="s1-m-img" src="assets/img/m-s1-moustache-perplexe.webp" alt="" /></div>
          <div id="s1-faux" data-layout-allow-overlap>FAUX</div>
        </div></div></div>
      </section>

      <!-- S2 · repoussé au 20 novembre -->
      <section id="s2" class="clip" {{S2}} data-track-index="2">
        <div class="cam" id="s2-cam"><div class="sec" id="s2-sec"><div class="kb" id="s2-kb">
          <div data-layout-allow-overlap class="sur" id="s2-sur">Annoncé vendredi 23/10<i class="sur-trait" id="s2-trait"></i></div>
          <div class="cal" id="s2-nov" data-layout-allow-overlap data-layout-allow-occlusion><div class="cal-tete">NOVEMBRE 2026</div><b class="cal-jour">20</b><div class="cal-pied">VENDREDI</div></div>
          <div class="cal" id="s2-oct" data-layout-allow-overlap data-layout-allow-occlusion><div class="cal-tete">OCTOBRE 2026</div><b class="cal-jour">30</b><div class="cal-pied">VENDREDI</div><i id="s2-rature"></i></div>
          <div id="s2-tampon" data-layout-allow-overlap>REPOUSSÉ</div>
          <div class="source" id="s2-src"><b>SOURCE</b>Reuters 23/10 · Meta Help Center</div>
          <div class="masc" id="s2-m"><img id="s2-m-img" src="assets/img/m-s2-femme-sceptique.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S3 · mercredi 28, ça ne bouge pas -->
      <section id="s3" class="clip" {{S3}} data-track-index="3">
        <div id="s3-nuit"></div>
        <div class="cam" id="s3-cam"><div class="sec" id="s3-sec"><div class="kb" id="s3-kb">
          <div data-layout-allow-overlap class="sur" id="s3-sur">Ce qui ne bouge pas<i class="sur-trait" id="s3-trait"></i></div>
          <div id="s3-cadran">
            <div id="s3-ticks">{{TICKS}}</div>
            <i id="s3-aiguille"></i>
          </div>
          <div id="s3-mercredi">MERCREDI</div>
          <div id="s3-28">28</div>
          <div id="s3-octobre">OCTOBRE</div>
          <div id="s3-bloque"><div id="s3-cadenas"><i id="s3-anse"></i><i id="s3-corps"></i></div>ÇA NE BOUGE PAS</div>
          <div class="masc" id="s3-m"><i class="halo"></i><img id="s3-m-img" src="assets/img/m-s3-moustache-perplexe.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S4 · un clic → une page dans Instagram au lieu de ton site -->
      <section id="s4" class="clip" {{S4}} data-track-index="4">
        <div class="cam" id="s4-cam"><div class="sec" id="s4-sec"><div class="kb" id="s4-kb">
          <div data-layout-allow-overlap class="sur" id="s4-sur">Ce qui change le 28<i class="sur-trait" id="s4-trait"></i></div>
          <div id="s4-site">
            <div id="s4-site-barre"><i></i><i></i><i></i><span id="s4-url">ton-site.com</span></div>
            <div class="ligne" style="width: 300px; height: 22px; margin-top: 26px"></div>
            <div class="ligne" style="width: 360px"></div>
            <div class="ligne" style="width: 250px"></div>
            <div id="s4-site-bouton">Commander</div>
          </div>
          <div id="s4-site-legende">Avant : ton site</div>
          <div id="s4-croix">✕</div>
          <div id="s4-tel"><div id="s4-ecran" data-layout-allow-overlap data-layout-allow-occlusion data-layout-allow-overflow>
            <div id="s4-appbar">Instagram</div>
            <div id="s4-post-tete"><i id="s4-avatar"></i><div id="s4-compte">ta.marque<span>Sponsorisé</span></div></div>
            <div id="s4-visuel">
              <svg id="s4-sac" viewBox="0 0 160 190"><path d="M50 60 V42 a30 30 0 0 1 60 0 V60" fill="none" stroke="#fff" stroke-width="12" stroke-linecap="round"/><rect x="10" y="58" width="140" height="124" rx="22" fill="#fff"/><rect x="38" y="96" width="84" height="14" rx="7" fill="#a877ff"/></svg>
            </div>
            <div id="s4-cta" data-layout-allow-occlusion>Acheter <span data-layout-allow-occlusion>›</span></div>
            <div class="ligne" style="width: 300px"></div>
            <div class="ligne" style="width: 220px"></div>
            <div id="s4-feuille">
              <div id="s4-poignee"></div>
              <span id="s4-dansapp">DANS L'APP</span>
              <div id="s4-produit"><div id="s4-produit-img"></div><div id="s4-produit-txt"><b>Ton produit</b><div class="ligne" style="margin: 14px 0 0; width: 180px"></div><div class="ligne" style="margin: 12px 0 0; width: 120px"></div></div></div>
              <div id="s4-sugg-titre">SUGGESTIONS DE META</div>
              <div id="s4-sugg"><div class="sugg"><i>Meta</i></div><div class="sugg"><i>Meta</i></div><div class="sugg"><i>Meta</i></div></div>
            </div>
            <i id="s4-tap"></i>
          </div></div>
          <div id="s4-insta">PAGE DANS INSTAGRAM</div>
          <div id="s4-reco">RECONSTITUTION</div>
          <div class="masc" id="s4-m"><img id="s4-m-img" src="assets/img/m-s4-moustache-colere.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S5 · le réglage -->
      <section id="s5" class="clip" {{S5}} data-track-index="5">
        <div class="cam" id="s5-cam"><div class="sec" id="s5-sec"><div class="kb" id="s5-kb">
          <div data-layout-allow-overlap class="sur" id="s5-sur">Quoi faire avant mercredi<i class="sur-trait" id="s5-trait"></i></div>
          <div id="s5-panneau">
            <div id="s5-chemin" data-layout-allow-overlap>
              <span class="puce" id="s5-p1">Ads Manager</span><span class="fleche" id="s5-f1">›</span>
              <span class="puce" id="s5-p2">Ta pub</span><span class="fleche" id="s5-f2">›</span>
              <span class="puce" id="s5-p3">Advantage+ Creative et Destination</span>
            </div>
            <div id="s5-reglage">
              <div id="s5-nom">Navigation produit<span>Page produit dans l'app + suggestions</span></div>
              <div id="s5-inter"><i id="s5-bouton"></i></div>
            </div>
            <div id="s5-etat">DÉSACTIVÉE</div>
          </div>
          <svg id="s5-curseur" viewBox="0 0 64 64"><path d="M8 4 L8 52 L21 40 L30 60 L39 56 L30 36 L48 36 Z" fill="#1d1d1d" stroke="#fff" stroke-width="4" stroke-linejoin="round"/></svg>
          <div id="s5-ab">
            <div class="ab" id="s5-a"><b>PUB A</b><span>option activée</span></div>
            <div class="ab" id="s5-b"><b>PUB B</b><span>option coupée</span></div>
            <div id="s5-vs">VS</div>
          </div>
          <div class="source" id="s5-src"><b>META</b>+3 % de conversions avec l'option · son propre test, août 2026</div>
          <div class="masc" id="s5-m"><img id="s5-m-img" src="assets/img/m-s5-femme-sourire.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S6 · partage + signature -->
      <section id="s6" class="clip" {{S6}} data-track-index="6">
        <div class="cam" id="s6-cam"><div class="sec" id="s6-sec"><div class="kb" id="s6-kb">
          <div data-layout-allow-overlap class="sur" id="s6-sur">À partager avant mercredi<i class="sur-trait" id="s6-trait"></i></div>
          <div id="s6-dm">
            <div id="s6-dm-tete">À :<span id="s6-dest">qui gère tes pubs</span></div>
            <div id="s6-bulle"><div id="s6-mini"><b>30/10 ?</b><span>FAUX</span></div></div>
            <div id="s6-envoye">Envoyé ✓</div>
            <div id="s6-avion-zone"><svg id="s6-avion" viewBox="0 0 60 56"><path d="M2 26 L58 2 L44 54 L28 36 Z" fill="#fff"/><path d="M28 36 L58 2 L22 30 Z" fill="#e2d7f7"/></svg></div>
          </div>
          <img id="s6-logo" src="assets/img/logo-oddysee-noir-fin.svg" alt="Oddysee" />
          <div id="s6-badge">META BUSINESS PARTNER</div>
          <div id="s6-audit">Audit offert · réponse WhatsApp en moins d'1 h</div>
          <div class="masc" id="s6-m"><img id="s6-m-img" src="assets/img/m-s6-femme-victoire.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- entête et sous-titres, au-dessus des scènes -->
      <section id="entete" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="7">
        <img id="entete-logo-n" src="assets/img/logo-oddysee-noir.svg" alt="Oddysee" />
        <img id="entete-logo-b" src="assets/img/logo-oddysee-blanc.svg" alt="" />
        <div id="entete-pastille"><i id="entete-point"></i>MISE À JOUR META</div>
      </section>

      <section id="sous-titres" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="8">
        <div id="st-zone">{{SOUS_TITRES}}</div>
      </section>

      <section id="transitions" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="9">
        <div id="flash"></div>
        <div id="eclair"></div>
      </section>

{{AUDIO}}
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const D = {{DATA}};
      const C = D.c, S = D.scenes;
      const VIOLET = "#632bc5", ENCRE = "#1d1d1d";
      const tl = gsap.timeline({ paused: true });

      // ---------- outils ----------
      function pop(sel, t, o) {
        o = o || {};
        tl.fromTo(sel, { scale: o.de || 0.3, autoAlpha: 0, rotation: o.rot || 0 },
          { scale: 1, autoAlpha: 1, rotation: o.rotFin || 0, duration: o.d || 0.34, ease: o.ease || "back.out(2.4)" }, t);
      }
      function secousse(sel, t, a) {
        const p = [[a, -0.6 * a], [-0.8 * a, 0.5 * a], [0.5 * a, 0.4 * a], [-0.3 * a, -0.3 * a], [0.12 * a, 0.1 * a], [0, 0]];
        p.forEach((v, i) => tl.to(sel, { x: v[0], y: v[1], duration: 0.045, ease: "none" }, t + i * 0.045));
      }
      function flash(t) {
        tl.to("#flash", { opacity: 0.9, duration: 0.1, ease: "power2.out" }, t - 0.1);
        tl.to("#flash", { opacity: 0, duration: 0.32, ease: "power2.in" }, t);
      }
      function balance(sel, t0, t1) {
        // respiration de la mascotte, durée finie
        const cycle = 0.9, n = Math.max(0, Math.floor((t1 - t0) / cycle) - 1);
        tl.to(sel, { y: -12, rotation: 1.5, duration: cycle / 2, ease: "sine.inOut", yoyo: true, repeat: n * 2 + 1 }, t0);
      }
      function kenburns(sel, k) { tl.fromTo(sel, { scale: 1 }, { scale: 1.035, duration: S[k].fin - S[k].debut, ease: "none" }, S[k].debut); }
      function surTitre(k) {
        const s = "#s" + (k + 1);
        tl.fromTo(s + "-trait", { scaleX: 0 }, { scaleX: 1, duration: 0.4, ease: "power3.out" }, S[k].debut + 0.15);
      }

      // ---------- fond : la trame dérive en continu ----------
      tl.fromTo("#fond-points", { x: 0, y: 0 }, { x: -40, y: -120, duration: D.duree, ease: "none" }, 0);
      tl.fromTo("#entete-point", { scale: 1 }, { scale: 1.5, duration: 0.45, ease: "sine.inOut", yoyo: true,
        repeat: Math.max(0, Math.floor(D.duree / 0.45) - 1) }, 0);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, 0);

      // ---------- S1 · accroche : tout est déjà à l'image dès la 1re frame ----------
      kenburns("#s1-kb", 0);
      tl.fromTo("#s1-carte", { scale: 1.05, rotation: -5 }, { scale: 1, rotation: -3, duration: 0.55, ease: "power4.out" }, 0);
      tl.fromTo("#s1-m", { y: 60 }, { y: 0, duration: 0.45, ease: "back.out(2)" }, 0);
      balance("#s1-m-img", 0.5, C.faux);
      tl.fromTo("#s1-trait", { scaleX: 0.2 }, { scaleX: 1, duration: 0.45, ease: "power3.out" }, 0.05);
      tl.fromTo("#s1-faux", { scale: 2.6, autoAlpha: 0, rotation: 8 },
        { scale: 1, autoAlpha: 1, rotation: -12, duration: 0.2, ease: "power4.in" }, C.faux - 0.12);
      tl.fromTo("#s1-barre", { scaleX: 0 }, { scaleX: 1, duration: 0.22, ease: "power3.out" }, C.faux);
      tl.to("#s1-carte", { backgroundColor: "#3a3640", duration: 0.2 }, C.faux);
      tl.to("#eclair", { opacity: 0.75, duration: 0.05 }, C.faux + 0.06);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, C.faux + 0.11);
      secousse("#s1-sec", C.faux + 0.06, 26);
      tl.to("#s1-m", { scale: 1.08, duration: 0.12, ease: "power2.out", yoyo: true, repeat: 1 }, C.faux + 0.06);
      // sortie : balayage vers la gauche
      tl.to("#s1-cam", { x: -1150, duration: 0.36, ease: "power3.in" }, S[1].debut);

      // ---------- S2 · repoussé ----------
      tl.fromTo("#s2-cam", { x: 1150 }, { x: 0, duration: 0.42, ease: "power3.out" }, S[1].debut);
      flash(S[1].debut + 0.05);
      kenburns("#s2-kb", 1);
      surTitre(1);
      pop("#s2-m", C.vendredi + 0.05, { de: 0.4 });
      balance("#s2-m-img", C.vendredi + 0.4, S[1].fin);
      tl.fromTo("#s2-oct", { rotation: -4 }, { rotation: -7, duration: 0.5, ease: "sine.inOut" }, S[1].debut + 0.3);
      tl.fromTo("#s2-rature", { scaleX: 0 }, { scaleX: 1, duration: 0.25, ease: "power3.out" }, C.repousse - 0.1);
      tl.to("#s2-oct", { x: -980, y: -420, rotation: -32, duration: 0.42, ease: "power3.in" }, C.repousse + 0.2);
      tl.fromTo("#s2-nov", { scale: 0.86, rotation: 6 }, { scale: 1.02, rotation: 2, duration: 0.45, ease: "back.out(2)" }, C.repousse + 0.45);
      pop("#s2-tampon", C.vingtNov, { de: 2.2, rot: 18, rotFin: 12, ease: "power4.in", d: 0.2 });
      pop("#s2-src", C.vendredi + 0.35, { de: 0.6 });

      // ---------- S3 · mercredi 28 : la nuit tombe ----------
      tl.fromTo("#s3-nuit", { scaleY: 0 }, { scaleY: 1, duration: 0.3, ease: "power4.out" }, S[2].debut);
      tl.set("#entete-logo-n", { autoAlpha: 0 }, S[2].debut + 0.15);
      tl.set("#entete-logo-b", { autoAlpha: 1 }, S[2].debut + 0.15);
      tl.to("#s2-cam", { y: -300, scale: 0.9, duration: 0.3, ease: "power3.in" }, S[2].debut);
      secousse("#s3-sec", S[2].debut + 0.25, 16);
      surTitre(2);
      kenburns("#s3-kb", 2);
      pop("#s3-mercredi", C.mercredi - 0.05, { de: 0.6 });
      pop("#s3-28", C.vingtHuit - 0.06, { de: 2.2, ease: "power4.in", d: 0.2 });
      pop("#s3-octobre", C.vingtHuit + 0.12, { de: 0.6 });
      tl.fromTo("#s3-cadran", { scale: 0.7, autoAlpha: 0 }, { scale: 1, autoAlpha: 1, duration: 0.4, ease: "power3.out" }, C.mercredi);
      D.tics.forEach((t, i) => tl.to("#s3-aiguille", { rotation: (i + 1) * 30, duration: 0.08, ease: "back.out(3)" }, t));
      pop("#s3-m", C.vingtHuit + 0.2, { de: 0.4 });
      balance("#s3-m-img", C.vingtHuit + 0.6, S[2].fin);
      pop("#s3-bloque", C.bouge - 0.5, { de: 0.5 });
      tl.fromTo("#s3-anse", { y: -18 }, { y: 0, duration: 0.12, ease: "power4.in" }, C.bouge + 0.18);
      secousse("#s3-sec", C.bouge + 0.3, 10);
      // sortie : la nuit remonte
      tl.set("#s3-nuit", { transformOrigin: "50% 0%" }, S[3].debut);
      tl.to("#s3-nuit", { scaleY: 0, duration: 0.32, ease: "power4.in" }, S[3].debut);
      tl.to("#s3-cam", { y: -200, autoAlpha: 0, duration: 0.3, ease: "power3.in" }, S[3].debut);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, S[3].debut + 0.2);
      tl.set("#entete-logo-n", { autoAlpha: 1 }, S[3].debut + 0.2);

      // ---------- S4 · le clic ----------
      kenburns("#s4-kb", 3);
      surTitre(3);
      tl.fromTo("#s4-tel", { y: 900, rotation: 8 }, { y: 0, rotation: -2, duration: 0.5, ease: "power4.out" }, S[3].debut + 0.12);
      tl.fromTo("#s4-site", { x: 500, rotation: 0 }, { x: 0, rotation: 3, duration: 0.5, ease: "power4.out" }, S[3].debut + 0.24);
      pop("#s4-site-legende", S[3].debut + 0.4, { de: 0.6 });
      pop("#s4-reco", S[3].debut + 0.5, { de: 0.6 });
      tl.set("#s4-feuille", { yPercent: 100 }, S[3].debut);
      tl.fromTo("#s4-tap", { scale: 0.2, autoAlpha: 0 }, { scale: 1, autoAlpha: 1, duration: 0.14, ease: "power2.out" }, C.clic);
      tl.to("#s4-tap", { scale: 1.8, autoAlpha: 0, duration: 0.35, ease: "power2.out" }, C.clic + 0.16);
      tl.to("#s4-cta", { backgroundColor: "#4a1f99", duration: 0.08, yoyo: true, repeat: 1 }, C.clic);
      tl.to("#s4-feuille", { yPercent: 0, duration: 0.45, ease: "power4.out" }, C.ouvrir);
      tl.fromTo("#s4-tel", { scale: 1 }, { scale: 1.05, duration: 0.4, ease: "power2.out" }, C.ouvrir);
      pop("#s4-insta", C.instagram - 0.05, { de: 0.4, rot: -6, rotFin: -3 });
      pop("#s4-m", C.auLieu, { de: 0.4 });
      balance("#s4-m-img", C.auLieu + 0.4, S[3].fin);
      tl.to("#s4-site", { x: 60, rotation: 9, opacity: 0.45, duration: 0.3, ease: "power3.out" }, C.site - 0.05);
      tl.to("#s4-site-legende", { opacity: 0.4, duration: 0.3 }, C.site - 0.05);
      pop("#s4-croix", C.site, { de: 2.4, ease: "power4.in", d: 0.18 });
      secousse("#s4-sec", C.site + 0.16, 14);
      tl.to("#s4-cam", { y: -1920, duration: 0.4, ease: "power3.in" }, S[4].debut);

      // ---------- S5 · le réglage ----------
      tl.fromTo("#s5-cam", { y: 1920 }, { y: 0, duration: 0.45, ease: "power3.out" }, S[4].debut + 0.1);
      flash(S[4].debut + 0.25);
      kenburns("#s5-kb", 4);
      surTitre(4);
      ["#s5-p1", "#s5-f1", "#s5-p2", "#s5-f2", "#s5-p3"].forEach((s, i) =>
        pop(s, S[4].debut + 0.25 + i * 0.16, { de: 0.5, d: 0.24 }));
      tl.fromTo("#s5-reglage", { autoAlpha: 0, y: 40 }, { autoAlpha: 1, y: 0, duration: 0.3, ease: "power3.out" }, S[4].debut + 0.9);
      tl.fromTo("#s5-curseur", { x: 900, y: 1300, autoAlpha: 0 }, { x: 880, y: 1010, autoAlpha: 1, duration: 0.01 }, C.coupe - 0.55);
      tl.to("#s5-curseur", { x: 890, y: 726, duration: 0.45, ease: "power3.inOut" }, C.coupe - 0.5);
      tl.to("#s5-curseur", { scale: 0.85, duration: 0.07, yoyo: true, repeat: 1 }, C.coupe);
      tl.to("#s5-bouton", { x: -82, duration: 0.2, ease: "power3.out" }, C.coupe + 0.04);
      tl.to("#s5-inter", { backgroundColor: "#cfc8de", duration: 0.2 }, C.coupe + 0.04);
      pop("#s5-etat", C.coupe + 0.12, { de: 0.5 });
      tl.to("#s5-curseur", { autoAlpha: 0, duration: 0.2 }, C.coupe + 0.8);
      pop("#s5-m", S[4].debut + 0.3, { de: 0.4 });
      balance("#s5-m-img", S[4].debut + 0.7, S[4].fin);
      pop("#s5-a", C.teste - 0.05, { de: 0.4, rot: -8 });
      pop("#s5-b", C.teste + 0.15, { de: 0.4, rot: 8 });
      pop("#s5-vs", C.teste + 0.32, { de: 2, ease: "power4.in", d: 0.16 });
      pop("#s5-src", C.coupe + 0.6, { de: 0.6 });
      tl.to("#s5-cam", { scale: 1.4, autoAlpha: 0, duration: 0.32, ease: "power3.in" }, S[5].debut);

      // ---------- S6 · partage + signature ----------
      tl.fromTo("#s6-cam", { scale: 0.75, autoAlpha: 0 }, { scale: 1, autoAlpha: 1, duration: 0.4, ease: "power3.out" }, S[5].debut + 0.12);
      flash(S[5].debut + 0.2);
      kenburns("#s6-kb", 5);
      surTitre(5);
      tl.fromTo("#s6-dm", { y: 120, autoAlpha: 0 }, { y: 0, autoAlpha: 1, duration: 0.35, ease: "power3.out" }, S[5].debut);
      tl.fromTo("#s6-bulle", { x: -420, y: 190, scale: 0.3, autoAlpha: 0 },
        { x: 0, y: 0, scale: 1, autoAlpha: 1, duration: 0.42, ease: "power3.out" }, C.envoie + 0.1);
      tl.to("#s6-avion", { x: 60, y: -40, rotation: -10, duration: 0.18, ease: "power2.in", yoyo: true, repeat: 1 }, C.envoie + 0.05);
      pop("#s6-envoye", C.gere, { de: 0.5 });
      pop("#s6-m", S[5].debut + 0.2, { de: 0.4 });
      tl.to("#s6-m", { y: -60, duration: 0.22, ease: "power2.out", yoyo: true, repeat: 3 }, C.fin + 0.05);
      pop("#s6-logo", C.envoie + 0.7, { de: 0.5 });
      pop("#s6-badge", C.gere, { de: 0.4 });
      pop("#s6-audit", C.gere + 0.35, { de: 0.7 });
      tl.to("#s6-logo", { scale: 1.08, duration: 0.18, ease: "power2.out", yoyo: true, repeat: 1 }, C.fin);

      // ---------- sous-titres karaoké ----------
      D.sous.forEach((c, n) => {
        const id = "#st-" + n;
        tl.set(id, { autoAlpha: 1 }, c.debut);
        tl.fromTo(id, { scale: 0.82, y: 16 }, { scale: 1, y: 0, duration: 0.16, ease: "back.out(2.5)" }, c.debut);
        tl.set(id, { autoAlpha: 0 }, c.fin);
        c.mots.forEach((m) => {
          const w = "#m-" + m.i;
          tl.set(w, { color: m.base }, c.debut);
          tl.set(w, { backgroundColor: VIOLET, color: "#ffffff" }, m.debut);
          tl.set(w, { backgroundColor: "rgba(99, 43, 197, 0)", color: m.base }, m.fin);
          if (m.fort) tl.fromTo(w, { scale: 1 }, { scale: 1.08, duration: 0.1, ease: "power2.out", yoyo: true, repeat: 1 }, m.debut);
        });
      });

      window.__timelines["oddysee-meta"] = tl;
    </script>
  </body>
</html>
