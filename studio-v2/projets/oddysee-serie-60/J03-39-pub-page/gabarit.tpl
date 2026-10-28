<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Oddysee — Série 60 · 39 · Des clics… mais aucun contact</title>
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

      /* ---------- éléments « page » et « pub » (communs) ---------- */
      .navig { position: absolute; border-radius: 30px; background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); overflow: hidden; }
      .navig-barre { height: 64px; padding: 0 22px; display: flex; align-items: center; gap: 10px; background: #f1edf8; }
      .navig-barre i { display: block; width: 16px; height: 16px; border-radius: 50%; background: #c9c3d6; }
      .navig-barre span { margin-left: 14px; height: 40px; padding: 0 18px; border-radius: 20px; background: #fff; font-weight: 700;
        font-size: 28px; line-height: 40px; color: var(--gris); }
      .offre-visuel { display: flex; flex-direction: column; justify-content: center; padding: 0 30px; border-radius: 22px;
        background: linear-gradient(135deg, #8a5cff 0%, #632bc5 55%, #3d1a85 100%); color: #fff; }
      .offre-visuel b { display: block; font-weight: 900; font-size: 54px; line-height: 1; }
      .offre-visuel span { display: block; margin-top: 8px; font-weight: 800; font-size: 32px; }
      .fictif { display: inline-block; height: 46px; padding: 0 18px; border-radius: 23px; background: var(--or); color: var(--encre);
        font-weight: 900; font-size: 28px; line-height: 46px; letter-spacing: 2px; }

      /* ---------- S1 · des clics, aucun contact ; la pub promet ---------- */
      #s1-stats { position: absolute; left: 90px; top: 400px; width: 900px; height: 200px; padding: 26px 40px; border-radius: 36px;
        background: #fff; box-shadow: 0 30px 60px rgba(40, 10, 90, 0.22); }
      .st2 { position: absolute; top: 26px; }
      .st2 span { display: block; font-weight: 800; font-size: 30px; letter-spacing: 3px; color: var(--gris); }
      .st2 b { display: inline-block; margin-top: 4px; font-weight: 900; font-size: 104px; line-height: 1; transform-origin: left center; }
      #s1-c1 { left: 40px; }
      #s1-c1 b { color: var(--violet); }
      #s1-c2 { left: 480px; }
      #s1-c2 b { color: #d1452a; }
      #s1-pub { position: absolute; left: 90px; top: 640px; width: 580px; height: 400px; padding: 22px; border-radius: 30px; background: #fff;
        box-shadow: 0 30px 60px rgba(40, 10, 90, 0.25); }
      #s1-pub-tete { display: flex; align-items: center; gap: 14px; font-weight: 900; font-size: 30px; color: var(--encre); }
      #s1-pub-tete i { display: block; width: 52px; height: 52px; border-radius: 50%; background: var(--lilas); border: 4px solid var(--violet); }
      #s1-pub-tete small { font-weight: 700; font-size: 28px; color: var(--gris); }
      #s1-pub .offre-visuel { height: 200px; margin-top: 16px; }
      #s1-pub-cta { margin-top: 16px; height: 64px; padding: 0 22px; display: flex; align-items: center; justify-content: space-between;
        border-radius: 16px; background: #f1edf8; font-weight: 800; font-size: 30px; color: var(--encre); }
      #s1-pub .fictif { position: absolute; right: 22px; top: 24px; }
      #s1-m, #s1-m2 { right: 4px; top: 905px; }

      /* ---------- S2 · la page montre autre chose ; le visiteur s'en va ---------- */
      #s2-page { left: 90px; top: 420px; width: 600px; height: 560px; }
      #s2-contenu { padding: 30px; }
      #s2-contenu h3 { font-weight: 900; font-size: 56px; color: var(--encre); }
      .menu { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 18px; }
      .menu span { height: 50px; padding: 0 18px; border-radius: 25px; background: #f1edf8; font-weight: 700; font-size: 28px;
        line-height: 50px; color: var(--gris); }
      .trait { display: block; height: 18px; margin-top: 18px; border-radius: 9px; background: #ece8f3; }
      #s2-loupe { position: absolute; left: 150px; top: 640px; width: 130px; height: 130px; }
      #s2-introuvable { position: absolute; left: 150px; top: 900px; height: 70px; padding: 0 26px; border-radius: 35px; background: #d1452a;
        color: #fff; font-weight: 900; font-size: 32px; line-height: 70px; letter-spacing: 2px; }
      #s2-parti { position: absolute; left: 90px; top: 1020px; height: 84px; padding: 0 30px; display: flex; align-items: center; gap: 16px;
        border-radius: 28px; background: var(--encre); color: #fff; font-weight: 800; font-size: 36px; white-space: nowrap;
        box-shadow: 0 20px 40px rgba(40, 10, 90, 0.25); }
      #s2-parti i { display: block; width: 22px; height: 22px; border-radius: 50%; background: #d1452a; }
      #s2-m { right: -10px; top: 905px; }
      /* les étiquettes restent lisibles quand le visiteur passe devant */
      #s2-introuvable, #s2-parti { z-index: 2; }

      /* ---------- S3 · même offre, même image, même prix ---------- */
      #s3-nuit { position: absolute; inset: 0; transform-origin: 50% 100%;
        background: radial-gradient(circle at 50% 30%, #8a5cff 0%, #632bc5 45%, #2a1060 100%); }
      #s3-sur { color: #fff; }
      #s3-sur .sur-trait { background: var(--or); }
      .mini { position: absolute; top: 420px; width: 420px; height: 400px; padding: 22px; border-radius: 30px; background: #fff;
        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.35); }
      .mini > span { display: block; font-weight: 800; font-size: 28px; letter-spacing: 3px; color: var(--gris); }
      .mini .offre-visuel { height: 190px; margin-top: 14px; }
      .mini .offre-visuel b { font-size: 46px; }
      .mini .offre-visuel span { font-size: 28px; }
      .mini strong { display: block; margin-top: 14px; font-weight: 900; font-size: 54px; color: var(--encre); }
      #s3-pub { left: 90px; }
      #s3-page { left: 570px; }
      #s3-avant { position: absolute; left: 22px; right: 22px; top: 64px; bottom: 22px; padding-top: 18px; background: #fff; }
      #s3-avant h3 { font-weight: 900; font-size: 48px; color: var(--encre); }
      #s3-fil { position: absolute; left: 510px; top: 610px; width: 60px; height: 10px; border-radius: 5px; background: var(--or); }
      .accord { position: absolute; left: 400px; height: 84px; padding: 0 28px; display: flex; align-items: center; gap: 16px;
        border-radius: 26px; background: #fff; font-weight: 900; font-size: 38px; color: var(--violet); white-space: nowrap;
        box-shadow: 0 16px 34px rgba(0, 0, 0, 0.3); }
      .accord em { display: block; width: 50px; height: 50px; border-radius: 50%; background: var(--whatsapp); color: #fff; font-style: normal;
        font-size: 30px; line-height: 50px; text-align: center; }
      #s3-a1 { top: 870px; }
      #s3-a2 { top: 970px; }
      #s3-a3 { top: 1070px; }
      #s3-m { left: 0px; top: 905px; }
      /* corps violet sur fond violet : un liseré blanc garde la mascotte lisible */
      #s3-m img { filter: drop-shadow(0 0 3px rgba(255, 255, 255, 0.95)) drop-shadow(0 0 10px rgba(255, 255, 255, 0.55)); }

      /* ---------- S4 · un seul bouton ---------- */
      #s4-page { left: 60px; top: 420px; width: 640px; height: 640px; }
      #s4-contenu { padding: 26px 30px; }
      #s4-contenu .offre-visuel { height: 170px; }
      #s4-contenu strong { display: block; margin-top: 14px; font-weight: 900; font-size: 52px; color: var(--encre); }
      #s4-liens { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 14px; }
      #s4-liens span { height: 48px; padding: 0 16px; border-radius: 24px; background: #f1edf8; font-weight: 700; font-size: 28px;
        line-height: 48px; color: var(--gris); }
      #s4-wa { position: absolute; left: 30px; right: 30px; top: 400px; height: 110px; border-radius: 26px; background: var(--whatsapp);
        color: #fff; font-weight: 900; font-size: 42px; line-height: 110px; text-align: center; box-shadow: 0 16px 34px rgba(20, 110, 60, 0.35); }
      #s4-resa { position: absolute; left: 30px; right: 30px; top: 530px; height: 80px; border-radius: 22px; border: 4px solid var(--violet);
        color: var(--violet); font-weight: 900; font-size: 34px; line-height: 72px; text-align: center; }
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
    <div id="root" data-composition-id="oddysee-serie-60-39" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-pulse" class="plein"><div id="fond-points"></div></div>
        <div id="fond-vignette"></div>
      </section>

      <!-- S1 · des clics… mais aucun contact ? / ta pub promet une chose… -->
      <section id="s1" class="clip" {{S1}} data-track-index="1">
        <div class="cam" id="s1-cam"><div class="sec" id="s1-sec"><div class="kb" id="s1-kb">
          <div data-layout-allow-overlap class="sur" id="s1-sur">Ta pub<i class="sur-trait" id="s1-trait"></i></div>
          <div id="s1-stats" data-layout-allow-overlap>
            <div class="st2" id="s1-c1"><span>CLICS</span><b id="s1-n1">0</b></div>
            <div class="st2" id="s1-c2"><span>CONTACTS</span><b id="s1-n2">0</b></div>
          </div>
          <div id="s1-pub" data-layout-allow-overlap>
            <div id="s1-pub-tete"><i></i><div>Ta boutique<br /><small>Sponsorisé</small></div></div>
            <span class="fictif">EXEMPLE FICTIF</span>
            <div class="offre-visuel"><b>-30 %</b><span>sur le soin visage</span></div>
            <div id="s1-pub-cta"><span>En savoir plus</span><span>›</span></div>
          </div>
          <div class="masc" id="s1-m"><img id="s1-m-img" src="assets/img/m-s1a-moustache-blase.webp" alt="" /></div>
          <div class="masc" id="s1-m2"><img id="s1-m2-img" src="assets/img/m-s1b-barbu-colere.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S2 · ta page en montre une autre / il ne la retrouve pas… et s'en va -->
      <section id="s2" class="clip" {{S2}} data-track-index="2">
        <div class="cam" id="s2-cam"><div class="sec" id="s2-sec"><div class="kb" id="s2-kb">
          <div data-layout-allow-overlap class="sur" id="s2-sur">Ta page<i class="sur-trait" id="s2-trait"></i></div>
          <div class="navig" id="s2-page" data-layout-allow-overlap>
            <div class="navig-barre"><i></i><i></i><i></i><span>ta-boutique.ma</span></div>
            <div id="s2-contenu">
              <h3>Bienvenue !</h3>
              <div class="menu"><span>Accueil</span><span>À propos</span><span>Services</span><span>Contact</span></div>
              <i class="trait"></i><i class="trait" style="width: 80%"></i><i class="trait" style="width: 60%"></i>
              <i class="trait"></i><i class="trait" style="width: 70%"></i>
            </div>
          </div>
          <svg id="s2-loupe" viewBox="0 0 130 130" data-layout-allow-overlap><circle cx="54" cy="54" r="40" fill="rgba(255,255,255,0.35)" stroke="#632bc5" stroke-width="12"/><path d="M84 84 L120 120" stroke="#632bc5" stroke-width="16" stroke-linecap="round"/></svg>
          <div id="s2-introuvable" data-layout-allow-overlap>OFFRE INTROUVABLE</div>
          <div id="s2-parti" data-layout-allow-overlap><i></i>Le visiteur est parti</div>
          <div class="masc" id="s2-m"><img id="s2-m-img" src="assets/img/m-s2-collage-marche.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S3 · ta page doit répéter ta pub (partie B) -->
      <section id="s3" class="clip" {{S3}} data-track-index="3">
        <div id="s3-nuit"></div>
        <div class="cam" id="s3-cam"><div class="sec" id="s3-sec"><div class="kb" id="s3-kb">
          <div data-layout-allow-overlap class="sur" id="s3-sur">Le même message<i class="sur-trait" id="s3-trait"></i></div>
          <div class="mini" id="s3-pub" data-layout-allow-overlap><span>TA PUB</span><div class="offre-visuel"><b>-30 %</b><span>soin visage</span></div><strong>199 DH</strong></div>
          <i id="s3-fil"></i>
          <div class="mini" id="s3-page" data-layout-allow-overlap><span>TA PAGE</span><div class="offre-visuel"><b>-30 %</b><span>soin visage</span></div><strong>199 DH</strong>
            <div id="s3-avant"><h3>Bienvenue !</h3><i class="trait"></i><i class="trait" style="width: 70%"></i><i class="trait" style="width: 50%"></i></div>
          </div>
          <div class="accord" id="s3-a1" data-layout-allow-overlap><em>✓</em>Même offre</div>
          <div class="accord" id="s3-a2" data-layout-allow-overlap><em>✓</em>Même image</div>
          <div class="accord" id="s3-a3" data-layout-allow-overlap><em>✓</em>Même prix</div>
          <div class="masc" id="s3-m"><img id="s3-m-img" src="assets/img/m-s3-pochoir-femme-index.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S4 · un seul bouton, bien visible (passage calme) -->
      <section id="s4" class="clip" {{S4}} data-track-index="4">
        <div class="cam" id="s4-cam"><div class="sec" id="s4-sec"><div class="kb" id="s4-kb">
          <div data-layout-allow-overlap class="sur" id="s4-sur">Un seul bouton<i class="sur-trait" id="s4-trait"></i></div>
          <div class="navig" id="s4-page" data-layout-allow-overlap>
            <div class="navig-barre"><i></i><i></i><i></i><span>ta-boutique.ma</span></div>
            <div id="s4-contenu">
              <div class="offre-visuel"><b>-30 %</b><span>sur le soin visage</span></div>
              <strong>199 DH</strong>
              <div id="s4-liens"><span>Accueil</span><span>Blog</span><span>Instagram</span><span>Contact</span></div>
            </div>
            <div id="s4-wa">Écrire sur WhatsApp</div>
            <div id="s4-resa">ou réserver</div>
          </div>
          <div class="masc" id="s4-m"><img id="s4-m-img" src="assets/img/m-s4-pochoir-victoire.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S5 · commente « AUDIT » → on compare ta pub et ta page -->
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
            <div id="s5-carte-titre">Ta pub et ta page</div>
            <div id="s5-carte-sous">En message privé</div>
            <img id="s5-carte-logo" src="assets/img/logo-oddysee-blanc-guide.svg" alt="" />
          </div>
          <div class="masc" id="s5-m"><img id="s5-m-img" src="assets/img/m-s5-pochoir-cheveux-longs-rire.webp" alt="" /></div>
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
          <div class="masc" id="s6-m"><img id="s6-m-img" src="assets/img/m-s6-barbu-accueil.webp" alt="" /></div>
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

      // ---------- S1 · les clics montent, les contacts restent à zéro ; la pub sur la batterie ----------
      kenburns("#s1-kb", 0);
      tl.fromTo("#s1-stats", { scale: 1.05, rotation: -3 }, { scale: 1, rotation: -1.5, duration: 0.55, ease: "power4.out" }, 0);
      tl.fromTo("#s1-m", { y: 60 }, { y: 0, duration: 0.45, ease: "back.out(2)" }, 0);
      danse("#s1-m-img", 0.5, C.ta1);
      tl.fromTo("#s1-trait", { scaleX: 0.2 }, { scaleX: 1, duration: 0.45, ease: "power3.out" }, 0.05);
      tl.set("#s1-m2", { autoAlpha: 0 }, 0);
      const clics = { v: 0 };
      const ecrireClics = () => { document.getElementById("s1-n1").textContent = String(Math.round(clics.v)); };
      tl.fromTo(clics, { v: 0 }, { v: 240, duration: Math.max(0.6, C.contact - C.clics), ease: "power2.out", onUpdate: ecrireClics }, C.clics - 0.1);
      tl.fromTo("#s1-n2", { scale: 1 }, { scale: 1.25, duration: 0.12, ease: "power2.out", yoyo: true, repeat: 1 }, C.contact);
      secousse("#s1-c2", C.contact + 0.1, 10);
      // « Ta pub promet une chose… » sur l'entrée de la batterie
      tl.set("#s1-m", { autoAlpha: 0 }, C.ta1 - 0.02);
      tl.set("#s1-m2", { autoAlpha: 1 }, C.ta1 - 0.02);
      tl.fromTo("#s1-m2", { scale: 0.9 }, { scale: 1, duration: 0.3, ease: "back.out(2)" }, C.ta1 - 0.02);
      danse("#s1-m2-img", C.ta1 + 0.3, S[1].debut);
      tl.to("#eclair", { opacity: 0.5, duration: 0.05 }, C.ta1 + 0.02);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, C.ta1 + 0.07);
      secousse("#s1-sec", C.ta1 + 0.02, 18);
      tl.fromTo("#s1-pub", { y: 160, autoAlpha: 0, rotation: 4 }, { y: 0, autoAlpha: 1, rotation: 2, duration: 0.35, ease: "back.out(1.8)" }, C.ta1 - 0.05);
      tl.fromTo("#s1-pub .offre-visuel b", { scale: 1 }, { scale: 1.15, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1, transformOrigin: "0% 50%" }, C.promet);
      tl.to("#s1-cam", { x: -1150, duration: 0.3, ease: "power3.in" }, S[1].debut);

      // ---------- S2 · la page montre autre chose ; le visiteur s'en va ----------
      tl.fromTo("#s2-cam", { x: 1150 }, { x: 0, duration: 0.3, ease: "power3.out" }, S[1].debut);
      flash(S[1].temps, 0.7);
      kenburns("#s2-kb", 1);
      surTitre(1);
      pop("#s2-m", S[1].temps + 0.1, { de: 0.4 });
      danse("#s2-m-img", S[1].temps + 0.5, C.va);
      tl.fromTo("#s2-page", { y: 80, autoAlpha: 0 }, { y: 0, autoAlpha: 1, duration: 0.35, ease: "back.out(1.6)" }, C.page2 - 0.2);
      tl.fromTo("#s2-contenu h3", { scale: 1 }, { scale: 1.08, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1, transformOrigin: "0% 50%" }, C.autre);
      tl.fromTo("#s2-loupe", { autoAlpha: 0, x: 0, y: 0 }, { autoAlpha: 1, duration: 0.15 }, C.retrouve - 0.4);
      tl.to("#s2-loupe", { x: 300, y: -120, duration: 0.45, ease: "sine.inOut" }, C.retrouve - 0.25);
      tl.to("#s2-loupe", { x: 120, y: 60, duration: 0.45, ease: "sine.inOut" }, C.retrouve + 0.2);
      pop("#s2-introuvable", C.retrouve + 0.45, { de: 1.6, ease: "power4.out", d: 0.2 });
      // le visiteur (mascotte qui marche vers la gauche) quitte le cadre
      tl.to("#s2-m", { x: -1150, duration: 1.3, ease: "power1.in" }, C.va - 0.1);
      pop("#s2-parti", C.va + 0.4, { de: 0.6, rot: -3, rotFin: -1 });

      // ---------- S3 · partie B : la page répète la pub ----------
      tl.fromTo("#s3-nuit", { scaleY: 0 }, { scaleY: 1, duration: 0.28, ease: "power4.out" }, S[2].debut);
      tl.set("#entete-logo-n", { autoAlpha: 0 }, S[2].debut + 0.15);
      tl.set("#entete-logo-b", { autoAlpha: 1 }, S[2].debut + 0.15);
      tl.to("#s2-cam", { y: -300, scale: 0.9, duration: 0.28, ease: "power3.in" }, S[2].debut);
      flash(S[2].temps, 0.5);
      surTitre(2);
      kenburns("#s3-kb", 2);
      pop("#s3-pub", S[2].temps - 0.05, { de: 0.6 });
      pop("#s3-page", S[2].temps + 0.1, { de: 0.6 });
      tl.to("#s3-avant", { autoAlpha: 0, duration: 0.3 }, C.repeter);
      tl.fromTo("#s3-fil", { scaleX: 0 }, { scaleX: 1, duration: 0.25, ease: "power2.out" }, C.repeter);
      D.tics.forEach((b) => {
        tl.to("#s3-fil", { scaleY: 1.8, duration: 0.08, ease: "power2.out" }, b);
        tl.to("#s3-fil", { scaleY: 1, duration: 0.25, ease: "power2.in" }, b + 0.08);
      });
      pop("#s3-a1", C.offre - 0.15, { de: 0.5 });
      pop("#s3-a2", C.image - 0.15, { de: 0.5 });
      pop("#s3-a3", C.prix - 0.15, { de: 0.5 });
      pop("#s3-m", S[2].temps + 0.1, { de: 0.4 });
      danse("#s3-m-img", S[2].temps + 0.5, S[2].fin);
      tl.set("#s3-nuit", { transformOrigin: "50% 0%" }, S[3].debut);
      tl.to("#s3-nuit", { scaleY: 0, duration: 0.3, ease: "power4.in" }, S[3].debut);
      tl.to("#s3-cam", { y: -200, autoAlpha: 0, duration: 0.28, ease: "power3.in" }, S[3].debut);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, S[3].debut + 0.2);
      tl.set("#entete-logo-n", { autoAlpha: 1 }, S[3].debut + 0.2);

      // ---------- S4 · un seul bouton (passage calme) ----------
      tl.fromTo("#s4-cam", { y: 1920 }, { y: 0, duration: 0.4, ease: "power3.out" }, S[3].debut + 0.1);
      kenburns("#s4-kb", 3);
      surTitre(3);
      tl.set(["#s4-wa", "#s4-resa"], { autoAlpha: 0 }, 0);
      tl.to("#s4-liens span", { autoAlpha: 0, scale: 0.6, duration: 0.25, stagger: 0.06 }, C.seul - 0.1);
      tl.fromTo("#s4-wa", { autoAlpha: 0, scale: 0.6 }, { autoAlpha: 1, scale: 1, duration: 0.35, ease: "back.out(2.4)" }, C.bouton - 0.1);
      tl.fromTo("#s4-wa", { scale: 1 }, { scale: 1.06, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1 }, C.whatsapp);
      tl.fromTo("#s4-resa", { autoAlpha: 0, y: 20 }, { autoAlpha: 1, y: 0, duration: 0.25 }, C.reserver - 0.2);
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
      pop("#s6-badge", C.clics7 - 0.1, { de: 0.4 });
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

      window.__timelines["oddysee-serie-60-39"] = tl;
    </script>
  </body>
</html>
