<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Oddysee — Série 60 · 18 · Ta vidéo est belle… mais aucune vente</title>
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
      .fictif { display: inline-block; height: 46px; padding: 0 18px; border-radius: 23px; background: var(--or); color: var(--encre);
        font-weight: 900; font-size: 28px; line-height: 46px; letter-spacing: 2px; white-space: nowrap; }
      .carte-blanche { position: absolute; border-radius: 34px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }

      /* ---------- S1 · une belle vidéo, aucune vente ; ce n'est pas l'image ---------- */
      #s1-lecteur { left: 90px; top: 400px; width: 620px; height: 440px; border-radius: 30px; overflow: hidden; }
      #s1-ecran { position: absolute; left: 0; top: 0; width: 620px; height: 350px; overflow: hidden;
        background: linear-gradient(180deg, #ffcf9a 0%, #f08a5d 38%, #b83b7e 72%, #5a2a9c 100%); }
      #s1-soleil { position: absolute; left: 400px; top: 70px; width: 120px; height: 120px; border-radius: 50%; background: #ffe7b0;
        box-shadow: 0 0 60px rgba(255, 231, 176, 0.9); }
      #s1-colline1 { position: absolute; left: -80px; top: 230px; width: 520px; height: 260px; border-radius: 50%; background: #5a2a9c; }
      #s1-colline2 { position: absolute; left: 250px; top: 260px; width: 520px; height: 260px; border-radius: 50%; background: #2a1060; }
      #s1-lecture { position: absolute; left: 260px; top: 125px; width: 100px; height: 100px; border-radius: 50%; background: rgba(255, 255, 255, 0.92); }
      #s1-lecture i { position: absolute; left: 38px; top: 28px; width: 0; height: 0; border-left: 36px solid var(--violet);
        border-top: 22px solid transparent; border-bottom: 22px solid transparent; }
      #s1-hd { position: absolute; right: 20px; top: 20px; height: 46px; padding: 0 16px; border-radius: 12px; background: rgba(0, 0, 0, 0.55);
        color: #fff; font-weight: 900; font-size: 28px; line-height: 46px; }
      #s1-barre { position: absolute; left: 24px; right: 24px; top: 368px; height: 12px; border-radius: 6px; background: #ece8f3; }
      #s1-barre i { display: block; width: 62%; height: 12px; border-radius: 6px; background: var(--violet); }
      #s1-etoiles { position: absolute; left: 24px; top: 390px; font-weight: 900; font-size: 32px; letter-spacing: 4px; color: #a87418; white-space: nowrap; }
      #s1-etoiles span { margin-left: 12px; font-weight: 800; font-size: 28px; letter-spacing: 0; color: var(--gris); }
      #s1-ventes { left: 90px; top: 880px; width: 470px; height: 190px; padding: 26px 34px; }
      #s1-ventes span { display: block; font-weight: 800; font-size: 30px; letter-spacing: 3px; color: var(--gris); }
      #s1-ventes b { display: inline-block; margin-top: 4px; font-weight: 900; font-size: 104px; line-height: 1; color: #d1452a; transform-origin: left center; }
      #s1-tampon { position: absolute; left: 190px; top: 515px; height: 120px; padding: 0 34px; border: 8px solid var(--whatsapp); border-radius: 22px;
        background: rgba(255, 255, 255, 0.94); color: var(--whatsapp); font-weight: 900; font-size: 64px; line-height: 104px; letter-spacing: 4px;
        white-space: nowrap; box-shadow: 0 20px 40px rgba(20, 110, 60, 0.3); }
      #s1-m, #s1-m2 { right: 4px; top: 905px; }

      /* ---------- S2 · une offre que personne ne comprend ---------- */
      #s2-carte { left: 90px; top: 400px; width: 640px; height: 470px; padding: 30px 34px; }
      #s2-carte > span { display: block; font-weight: 800; font-size: 28px; letter-spacing: 3px; color: var(--gris); }
      #s2-carte .fictif { position: absolute; right: 26px; top: 22px; }
      #s2-flou { margin-top: 22px; font-weight: 800; font-size: 44px; line-height: 1.16; color: var(--encre); }
      #s2-achat { position: absolute; left: 34px; right: 34px; bottom: 30px; height: 96px; display: flex; align-items: center;
        justify-content: space-between; }
      #s2-prix { font-weight: 900; font-size: 48px; color: var(--encre); }
      #s2-acheter { height: 96px; padding: 0 44px; border-radius: 26px; background: #8f889c; color: #fff; font-weight: 900; font-size: 40px; line-height: 96px; }
      .qm { position: absolute; width: 96px; height: 96px; border-radius: 50%; background: var(--violet); color: #fff; font-weight: 900;
        font-size: 60px; line-height: 96px; text-align: center; box-shadow: 0 14px 30px rgba(40, 10, 90, 0.3); }
      #s2-q1 { left: 690px; top: 350px; }
      #s2-q2 { left: 40px; top: 820px; }
      #s2-q3 { left: 790px; top: 560px; }
      #s2-croix { position: absolute; left: 640px; top: 715px; width: 84px; height: 84px; border-radius: 50%; background: #d1452a; color: #fff;
        font-weight: 900; font-size: 48px; line-height: 84px; text-align: center; box-shadow: 0 12px 26px rgba(160, 40, 20, 0.35); }
      #s2-refus { position: absolute; left: 90px; top: 920px; height: 84px; padding: 0 30px; display: flex; align-items: center; gap: 16px;
        border-radius: 28px; background: var(--encre); color: #fff; font-weight: 800; font-size: 36px; white-space: nowrap;
        box-shadow: 0 20px 40px rgba(40, 10, 90, 0.25); }
      #s2-refus i { display: block; width: 22px; height: 22px; border-radius: 50%; background: #d1452a; }
      #s2-m { right: -10px; top: 905px; }
      #s2-croix, #s2-refus, .qm { z-index: 2; }

      /* ---------- S3 · ton offre en une phrase (partie B) ---------- */
      #s3-nuit { position: absolute; inset: 0; transform-origin: 50% 100%;
        background: radial-gradient(circle at 50% 30%, #8a5cff 0%, #632bc5 45%, #2a1060 100%); }
      #s3-sur { color: #fff; }
      #s3-sur .sur-trait { background: var(--or); }
      .case { position: absolute; left: 90px; width: 900px; height: 104px; padding: 0 26px 0 20px; display: flex; align-items: center; gap: 26px;
        border-radius: 28px; background: #fff; box-shadow: 0 16px 34px rgba(0, 0, 0, 0.3); white-space: nowrap; }
      .case em { display: block; width: 220px; height: 64px; border-radius: 32px; background: var(--violet); color: #fff; font-style: normal;
        font-weight: 900; font-size: 28px; line-height: 64px; letter-spacing: 2px; text-align: center; flex: none; }
      .case b { font-weight: 800; font-size: 42px; color: var(--encre); }
      #s3-c1 { top: 410px; }
      #s3-c2 { top: 530px; }
      #s3-c3 { top: 650px; }
      #s3-c4 { top: 770px; }
      #s3-jauge { position: absolute; left: 90px; top: 898px; width: 600px; height: 14px; border-radius: 7px; background: rgba(255, 255, 255, 0.25); }
      #s3-jauge i { display: block; width: 600px; height: 14px; border-radius: 7px; background: var(--or); transform-origin: left center; }
      #s3-fictif { position: absolute; left: 720px; top: 882px; }
      #s3-ok { position: absolute; left: 470px; top: 1040px; height: 140px; padding: 0 40px; border: 8px solid var(--or); border-radius: 26px;
        background: #2a1060; color: #fff; font-weight: 900; font-size: 76px; line-height: 124px; letter-spacing: 4px; white-space: nowrap;
        box-shadow: 0 24px 50px rgba(0, 0, 0, 0.4); }
      #s3-m { left: 0px; top: 905px; }
      /* corps violet sur fond violet : un liseré blanc garde la mascotte lisible */
      #s3-m img { filter: drop-shadow(0 0 3px rgba(255, 255, 255, 0.95)) drop-shadow(0 0 10px rgba(255, 255, 255, 0.55)); }

      /* ---------- S4 · le test du proche (passage calme) ---------- */
      #s4-chat { left: 60px; top: 400px; width: 650px; height: 600px; overflow: hidden; background: #efe9e1; }
      #s4-tete { height: 96px; padding: 0 26px; display: flex; align-items: center; gap: 18px; background: #075e54; color: #fff;
        font-weight: 800; font-size: 34px; }
      #s4-tete i { display: block; width: 60px; height: 60px; border-radius: 50%; background: #cfd8dc; }
      #s4-tete small { margin-left: auto; font-weight: 600; font-size: 28px; color: #c8ece6; }
      .bulle { position: absolute; width: 470px; padding: 18px 24px; border-radius: 24px; font-weight: 700; font-size: 32px; line-height: 1.22;
        color: var(--encre); box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08); }
      #s4-b1 { right: 22px; top: 120px; background: #d9fdd3; border-top-right-radius: 6px; }
      #s4-b2 { left: 22px; top: 336px; background: #fff; border-top-left-radius: 6px; }
      #s4-compris { position: absolute; right: 26px; top: 506px; height: 70px; padding: 0 26px; border-radius: 35px; background: var(--whatsapp);
        color: #fff; font-weight: 900; font-size: 34px; line-height: 70px; white-space: nowrap; }
      #s4-trop { left: 60px; top: 1040px; width: 650px; padding: 22px 28px 26px; border-radius: 28px; }
      #s4-trop > span { display: block; font-weight: 800; font-size: 28px; letter-spacing: 3px; color: var(--gris); }
      #s4-mots { display: flex; flex-wrap: wrap; gap: 12px 14px; margin-top: 14px; }
      #s4-mots b { position: relative; display: block; height: 56px; padding: 0 20px; border-radius: 28px; background: #f1edf8; font-weight: 800;
        font-size: 30px; line-height: 56px; color: var(--gris); white-space: nowrap; }
      #s4-mots b i { position: absolute; left: 12px; right: 12px; top: 26px; height: 5px; border-radius: 3px; background: #d1452a; transform-origin: left center; }
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
    <div id="root" data-composition-id="oddysee-serie-60-18" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-pulse" class="plein"><div id="fond-points"></div></div>
        <div id="fond-vignette"></div>
      </section>

      <!-- S1 · ta vidéo est belle… mais aucune vente ? / ce n'est pas l'image -->
      <section id="s1" class="clip" {{S1}} data-track-index="1">
        <div class="cam" id="s1-cam"><div class="sec" id="s1-sec"><div class="kb" id="s1-kb">
          <div data-layout-allow-overlap class="sur" id="s1-sur">Ta vidéo<i class="sur-trait" id="s1-trait"></i></div>
          <div class="carte-blanche" id="s1-lecteur" data-layout-allow-overlap>
            <div id="s1-ecran"><i id="s1-soleil"></i><i id="s1-colline1"></i><i id="s1-colline2"></i>
              <div id="s1-lecture"><i></i></div><span id="s1-hd">4K</span></div>
            <div id="s1-barre"><i></i></div>
            <div id="s1-etoiles">★★★★★<span>Superbe montage</span></div>
          </div>
          <div class="carte-blanche" id="s1-ventes" data-layout-allow-overlap><span>VENTES</span><b id="s1-n">0</b></div>
          <div id="s1-tampon" data-layout-allow-overlap>IMAGE ✓</div>
          <div class="masc" id="s1-m"><img id="s1-m-img" src="assets/img/m-s1a-moustache-angoisse.webp" alt="" /></div>
          <div class="masc" id="s1-m2"><img id="s1-m2-img" src="assets/img/m-s1b-pochoir-surpris.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S2 · c'est ton offre : personne ne la comprend / on n'achète pas ce qu'on ne comprend pas -->
      <section id="s2" class="clip" {{S2}} data-track-index="2">
        <div class="cam" id="s2-cam"><div class="sec" id="s2-sec"><div class="kb" id="s2-kb">
          <div data-layout-allow-overlap class="sur" id="s2-sur">Ton offre<i class="sur-trait" id="s2-trait"></i></div>
          <div class="carte-blanche" id="s2-carte" data-layout-allow-overlap>
            <span>TA BIO</span>
            <span class="fictif">EXEMPLE FICTIF</span>
            <div id="s2-flou">Solutions beauté innovantes et personnalisées pour sublimer votre potentiel</div>
            <div id="s2-achat"><span id="s2-prix">Prix : ?</span><span id="s2-acheter">Acheter</span></div>
          </div>
          <div class="qm" id="s2-q1" data-layout-allow-overlap>?</div>
          <div class="qm" id="s2-q2" data-layout-allow-overlap>?</div>
          <div class="qm" id="s2-q3" data-layout-allow-overlap>?</div>
          <div id="s2-croix" data-layout-allow-overlap>✕</div>
          <div id="s2-refus" data-layout-allow-overlap><i></i>Pas compris = pas acheté</div>
          <div class="masc" id="s2-m"><img id="s2-m-img" src="assets/img/m-s2-gomina-degout.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S3 · dis-la en une phrase : pour qui, quel résultat, quel délai, quel prix (partie B) -->
      <section id="s3" class="clip" {{S3}} data-track-index="3">
        <div id="s3-nuit"></div>
        <div class="cam" id="s3-cam"><div class="sec" id="s3-sec"><div class="kb" id="s3-kb">
          <div data-layout-allow-overlap class="sur" id="s3-sur">En une phrase<i class="sur-trait" id="s3-trait"></i></div>
          <div class="case" id="s3-c1" data-layout-allow-overlap><em>POUR QUI</em><b>les futures mariées</b></div>
          <div class="case" id="s3-c2" data-layout-allow-overlap><em>RÉSULTAT</em><b>un teint éclatant le jour J</b></div>
          <div class="case" id="s3-c3" data-layout-allow-overlap><em>DÉLAI</em><b>en 4 séances</b></div>
          <div class="case" id="s3-c4" data-layout-allow-overlap><em>PRIX</em><b>dès 1 200 DH</b></div>
          <div id="s3-jauge"><i></i></div>
          <span class="fictif" id="s3-fictif">EXEMPLE FICTIF</span>
          <div id="s3-ok" data-layout-allow-overlap>CLAIRE ✓</div>
          <div class="masc" id="s3-m"><img id="s3-m-img" src="assets/img/m-s3-pochoir-femme-designe.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S4 · teste-la : si un proche ne sait pas la répéter, simplifie (passage calme) -->
      <section id="s4" class="clip" {{S4}} data-track-index="4">
        <div class="cam" id="s4-cam"><div class="sec" id="s4-sec"><div class="kb" id="s4-kb">
          <div data-layout-allow-overlap class="sur" id="s4-sur">Le test du proche<i class="sur-trait" id="s4-trait"></i></div>
          <div class="carte-blanche" id="s4-chat" data-layout-allow-overlap>
            <div id="s4-tete"><i></i>Un proche<small id="s4-ecrit">écrit…</small></div>
            <div class="bulle" id="s4-b1">Pour les futures mariées : un teint éclatant le jour J, en 4 séances, dès 1 200 DH.</div>
            <div class="bulle" id="s4-b2">Donc tu aides les mariées à avoir un beau teint le jour J, c'est ça ?</div>
            <div id="s4-compris">Compris ✓</div>
          </div>
          <div class="carte-blanche" id="s4-trop" data-layout-allow-overlap><span>À SUPPRIMER</span>
            <div id="s4-mots"><b>innovantes<i></i></b><b>personnalisées<i></i></b><b>sublimer<i></i></b><b>votre potentiel<i></i></b></div></div>
          <div class="masc" id="s4-m"><img id="s4-m-img" src="assets/img/m-s4-pochoir-pensif.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S5 · commente « AUDIT » → on clarifie ton offre -->
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
            <div id="s5-carte-titre">Ton offre claire</div>
            <div id="s5-carte-sous">En message privé</div>
            <img id="s5-carte-logo" src="assets/img/logo-oddysee-blanc-guide.svg" alt="" />
          </div>
          <div class="masc" id="s5-m"><img id="s5-m-img" src="assets/img/m-s5-pochoir-cowboy-pouce.webp" alt="" /></div>
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
          <div class="masc" id="s6-m"><img id="s6-m-img" src="assets/img/m-s6-femme-rire-salut.webp" alt="" /></div>
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

      // ---------- S1 · une belle vidéo, zéro vente ; « Ce n'est pas l'image » sur la batterie ----------
      kenburns("#s1-kb", 0);
      tl.fromTo("#s1-lecteur", { scale: 1.06, rotation: -3 }, { scale: 1, rotation: -1.5, duration: 0.55, ease: "power4.out" }, 0);
      tl.fromTo("#s1-m", { y: 60 }, { y: 0, duration: 0.45, ease: "back.out(2)" }, 0);
      danse("#s1-m-img", 0.5, C.ce);
      tl.fromTo("#s1-trait", { scaleX: 0.2 }, { scaleX: 1, duration: 0.45, ease: "power3.out" }, 0.05);
      tl.set("#s1-m2", { autoAlpha: 0 }, 0);
      pop("#s1-lecture", C.video - 0.1, { de: 0.5 });
      tl.fromTo("#s1-soleil", { y: 50 }, { y: 0, duration: 1.4, ease: "power1.out" }, C.video - 0.1);
      tl.fromTo("#s1-barre i", { scaleX: 0 }, { scaleX: 1, duration: 1.6, ease: "none", transformOrigin: "0% 50%" }, C.video);
      pop("#s1-hd", C.belle - 0.1, { de: 1.6, ease: "power4.out", d: 0.2 });
      tl.fromTo("#s1-etoiles", { autoAlpha: 0, x: -30 }, { autoAlpha: 1, x: 0, duration: 0.3, ease: "power2.out" }, C.belle);
      pop("#s1-ventes", C.mais - 0.15, { de: 0.6 });
      tl.fromTo("#s1-n", { scale: 1 }, { scale: 1.25, duration: 0.12, ease: "power2.out", yoyo: true, repeat: 1 }, C.vente);
      secousse("#s1-ventes", C.vente + 0.1, 10);
      // « Ce n'est pas l'image. » sur l'entrée de la batterie
      tl.set("#s1-m", { autoAlpha: 0 }, C.ce - 0.02);
      tl.set("#s1-m2", { autoAlpha: 1 }, C.ce - 0.02);
      tl.fromTo("#s1-m2", { scale: 0.9 }, { scale: 1, duration: 0.3, ease: "back.out(2)" }, C.ce - 0.02);
      danse("#s1-m2-img", C.ce + 0.3, S[1].debut);
      tl.to("#eclair", { opacity: 0.5, duration: 0.05 }, C.ce + 0.02);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, C.ce + 0.07);
      secousse("#s1-sec", C.ce + 0.02, 18);
      tl.fromTo("#s1-tampon", { scale: 2.2, autoAlpha: 0, rotation: -18 }, { scale: 1, autoAlpha: 1, rotation: -8, duration: 0.22, ease: "power4.in" }, C.image - 0.22);
      secousse("#s1-lecteur", C.image, 8);
      tl.to("#s1-cam", { x: -1150, duration: 0.3, ease: "power3.in" }, S[1].debut);

      // ---------- S2 · une offre que personne ne comprend ----------
      tl.fromTo("#s2-cam", { x: 1150 }, { x: 0, duration: 0.3, ease: "power3.out" }, S[1].debut);
      flash(S[1].temps, 0.7);
      kenburns("#s2-kb", 1);
      surTitre(1);
      pop("#s2-m", S[1].temps + 0.1, { de: 0.4 });
      danse("#s2-m-img", S[1].temps + 0.5, S[1].fin);
      tl.fromTo("#s2-carte", { y: 80, autoAlpha: 0 }, { y: 0, autoAlpha: 1, duration: 0.35, ease: "back.out(1.6)" }, S[1].debut + 0.1);
      tl.fromTo("#s2-flou", { scale: 1 }, { scale: 1.04, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1, transformOrigin: "0% 50%" }, C.offre2);
      pop("#s2-q1", C.personne - 0.05, { de: 0.3, rot: -20 });
      pop("#s2-q2", C.personne + 0.15, { de: 0.3, rot: 20 });
      pop("#s2-q3", C.comprend2 - 0.05, { de: 0.3, rot: -10 });
      secousse("#s2-flou", C.comprend2, 8);
      ["#s2-q1", "#s2-q2", "#s2-q3"].forEach((q, i) =>
        tl.to(q, { y: -14, duration: 0.45, ease: "sine.inOut", yoyo: true, repeat: 3 }, C.comprend2 + 0.35 + i * 0.12));
      // « On n'achète pas ce qu'on ne comprend pas » : le bouton reste gris, croix rouge
      tl.fromTo("#s2-acheter", { scale: 1 }, { scale: 0.92, duration: 0.1, ease: "power2.out", yoyo: true, repeat: 1 }, C.nachete);
      pop("#s2-croix", C.pas3 - 0.05, { de: 1.8, ease: "power4.out", d: 0.2 });
      secousse("#s2-achat", C.pas3 + 0.12, 10);
      pop("#s2-refus", C.pas3 + 0.3, { de: 0.6, rot: -3, rotFin: -1 });

      // ---------- S3 · partie B : l'offre en une phrase, quatre cases ----------
      tl.fromTo("#s3-nuit", { scaleY: 0 }, { scaleY: 1, duration: 0.28, ease: "power4.out" }, S[2].debut);
      tl.set("#entete-logo-n", { autoAlpha: 0 }, S[2].debut + 0.15);
      tl.set("#entete-logo-b", { autoAlpha: 1 }, S[2].debut + 0.15);
      tl.to("#s2-cam", { y: -300, scale: 0.9, duration: 0.28, ease: "power3.in" }, S[2].debut);
      flash(S[2].temps, 0.5);
      surTitre(2);
      kenburns("#s3-kb", 2);
      ["#s3-c1", "#s3-c2", "#s3-c3", "#s3-c4"].forEach((s, i) =>
        tl.fromTo(s, { x: -140, autoAlpha: 0 }, { x: 0, autoAlpha: 1, duration: 0.3, ease: "back.out(1.8)" }, S[2].temps + 0.05 + i * 0.1));
      tl.fromTo("#s3-jauge", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.2 }, S[2].temps + 0.4);
      pop("#s3-fictif", S[2].temps + 0.45, { de: 0.6 });
      const cases = [["#s3-c1", C.pour], ["#s3-c2", C.resultat], ["#s3-c3", C.delai], ["#s3-c4", C.prix]];
      cases.forEach(([s, t], i) => {
        tl.fromTo(s + " b", { autoAlpha: 0, x: 30 }, { autoAlpha: 1, x: 0, duration: 0.22, ease: "power3.out" }, t - 0.05);
        tl.fromTo(s + " em", { scale: 1 }, { scale: 1.12, duration: 0.1, ease: "power2.out", yoyo: true, repeat: 1 }, t - 0.05);
        if (i === 0) tl.fromTo("#s3-jauge i", { scaleX: 0 }, { scaleX: 0.25, duration: 0.25, ease: "power3.out" }, t);
        else tl.to("#s3-jauge i", { scaleX: 0.25 * (i + 1), duration: 0.25, ease: "power3.out" }, t);
      });
      D.tics.forEach((b) => {
        tl.to("#s3-jauge", { scaleY: 1.8, duration: 0.08, ease: "power2.out" }, b);
        tl.to("#s3-jauge", { scaleY: 1, duration: 0.25, ease: "power2.in" }, b + 0.08);
      });
      tl.fromTo("#s3-ok", { scale: 2.2, autoAlpha: 0, rotation: -16 }, { scale: 1, autoAlpha: 1, rotation: -6, duration: 0.22, ease: "power4.in" }, C.prix + 0.12);
      secousse("#s3-sec", C.prix + 0.34, 10);
      pop("#s3-m", S[2].temps + 0.1, { de: 0.4 });
      danse("#s3-m-img", S[2].temps + 0.5, S[2].fin);
      tl.set("#s3-nuit", { transformOrigin: "50% 0%" }, S[3].debut);
      tl.to("#s3-nuit", { scaleY: 0, duration: 0.3, ease: "power4.in" }, S[3].debut);
      tl.to("#s3-cam", { y: -200, autoAlpha: 0, duration: 0.28, ease: "power3.in" }, S[3].debut);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, S[3].debut + 0.2);
      tl.set("#entete-logo-n", { autoAlpha: 1 }, S[3].debut + 0.2);

      // ---------- S4 · le test du proche (passage calme) ----------
      tl.fromTo("#s4-cam", { y: 1920 }, { y: 0, duration: 0.4, ease: "power3.out" }, S[3].debut + 0.1);
      kenburns("#s4-kb", 3);
      surTitre(3);
      tl.fromTo("#s4-b1", { autoAlpha: 0, y: 30, scale: 0.9 }, { autoAlpha: 1, y: 0, scale: 1, duration: 0.3, ease: "back.out(2)", transformOrigin: "100% 0%" }, C.teste - 0.1);
      tl.fromTo("#s4-ecrit", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.15 }, C.teste + 0.45);
      tl.to("#s4-ecrit", { autoAlpha: 0, duration: 0.15 }, C.proche + 0.1);
      tl.fromTo("#s4-b2", { autoAlpha: 0, y: 30, scale: 0.9 }, { autoAlpha: 1, y: 0, scale: 1, duration: 0.3, ease: "back.out(2)", transformOrigin: "0% 0%" }, C.proche + 0.15);
      pop("#s4-compris", C.repeter - 0.05, { de: 0.5 });
      pop("#s4-trop", C.simplifie - 0.4, { de: 0.8 });
      tl.fromTo("#s4-mots b i", { scaleX: 0 }, { scaleX: 1, duration: 0.18, ease: "power2.out", stagger: 0.12 }, C.simplifie);
      tl.to("#s4-mots b", { opacity: 0.35, duration: 0.3, stagger: 0.12 }, C.simplifie + 0.2);
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
      pop("#s6-badge", C.offre7 - 0.1, { de: 0.4 });
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

      window.__timelines["oddysee-serie-60-18"] = tl;
    </script>
  </body>
</html>
