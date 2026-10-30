<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Oddysee — Série 60 · 24 · Tu promets la qualité… ton concurrent aussi</title>
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
        --bleu-meta: #1877f2;
        --whatsapp: #1fa855;
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1080px; height: 1920px; overflow: hidden; background: var(--brume); }
      body { font-family: "Outfit", sans-serif; color: var(--encre); }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; }
      .clip { position: absolute; inset: 0; }
      .plein { position: absolute; inset: 0; }

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

      /* ---------- éléments communs ---------- */
      .cam, .sec, .kb { position: absolute; inset: 0; }
      .sur { position: absolute; left: 60px; right: 60px; top: 292px; text-align: center; font-weight: 900;
        font-size: 50px; letter-spacing: 2px; text-transform: uppercase; color: var(--encre); }
      .sur-trait { display: block; width: 180px; height: 10px; margin: 14px auto 0; border-radius: 6px;
        background: var(--violet); }
      .masc { position: absolute; width: 373px; height: 560px; }
      .masc img { display: block; width: 373px; height: 560px; }

      /* ---------- éléments communs ---------- */
      .carte-blanche { position: absolute; border-radius: 34px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }
      .fictif { display: inline-block; height: 46px; padding: 0 18px; border-radius: 23px; background: var(--or); color: var(--encre);
        font-weight: 900; font-size: 28px; line-height: 46px; letter-spacing: 2px; white-space: nowrap; }
      .tampon { position: absolute; height: 140px; padding: 0 40px; border: 8px solid var(--or); border-radius: 26px; background: #2a1060;
        color: #fff; font-weight: 900; font-size: 76px; line-height: 124px; letter-spacing: 4px; white-space: nowrap;
        box-shadow: 0 24px 50px rgba(0, 0, 0, 0.4); }

      /* ---------- S1 · même promesse que le concurrent ; le client compare le prix ---------- */
      .pubc { top: 410px; width: 450px; height: 470px; padding: 24px; border-radius: 30px; }
      .pubc > span { display: block; font-weight: 800; font-size: 28px; letter-spacing: 3px; color: var(--gris); }
      .pubc .slogan { margin-top: 16px; height: 230px; padding: 0 26px; display: flex; align-items: center; border-radius: 22px;
        background: linear-gradient(135deg, #8a5cff 0%, #632bc5 55%, #3d1a85 100%); color: #fff; font-weight: 900; font-size: 52px; line-height: 1.05; }
      .pubc .prix { position: absolute; left: 24px; bottom: 26px; font-weight: 900; font-size: 60px; color: var(--encre); transform-origin: left center; }
      #s1-a { left: 70px; }
      #s1-b { left: 560px; }
      #s1-b .slogan { background: linear-gradient(135deg, #5f6a7d 0%, #3c4556 60%, #232a36 100%); }
      #s1-remise { position: absolute; right: 24px; bottom: 30px; height: 60px; padding: 0 20px; border-radius: 30px; background: #d1452a;
        color: #fff; font-weight: 900; font-size: 34px; line-height: 60px; }
      #s1-vs { position: absolute; left: 470px; top: 560px; width: 110px; height: 110px; border-radius: 50%; background: var(--encre); color: #fff;
        font-weight: 900; font-size: 44px; line-height: 110px; text-align: center; box-shadow: 0 14px 30px rgba(40, 10, 90, 0.3); z-index: 2; }
      #s1-fictif { position: absolute; left: 70px; top: 905px; }
      #s1-m, #s1-m2 { right: 4px; top: 905px; }

      /* ---------- S2 · tout le monde le dit, personne ne le prouve ---------- */
      .mot-creux { position: absolute; height: 92px; padding: 0 34px; border-radius: 46px; background: #fff; color: var(--violet);
        font-weight: 900; font-size: 46px; line-height: 92px; white-space: nowrap; box-shadow: 0 16px 34px rgba(40, 10, 90, 0.18); }
      #s2-w1 { left: 80px; top: 420px; }
      #s2-w2 { left: 600px; top: 470px; }
      #s2-w3 { left: 120px; top: 560px; }
      #s2-w4 { left: 560px; top: 610px; }
      #s2-w5 { left: 70px; top: 700px; }
      #s2-w6 { left: 520px; top: 750px; }
      #s2-w7 { left: 160px; top: 840px; }
      #s2-w8 { left: 470px; top: 890px; }
      #s2-preuve { left: 90px; top: 1010px; width: 560px; height: 130px; padding: 0 30px; display: flex; align-items: center; gap: 24px; border-radius: 30px; }
      #s2-preuve span { font-weight: 900; font-size: 44px; letter-spacing: 2px; color: var(--encre); }
      #s2-preuve b { display: block; width: 150px; height: 84px; border: 5px dashed #d1452a; border-radius: 20px; color: #d1452a;
        font-weight: 900; font-size: 56px; line-height: 74px; text-align: center; }
      #s2-m { right: -10px; top: 905px; }
      #s2-preuve { z-index: 2; }

      /* ---------- S3 · une preuve : délai, méthode, résultat (partie B) ---------- */
      #s3-nuit { position: absolute; inset: 0; transform-origin: 50% 100%;
        background: radial-gradient(circle at 50% 30%, #8a5cff 0%, #632bc5 45%, #2a1060 100%); }
      #s3-sur { color: #fff; }
      #s3-sur .sur-trait { background: var(--or); }
      #s3-promesse { left: 90px; top: 410px; width: 900px; height: 116px; padding: 0 34px; display: flex; align-items: center; gap: 24px; border-radius: 30px; }
      #s3-promesse span { font-weight: 800; font-size: 28px; letter-spacing: 3px; color: var(--gris); }
      #s3-promesse b { position: relative; font-weight: 900; font-size: 50px; color: var(--encre); white-space: nowrap; }
      #s3-promesse b i { position: absolute; left: -8px; right: -8px; top: 30px; height: 10px; border-radius: 5px; background: #d1452a; transform-origin: left center; }
      #s3-tuiles { position: absolute; left: 90px; top: 570px; width: 900px; height: 320px; }
      .tuile { position: absolute; top: 0; width: 280px; height: 320px; padding: 26px 22px; border-radius: 30px; background: #fff; text-align: center;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3); }
      .tuile svg { display: block; width: 120px; height: 120px; margin: 0 auto; }
      .tuile b { display: block; margin-top: 18px; font-weight: 900; font-size: 40px; letter-spacing: 2px; color: var(--violet); }
      .tuile span { display: block; margin-top: 6px; font-weight: 800; font-size: 30px; color: var(--encre); white-space: nowrap; }
      #s3-t1 { left: 0; }
      #s3-t2 { left: 310px; }
      #s3-t3 { left: 620px; }
      #s3-ok { left: 470px; top: 1020px; }
      #s3-m { left: 0px; top: 905px; }
      #s3-m img { filter: drop-shadow(0 0 3px rgba(255, 255, 255, 0.95)) drop-shadow(0 0 10px rgba(255, 255, 255, 0.55)); }

      /* ---------- S4 · exemple : la pub réécrite (passage calme) ---------- */
      #s4-pub { left: 60px; top: 400px; width: 640px; height: 640px; padding: 26px 30px; }
      #s4-pub > span { display: block; font-weight: 800; font-size: 28px; letter-spacing: 3px; color: var(--gris); }
      #s4-pub .fictif { position: absolute; right: 26px; top: 20px; }
      #s4-vieux { position: absolute; left: 30px; top: 90px; font-weight: 900; font-size: 52px; color: var(--gris); white-space: nowrap; }
      #s4-vieux i { position: absolute; left: -8px; right: -8px; top: 32px; height: 10px; border-radius: 5px; background: #d1452a; transform-origin: left center; }
      #s4-titre { position: absolute; left: 30px; right: 30px; top: 80px; font-weight: 900; font-size: 50px; line-height: 1.08; color: var(--encre); }
      #s4-titre span { display: inline-block; }
      #s4-sous { position: absolute; left: 30px; top: 200px; font-weight: 900; font-size: 38px; color: var(--violet); white-space: nowrap; }
      #s4-jours { position: absolute; left: 30px; top: 272px; display: flex; gap: 12px; }
      #s4-jours div { width: 104px; height: 70px; border-radius: 16px; background: #f1edf8; color: var(--gris); font-weight: 900; font-size: 30px;
        line-height: 70px; text-align: center; }
      #s4-jours i { position: absolute; left: 0; top: 0; width: 104px; height: 70px; border-radius: 16px; background: var(--whatsapp); transform-origin: left center; }
      #s4-jours div { position: relative; overflow: hidden; }
      #s4-jours div span { position: relative; z-index: 1; }
      #s4-photos { position: absolute; left: 30px; top: 370px; display: flex; gap: 20px; }
      .photo { position: relative; width: 280px; height: 230px; border-radius: 20px; overflow: hidden; }
      .photo span { position: absolute; left: 14px; top: 14px; height: 46px; padding: 0 16px; border-radius: 23px; background: rgba(0, 0, 0, 0.6); color: #fff;
        font-weight: 900; font-size: 28px; line-height: 46px; letter-spacing: 2px; }
      #s4-p1 { background: repeating-linear-gradient(135deg, #b9b2c4 0px, #b9b2c4 22px, #a49cb1 22px, #a49cb1 44px); }
      #s4-p2 { background: linear-gradient(160deg, #f7f3ff 0%, #e2d7f7 45%, #a877ff 100%); }
      #s4-p2 em { position: absolute; right: 18px; bottom: 18px; width: 70px; height: 70px; border-radius: 50%; background: var(--whatsapp); color: #fff;
        font-style: normal; font-weight: 900; font-size: 42px; line-height: 70px; text-align: center; }
      #s4-m { right: -10px; top: 905px; }

      /* ---------- S5 · commente « AUDIT » ---------- */
      #s5-com { position: absolute; left: 60px; top: 392px; width: 960px; height: 500px; padding: 30px 40px;
        border-radius: 40px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }
      #s5-com-tete { font-weight: 900; font-size: 36px; color: var(--encre); }
      #s5-com-tete span { font-weight: 700; font-size: 28px; color: var(--gris); margin-left: 10px; }
      .com { display: flex; align-items: center; gap: 18px; margin-top: 22px; height: 60px; }
      .com i { display: block; width: 56px; height: 56px; border-radius: 50%; background: var(--lilas); flex: none; }
      .com .barres { flex: 1; }
      .com .barres div { height: 16px; border-radius: 8px; background: #ece8f3; }
      .com .barres div + div { margin-top: 10px; width: 60%; }
      #s5-nouveau { position: absolute; left: 40px; right: 40px; top: 250px; height: 92px; padding: 0 22px;
        display: flex; align-items: center; gap: 18px; border-radius: 24px; background: var(--brume);
        border: 3px solid var(--violet); }
      #s5-nouveau i { display: block; width: 60px; height: 60px; border-radius: 50%; background: var(--violet); flex: none; }
      #s5-nouveau b { font-weight: 800; font-size: 30px; color: var(--gris); }
      #s5-nouveau strong { font-weight: 900; font-size: 40px; color: var(--violet); letter-spacing: 2px; }
      #s5-coeur { margin-left: auto; font-weight: 900; font-size: 40px; color: var(--violet-vif); }
      #s5-saisie { position: absolute; left: 40px; right: 40px; bottom: 30px; height: 96px; padding: 0 16px 0 28px;
        display: flex; align-items: center; border-radius: 48px; background: #f1edf8; }
      #s5-place { position: absolute; left: 30px; font-weight: 600; font-size: 30px; color: #9a94a6; }
      #s5-texte { display: flex; font-weight: 900; font-size: 44px; letter-spacing: 3px; color: var(--encre); }
      #s5-texte span { display: block; }
      #s5-publier { position: absolute; right: 18px; top: 14px; height: 68px; padding: 0 28px; line-height: 68px;
        border-radius: 34px; background: var(--violet); color: #fff; font-weight: 800; font-size: 30px; }
      #s5-carte { position: absolute; left: 600px; top: 930px; width: 400px; height: 480px; padding: 30px;
        border-radius: 30px; color: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.4);
        background: linear-gradient(160deg, #6a3be8 0%, #4a1f99 60%, #2a1060 100%); }
      #s5-carte-tag { display: inline-block; height: 46px; padding: 0 18px; line-height: 46px; border-radius: 23px;
        background: var(--or); color: var(--encre); font-weight: 900; font-size: 28px; letter-spacing: 2px; }
      #s5-carte-titre { margin-top: 26px; font-weight: 900; font-size: 64px; line-height: 1.02; text-transform: uppercase; }
      #s5-carte-sous { margin-top: 14px; font-weight: 700; font-size: 28px; color: var(--lilas); }
      #s5-carte-logo { position: absolute; left: 30px; bottom: 30px; width: 200px; height: auto; }
      #s5-m { left: 0px; top: 900px; }

      /* ---------- S6 · abonne-toi + signature ---------- */
      #s6-profil { position: absolute; left: 60px; top: 392px; width: 960px; height: 420px; padding: 36px 40px;
        border-radius: 40px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }
      #s6-avatar { position: absolute; left: 40px; top: 36px; width: 150px; height: 150px; border-radius: 50%;
        border: 6px solid var(--violet); background: var(--brume); overflow: hidden; }
      #s6-avatar img { position: absolute; left: -23px; top: -36px; width: 560px; height: auto; }
      #s6-id { position: absolute; left: 220px; top: 52px; }
      #s6-id b { display: block; font-weight: 900; font-size: 44px; color: var(--encre); }
      #s6-id span { display: block; margin-top: 6px; font-weight: 700; font-size: 28px; color: var(--gris); }
      #s6-bouton { position: absolute; left: 40px; right: 40px; bottom: 40px; height: 110px; border-radius: 28px;
        background: var(--violet); }
      #s6-bouton b, #s6-bouton strong { position: absolute; left: 0; right: 0; top: 0; line-height: 110px;
        text-align: center; font-weight: 900; font-size: 46px; letter-spacing: 1px; }
      #s6-bouton b { color: #fff; }
      #s6-bouton strong { color: var(--violet); }
      #s6-curseur { position: absolute; left: 0; top: 0; width: 64px; height: 64px; }
      #s6-logo { position: absolute; left: 420px; top: 900px; width: 560px; height: auto; }
      #s6-badge { position: absolute; left: 470px; top: 1128px; height: 70px; padding: 0 28px; display: flex;
        align-items: center; border-radius: 35px; background: var(--or); color: var(--encre); font-weight: 900;
        font-size: 28px; letter-spacing: 2px; }
      #s6-rappel { position: absolute; left: 400px; top: 1222px; width: 640px; text-align: center; font-weight: 800;
        font-size: 32px; color: var(--violet); }
      #s6-m { left: 10px; top: 900px; }
      #calme { position: absolute; inset: 0; opacity: 0;
        background: radial-gradient(ellipse 70% 56% at 50% 44%, rgba(29, 16, 60, 0) 50%, rgba(29, 16, 60, 0.30) 100%); }

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
    <div id="root" data-composition-id="oddysee-serie-60-24" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-pulse" class="plein"><div id="fond-points"></div></div>
        <div id="fond-vignette"></div>
      </section>

      <!-- S1 · tu promets la qualité… ton concurrent aussi ? / alors le client compare… le prix -->
      <section id="s1" class="clip" {{S1}} data-track-index="1">
        <div class="cam" id="s1-cam"><div class="sec" id="s1-sec"><div class="kb" id="s1-kb">
          <div data-layout-allow-overlap class="sur" id="s1-sur">Ta pub<i class="sur-trait" id="s1-trait"></i></div>
          <div class="carte-blanche pubc" id="s1-a" data-layout-allow-overlap><span>TOI</span>
            <div class="slogan">Travail de qualité</div><b class="prix" id="s1-pa">3 000 DH</b></div>
          <div class="carte-blanche pubc" id="s1-b" data-layout-allow-overlap><span>TON CONCURRENT</span>
            <div class="slogan">Travail de qualité</div><b class="prix" id="s1-pb">2 700 DH</b><span id="s1-remise">−10 %</span></div>
          <div id="s1-vs" data-layout-allow-overlap>VS</div>
          <span class="fictif" id="s1-fictif">EXEMPLES FICTIFS</span>
          <div class="masc" id="s1-m"><img id="s1-m-img" src="assets/img/m-s1a-pochoir-colere.webp" alt="" /></div>
          <div class="masc" id="s1-m2"><img id="s1-m2-img" src="assets/img/m-s1b-pochoir-pensif.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S2 · qualité, sérieux, rapidité : tout le monde le dit / personne ne le prouve -->
      <section id="s2" class="clip" {{S2}} data-track-index="2">
        <div class="cam" id="s2-cam"><div class="sec" id="s2-sec"><div class="kb" id="s2-kb">
          <div data-layout-allow-overlap class="sur" id="s2-sur">Tout le monde le dit<i class="sur-trait" id="s2-trait"></i></div>
          <div class="mot-creux" id="s2-w1" data-layout-allow-overlap>Qualité</div>
          <div class="mot-creux" id="s2-w2" data-layout-allow-overlap>Qualité</div>
          <div class="mot-creux" id="s2-w3" data-layout-allow-overlap>Sérieux</div>
          <div class="mot-creux" id="s2-w4" data-layout-allow-overlap>Sérieux</div>
          <div class="mot-creux" id="s2-w5" data-layout-allow-overlap>Rapidité</div>
          <div class="mot-creux" id="s2-w6" data-layout-allow-overlap>Professionnel</div>
          <div class="mot-creux" id="s2-w7" data-layout-allow-overlap>Pas cher</div>
          <div class="mot-creux" id="s2-w8" data-layout-allow-overlap>N° 1</div>
          <div class="carte-blanche" id="s2-preuve" data-layout-allow-overlap><span>PREUVE</span><b>?</b></div>
          <div class="masc" id="s2-m"><img id="s2-m-img" src="assets/img/m-s2-femme-sceptique.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S3 · remplace la promesse par une preuve : un délai, une méthode, un résultat (partie B) -->
      <section id="s3" class="clip" {{S3}} data-track-index="3">
        <div id="s3-nuit"></div>
        <div class="cam" id="s3-cam"><div class="sec" id="s3-sec"><div class="kb" id="s3-kb">
          <div data-layout-allow-overlap class="sur" id="s3-sur">Une preuve<i class="sur-trait" id="s3-trait"></i></div>
          <div class="carte-blanche" id="s3-promesse" data-layout-allow-overlap><span>PROMESSE</span><b>Travail de qualité<i></i></b></div>
          <div id="s3-tuiles">
            <div class="tuile" id="s3-t1" data-layout-allow-overlap><svg viewBox="0 0 120 120"><circle cx="60" cy="60" r="48" fill="#f1edf8" stroke="#632bc5" stroke-width="10"/><path d="M60 32 V62 L80 74" fill="none" stroke="#632bc5" stroke-width="10" stroke-linecap="round"/></svg><b>DÉLAI</b><span>en 5 jours</span></div>
            <div class="tuile" id="s3-t2" data-layout-allow-overlap><svg viewBox="0 0 120 120"><circle cx="22" cy="60" r="16" fill="#632bc5"/><circle cx="60" cy="60" r="16" fill="#8a5cff"/><circle cx="98" cy="60" r="16" fill="#a877ff"/><path d="M38 60 H44 M76 60 H82" stroke="#632bc5" stroke-width="8" stroke-linecap="round"/></svg><b>MÉTHODE</b><span>3 étapes</span></div>
            <div class="tuile" id="s3-t3" data-layout-allow-overlap><svg viewBox="0 0 120 120"><rect x="8" y="20" width="50" height="80" rx="10" fill="#c9c3d6"/><rect x="62" y="20" width="50" height="80" rx="10" fill="#8a5cff"/><path d="M74 60 L84 70 L102 50" fill="none" stroke="#fff" stroke-width="8" stroke-linecap="round" stroke-linejoin="round"/></svg><b>RÉSULTAT</b><span>avant / après</span></div>
          </div>
          <div class="tampon" id="s3-ok" data-layout-allow-overlap>PROUVÉ ✓</div>
          <div class="masc" id="s3-m"><img id="s3-m-img" src="assets/img/m-s3-barbu-designe.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S4 · pas « travail de qualité » : « cuisine posée en cinq jours, photos à l'appui » (passage calme) -->
      <section id="s4" class="clip" {{S4}} data-track-index="4">
        <div class="cam" id="s4-cam"><div class="sec" id="s4-sec"><div class="kb" id="s4-kb">
          <div data-layout-allow-overlap class="sur" id="s4-sur">Exemple<i class="sur-trait" id="s4-trait"></i></div>
          <div class="carte-blanche" id="s4-pub" data-layout-allow-overlap><span>TA PUB</span><span class="fictif">EXEMPLE FICTIF</span>
            <div id="s4-vieux">Travail de qualité<i></i></div>
            <div id="s4-titre"><span id="s4-w1">Cuisine</span> <span id="s4-w2">posée</span> <span id="s4-w3">en 5 jours</span></div>
            <div id="s4-sous">Photos à l'appui</div>
            <div id="s4-jours"><div><i></i><span>J1</span></div><div><i></i><span>J2</span></div><div><i></i><span>J3</span></div><div><i></i><span>J4</span></div><div><i></i><span>J5</span></div></div>
            <div id="s4-photos"><div class="photo" id="s4-p1"><span>AVANT</span></div><div class="photo" id="s4-p2"><span>APRÈS</span><em>✓</em></div></div>
          </div>
          <div class="masc" id="s4-m"><img id="s4-m-img" src="assets/img/m-s4-moustache-fier.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S5 · commente « AUDIT » → on trouve ta preuve -->
      <section id="s5" class="clip" {{S5}} data-track-index="5">
        <div class="cam" id="s5-cam"><div class="sec" id="s5-sec"><div class="kb" id="s5-kb">
          <div data-layout-allow-overlap class="sur" id="s5-sur">Ton audit offert<i class="sur-trait" id="s5-trait"></i></div>
          <div id="s5-com" data-layout-allow-overlap>
            <div id="s5-com-tete">Commentaires<span>· sous cette vidéo</span></div>
            <div class="com"><i></i><div class="barres"><div></div><div></div></div></div>
            <div class="com"><i></i><div class="barres"><div></div><div></div></div></div>
            <div id="s5-nouveau"><i></i><b>toi</b><strong>AUDIT</strong><span id="s5-coeur">♥</span></div>
            <div id="s5-saisie">
              <span id="s5-place">Ajouter un commentaire…</span>
              <div id="s5-texte"><span id="s5-l1">A</span><span id="s5-l2">U</span><span id="s5-l3">D</span><span id="s5-l4">I</span><span id="s5-l5">T</span></div>
              <div id="s5-publier">Publier</div>
            </div>
          </div>
          <div id="s5-carte">
            <span id="s5-carte-tag">AUDIT OFFERT</span>
            <div id="s5-carte-titre">Ta preuve</div>
            <div id="s5-carte-sous">En message privé</div>
            <img id="s5-carte-logo" src="assets/img/logo-oddysee-blanc-guide.svg" alt="" />
          </div>
          <div class="masc" id="s5-m"><img id="s5-m-img" src="assets/img/m-s5-barbu-rire.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S6 · abonne-toi + signature -->
      <section id="s6" class="clip" {{S6}} data-track-index="6">
        <div class="cam" id="s6-cam"><div class="sec" id="s6-sec"><div class="kb" id="s6-kb">
          <div data-layout-allow-overlap class="sur" id="s6-sur">Abonne-toi<i class="sur-trait" id="s6-trait"></i></div>
          <div id="s6-profil" data-layout-allow-overlap>
            <div id="s6-avatar"><img src="assets/img/logo-oddysee-noir-profil.svg" alt="" /></div>
            <div id="s6-id"><b>@oddysee_maroc</b><span>Agence · Meta Business Partner</span></div>
            <div id="s6-bouton" data-layout-allow-overlap><b id="s6-suivre">S'abonner</b><strong id="s6-abonne">Abonné ✓</strong></div>
          </div>
          <svg id="s6-curseur" viewBox="0 0 64 64"><path d="M8 4 L8 52 L21 40 L30 60 L39 56 L30 36 L48 36 Z" fill="#1d1d1d" stroke="#fff" stroke-width="4" stroke-linejoin="round"/></svg>
          <img id="s6-logo" src="assets/img/logo-oddysee-noir-fin.svg" alt="Oddysee" />
          <div id="s6-badge">META BUSINESS PARTNER</div>
          <div id="s6-rappel">Commente « AUDIT » · audit offert</div>
          <div class="masc" id="s6-m"><img id="s6-m-img" src="assets/img/m-s6-pochoir-accueil.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- entête et sous-titres, au-dessus des scènes -->
      <section id="entete" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="10">
        <img id="entete-logo-n" src="assets/img/logo-oddysee-noir.svg" alt="Oddysee" />
        <img id="entete-logo-b" src="assets/img/logo-oddysee-blanc.svg" alt="" />
        <div id="entete-pastille"><i id="entete-point"></i>PLUS DE CLIENTS</div>
      </section>

      <section id="sous-titres" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="11">
        <div id="st-zone">{{SOUS_TITRES}}</div>
      </section>

      <section id="transitions" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="12">
        <div id="calme"></div>
        <div id="flash"></div>
        <div id="eclair"></div>
      </section>

{{AUDIO}}
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const D = {{DATA}};
      const C = D.c, S = D.scenes;
      const VIOLET = "#632bc5";
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
      function flash(t, force) {
        tl.to("#flash", { opacity: force || 0.9, duration: 0.1, ease: "power2.out" }, t - 0.1);
        tl.to("#flash", { opacity: 0, duration: 0.32, ease: "power2.in" }, t);
      }
      // la mascotte danse sur chaque temps de la musique ; balancement lent dans les passages calmes
      function danse(sel, t0, t1) {
        const temps = D.pulse.filter((b) => b >= t0 && b < t1 - 0.2);
        temps.forEach((b) => {
          tl.to(sel, { y: -16, duration: 0.12, ease: "power2.out" }, b);
          tl.to(sel, { y: 0, duration: 0.3, ease: "power2.in" }, b + 0.12);
        });
        D.calmes.forEach((z) => {
          const a = Math.max(t0, z[0]), f = Math.min(t1, z[1]);
          if (f - a > 1.2) {
            const n = Math.max(0, Math.floor((f - a) / 1.0) - 1);
            tl.to(sel, { y: -8, rotation: 1.5, duration: 0.5, ease: "sine.inOut", yoyo: true, repeat: n }, a);
          }
        });
      }
      function kenburns(sel, k) { tl.fromTo(sel, { scale: 1 }, { scale: 1.035, duration: S[k].fin - S[k].debut, ease: "none" }, S[k].debut); }
      function surTitre(k) {
        tl.fromTo("#s" + (k + 1) + "-trait", { scaleX: 0 }, { scaleX: 1, duration: 0.4, ease: "power3.out" }, S[k].debut + 0.15);
      }

      // ---------- au tempo : point de l'entête, trame du fond ----------
      tl.fromTo("#fond-points", { x: 0, y: 0 }, { x: -40, y: -120, duration: D.duree, ease: "none" }, 0);
      D.pulse.forEach((b) => {
        tl.to("#entete-point", { scale: 1.8, duration: 0.06, ease: "power2.out" }, b);
        tl.to("#entete-point", { scale: 1, duration: 0.3, ease: "power2.in" }, b + 0.06);
        tl.to("#fond-pulse", { scale: 1.014, duration: 0.06, ease: "power2.out" }, b);
        tl.to("#fond-pulse", { scale: 1, duration: 0.34, ease: "power2.in" }, b + 0.06);
      });
      D.calmes.forEach((z) => {
        tl.to("#calme", { opacity: 1, duration: 0.5, ease: "sine.inOut" }, z[0]);
        tl.to("#calme", { opacity: 0, duration: 0.15, ease: "power2.out" }, z[1] - 0.05);
      });
      tl.set("#entete-logo-b", { autoAlpha: 0 }, 0);
      // musique : baisse sous la voix (aperçu ; le mixage final est fait par outils/mixage.py)
      tl.set("#musique", { volume: D.musique[0].v }, 0);
      for (let i = 1; i < D.musique.length; i++) {
        const a = D.musique[i - 1], b = D.musique[i];
        if (a.v !== b.v) tl.to("#musique", { volume: b.v, duration: Math.max(0.05, b.t - a.t) }, a.t);
      }

      // ---------- S1 · ta pub et celle du concurrent disent la même chose ; le client compare le prix ----------
      kenburns("#s1-kb", 0);
      tl.fromTo("#s1-m", { y: 60 }, { y: 0, duration: 0.45, ease: "back.out(2)" }, 0);
      danse("#s1-m-img", 0.5, C.alors);
      tl.fromTo("#s1-trait", { scaleX: 0.2 }, { scaleX: 1, duration: 0.45, ease: "power3.out" }, 0.05);
      tl.set("#s1-m2", { autoAlpha: 0 }, 0);
      tl.fromTo("#s1-a", { y: 80, autoAlpha: 0, rotation: -4 }, { y: 0, autoAlpha: 1, rotation: -2, duration: 0.35, ease: "back.out(1.8)" }, C.promets - 0.15);
      tl.fromTo("#s1-a .slogan", { scale: 1 }, { scale: 1.06, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1 }, C.qualite0);
      tl.fromTo("#s1-b", { y: 80, autoAlpha: 0, rotation: 4 }, { y: 0, autoAlpha: 1, rotation: 2, duration: 0.35, ease: "back.out(1.8)" }, C.concurrent - 0.15);
      tl.fromTo([".pubc .slogan"], { scale: 1 }, { scale: 1.08, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1 }, C.aussi);
      pop("#s1-fictif", C.concurrent + 0.2, { de: 0.6 });
      // « Alors le client compare… le prix. » sur l'entrée de la batterie
      tl.set("#s1-m", { autoAlpha: 0 }, C.alors - 0.02);
      tl.set("#s1-m2", { autoAlpha: 1 }, C.alors - 0.02);
      tl.fromTo("#s1-m2", { scale: 0.9 }, { scale: 1, duration: 0.3, ease: "back.out(2)" }, C.alors - 0.02);
      danse("#s1-m2-img", C.alors + 0.3, S[1].debut);
      tl.to("#eclair", { opacity: 0.5, duration: 0.05 }, C.alors + 0.02);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, C.alors + 0.07);
      secousse("#s1-sec", C.alors + 0.02, 18);
      pop("#s1-vs", C.alors + 0.05, { de: 2, ease: "back.out(3)" });
      tl.to("#s1-a", { rotation: -6, y: 20, duration: 0.4, ease: "sine.inOut", yoyo: true, repeat: 1 }, C.compare);
      tl.to("#s1-b", { rotation: 6, y: -20, duration: 0.4, ease: "sine.inOut", yoyo: true, repeat: 1 }, C.compare);
      tl.to(".pubc .slogan", { opacity: 0.35, duration: 0.3 }, C.prix - 0.2);
      tl.to(".pubc .prix", { scale: 1.25, duration: 0.25, ease: "back.out(2.4)" }, C.prix - 0.05);
      pop("#s1-remise", C.prix + 0.1, { de: 1.8, ease: "power4.out", d: 0.2 });
      tl.to("#s1-cam", { x: -1150, duration: 0.3, ease: "power3.in" }, S[1].debut);

      // ---------- S2 · les mêmes mots partout ; aucune preuve ----------
      tl.fromTo("#s2-cam", { x: 1150 }, { x: 0, duration: 0.3, ease: "power3.out" }, S[1].debut);
      flash(S[1].temps, 0.7);
      kenburns("#s2-kb", 1);
      surTitre(1);
      pop("#s2-m", S[1].temps + 0.1, { de: 0.4 });
      danse("#s2-m-img", S[1].temps + 0.5, S[1].fin);
      [["#s2-w1", C.qualite2], ["#s2-w2", C.qualite2 + 0.2], ["#s2-w3", C.serieux], ["#s2-w4", C.serieux + 0.2],
       ["#s2-w5", C.rapidite], ["#s2-w6", C.rapidite + 0.25], ["#s2-w7", C.dit - 0.5], ["#s2-w8", C.dit - 0.25]].forEach(([s, t], i) =>
        pop(s, t - 0.05, { de: 0.3, rot: i % 2 ? 8 : -8, rotFin: i % 2 ? 2 : -2 }));
      tl.to(".mot-creux", { scale: 1.08, duration: 0.12, ease: "power2.out", yoyo: true, repeat: 1 }, C.dit);
      // « Personne ne le prouve. »
      tl.to(".mot-creux", { opacity: 0.3, duration: 0.3, stagger: 0.03 }, C.personne - 0.1);
      pop("#s2-preuve", C.personne, { de: 0.5 });
      secousse("#s2-preuve", C.prouve + 0.1, 12);

      // ---------- S3 · partie B : une preuve à la place de la promesse ----------
      tl.fromTo("#s3-nuit", { scaleY: 0 }, { scaleY: 1, duration: 0.28, ease: "power4.out" }, S[2].debut);
      tl.set("#entete-logo-n", { autoAlpha: 0 }, S[2].debut + 0.15);
      tl.set("#entete-logo-b", { autoAlpha: 1 }, S[2].debut + 0.15);
      tl.to("#s2-cam", { y: -300, scale: 0.9, duration: 0.28, ease: "power3.in" }, S[2].debut);
      flash(S[2].temps, 0.5);
      surTitre(2);
      kenburns("#s3-kb", 2);
      pop("#s3-promesse", S[2].temps - 0.05, { de: 0.6 });
      tl.fromTo("#s3-promesse b i", { scaleX: 0 }, { scaleX: 1, duration: 0.22, ease: "power3.out" }, C.promesse);
      tl.to("#s3-promesse b", { opacity: 0.45, duration: 0.3 }, C.promesse + 0.2);
      [["#s3-t1", C.delai], ["#s3-t2", C.methode], ["#s3-t3", C.resultat]].forEach(([s, t]) => {
        tl.fromTo(s, { y: 120, autoAlpha: 0, rotation: 6 }, { y: 0, autoAlpha: 1, rotation: 0, duration: 0.32, ease: "back.out(1.8)" }, t - 0.15);
        tl.fromTo(s + " svg", { scale: 0.4 }, { scale: 1, duration: 0.32, ease: "back.out(3)" }, t - 0.05);
      });
      D.tics.forEach((b) => {
        tl.to("#s3-tuiles", { scale: 1.02, duration: 0.08, ease: "power2.out" }, b);
        tl.to("#s3-tuiles", { scale: 1, duration: 0.25, ease: "power2.in" }, b + 0.08);
      });
      tl.fromTo("#s3-ok", { scale: 2.2, autoAlpha: 0, rotation: -16 }, { scale: 1, autoAlpha: 1, rotation: -6, duration: 0.22, ease: "power4.in" }, C.resultat + 0.15);
      secousse("#s3-sec", C.resultat + 0.37, 10);
      pop("#s3-m", S[2].temps + 0.1, { de: 0.4 });
      danse("#s3-m-img", S[2].temps + 0.5, S[2].fin);
      tl.set("#s3-nuit", { transformOrigin: "50% 0%" }, S[3].debut);
      tl.to("#s3-nuit", { scaleY: 0, duration: 0.3, ease: "power4.in" }, S[3].debut);
      tl.to("#s3-cam", { y: -200, autoAlpha: 0, duration: 0.28, ease: "power3.in" }, S[3].debut);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, S[3].debut + 0.2);
      tl.set("#entete-logo-n", { autoAlpha: 1 }, S[3].debut + 0.2);

      // ---------- S4 · exemple : la pub se réécrit (passage calme) ----------
      tl.fromTo("#s4-cam", { y: 1920 }, { y: 0, duration: 0.4, ease: "power3.out" }, S[3].debut + 0.1);
      kenburns("#s4-kb", 3);
      surTitre(3);
      tl.fromTo("#s4-vieux i", { scaleX: 0 }, { scaleX: 1, duration: 0.25, ease: "power3.out" }, C.travail);
      tl.to("#s4-vieux", { autoAlpha: 0, y: -20, duration: 0.25 }, C.cuisine - 0.25);
      [["#s4-w1", C.cuisine], ["#s4-w2", C.cuisine + 0.44], ["#s4-w3", C.cinq - 0.1]].forEach(([s, t]) =>
        tl.fromTo(s, { autoAlpha: 0, y: 24 }, { autoAlpha: 1, y: 0, duration: 0.2, ease: "power3.out" }, t - 0.05));
      tl.fromTo("#s4-jours i", { scaleX: 0 }, { scaleX: 1, duration: 0.14, ease: "power2.out", stagger: 0.12 }, C.cinq);
      tl.fromTo("#s4-jours span", { color: "#6f6a7a" }, { color: "#ffffff", duration: 0.1, stagger: 0.12 }, C.cinq + 0.08);
      tl.fromTo("#s4-sous", { autoAlpha: 0, x: -30 }, { autoAlpha: 1, x: 0, duration: 0.25, ease: "power3.out" }, C.photos - 0.1);
      tl.fromTo("#s4-p1", { autoAlpha: 0, y: 40 }, { autoAlpha: 1, y: 0, duration: 0.3, ease: "back.out(1.8)" }, C.photos);
      tl.fromTo("#s4-p2", { autoAlpha: 0, y: 40 }, { autoAlpha: 1, y: 0, duration: 0.3, ease: "back.out(1.8)" }, C.photos + 0.25);
      pop("#s4-p2 em", C.appui + 0.2, { de: 0.3 });
      pop("#s4-m", S[3].temps + 0.2, { de: 0.4 });
      danse("#s4-m-img", S[3].temps + 0.6, S[3].fin);
      tl.to("#s4-cam", { scale: 1.4, autoAlpha: 0, duration: 0.3, ease: "power3.in" }, S[4].debut);

      // ---------- S5 · retour de la musique : commente « AUDIT » ----------
      tl.fromTo("#s5-cam", { scale: 0.75, autoAlpha: 0 }, { scale: 1, autoAlpha: 1, duration: 0.25, ease: "power3.out" }, S[4].temps - 0.25);
      flash(S[4].temps, 0.75);
      tl.to("#eclair", { opacity: 0.25, duration: 0.05 }, S[4].temps);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, S[4].temps + 0.05);
      kenburns("#s5-kb", 4);
      surTitre(4);
      pop("#s5-m", S[4].temps + 0.05, { de: 0.4 });
      danse("#s5-m-img", S[4].temps + 0.4, S[4].fin);
      const lettres = ["#s5-l1", "#s5-l2", "#s5-l3", "#s5-l4", "#s5-l5"];
      lettres.forEach((s, i) => tl.fromTo(s, { autoAlpha: 0, y: 14, scale: 1.4 },
        { autoAlpha: 1, y: 0, scale: 1, duration: 0.12, ease: "back.out(3)" }, D.frappe[i]));
      tl.set("#s5-place", { autoAlpha: 0 }, D.frappe[0]);
      tl.to("#s5-publier", { scale: 0.9, duration: 0.07, yoyo: true, repeat: 1 }, D.publier);
      tl.set(lettres, { autoAlpha: 0 }, D.publier + 0.1);
      tl.set("#s5-place", { autoAlpha: 1 }, D.publier + 0.1);
      pop("#s5-nouveau", D.publier + 0.1, { de: 0.6 });
      pop("#s5-coeur", D.publier + 0.45, { de: 2, ease: "back.out(3)" });
      tl.fromTo("#s5-carte", { x: 520, rotation: 14, autoAlpha: 0 }, { x: 0, rotation: 4, autoAlpha: 1, duration: 0.45, ease: "back.out(1.6)" }, D.carte);
      tl.to("#s5-cam", { x: -1150, duration: 0.3, ease: "power3.in" }, S[5].debut);

      // ---------- S6 · abonne-toi + signature ----------
      tl.fromTo("#s6-cam", { x: 1150 }, { x: 0, duration: 0.3, ease: "power3.out" }, S[5].debut);
      flash(S[5].temps, 0.6);
      kenburns("#s6-kb", 5);
      surTitre(5);
      tl.set("#s6-abonne", { autoAlpha: 0 }, S[5].debut);
      pop("#s6-m", S[5].temps, { de: 0.4 });
      danse("#s6-m-img", S[5].temps + 0.4, D.duree);
      tl.fromTo("#s6-curseur", { x: 980, y: 1300, autoAlpha: 0 }, { x: 600, y: 760, autoAlpha: 1, duration: 0.4, ease: "power3.out" }, C.abonne - 0.45);
      tl.to("#s6-curseur", { scale: 0.85, duration: 0.07, yoyo: true, repeat: 1 }, C.abonne + 0.05);
      tl.to("#s6-bouton", { backgroundColor: "#e2d7f7", duration: 0.15 }, C.abonne + 0.08);
      tl.to("#s6-bouton", { scale: 0.96, duration: 0.08, yoyo: true, repeat: 1 }, C.abonne + 0.05);
      tl.set("#s6-suivre", { autoAlpha: 0 }, C.abonne + 0.1);
      pop("#s6-abonne", C.abonne + 0.1, { de: 0.7 });
      tl.to("#s6-curseur", { autoAlpha: 0, duration: 0.2 }, C.abonne + 0.7);
      pop("#s6-logo", C.abonne + 0.5, { de: 0.5 });
      pop("#s6-badge", C.promesses7 - 0.1, { de: 0.4 });
      pop("#s6-rappel", C.clients7 - 0.2, { de: 0.7 });
      tl.to("#s6-logo", { scale: 1.06, duration: 0.16, ease: "power2.out", yoyo: true, repeat: 1 }, C.fin + 0.05);

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

      window.__timelines["oddysee-serie-60-24"] = tl;
    </script>
  </body>
</html>
