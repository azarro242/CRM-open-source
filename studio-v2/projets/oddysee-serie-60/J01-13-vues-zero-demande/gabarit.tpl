<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Oddysee — Série 60 · 13 · Dix mille vues, zéro demande</title>
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
      .halo { position: absolute; left: 6px; top: -6px; width: 360px; height: 360px; border-radius: 50%;
        background: radial-gradient(circle, rgba(226, 215, 247, 0.95) 0%, rgba(226, 215, 247, 0) 70%); }
      .tag { position: absolute; height: 62px; padding: 0 26px; display: flex; align-items: center; border-radius: 31px;
        background: var(--or); color: var(--encre); font-weight: 900; font-size: 30px; letter-spacing: 3px;
        box-shadow: 0 14px 30px rgba(40, 10, 90, 0.25); white-space: nowrap; }
      .goutte { position: absolute; width: 44px; height: 60px; }

      /* ---------- S1 · dix mille vues, zéro demande ---------- */
      #s1-carte { position: absolute; left: 90px; top: 410px; width: 900px; height: 500px; padding: 40px 56px;
        border-radius: 44px; background: var(--encre); box-shadow: 0 34px 70px rgba(40, 10, 90, 0.35); }
      .s1-ligne { position: relative; height: 200px; }
      .s1-label { font-weight: 700; font-size: 30px; letter-spacing: 5px; color: var(--lilas); text-transform: uppercase; }
      .s1-nombre { display: block; font-weight: 900; font-size: 168px; line-height: 1; letter-spacing: -4px;
        font-variant-numeric: tabular-nums; }
      #s1-vues { color: var(--violet-pale); }
      #s1-zero { color: #fff; }
      #s1-zero-ligne { margin-top: 20px; }
      #s1-fuite { position: absolute; left: 230px; top: 640px; width: 620px; height: 250px; display: flex;
        flex-direction: column; align-items: center; justify-content: center; border-radius: 30px; border: 10px solid #fff;
        background: var(--violet-vif); color: #fff; font-weight: 900; font-size: 88px; line-height: 0.98; letter-spacing: 3px;
        text-align: center; box-shadow: 0 24px 50px rgba(40, 10, 90, 0.45); }
      #s1-goutte { left: 600px; top: 910px; }
      #s1-m { right: 4px; top: 905px; }

      /* ---------- S2 · l'entonnoir (exemple fictif) ---------- */
      #s2-fictif { left: 340px; top: 392px; }
      .etage { position: absolute; height: 190px; padding: 0 40px; display: flex; align-items: center; gap: 26px;
        border-radius: 34px; color: #fff; box-shadow: 0 26px 50px rgba(40, 10, 90, 0.28); }
      .etage b { font-weight: 900; font-size: 116px; line-height: 1; letter-spacing: -3px; font-variant-numeric: tabular-nums; }
      .etage span { font-weight: 800; font-size: 40px; letter-spacing: 3px; }
      .fantome { position: absolute; height: 190px; border: 5px dashed var(--violet-pale); border-radius: 34px; }
      #s2-f1 { left: 40px; top: 480px; width: 860px; }
      #s2-f2 { left: 150px; top: 710px; width: 640px; }
      #s2-f3 { left: 220px; top: 940px; width: 500px; }
      #s2-e1 { left: 40px; top: 480px; width: 860px; background: var(--violet); }
      #s2-e2 { left: 150px; top: 710px; width: 640px; background: var(--violet-vif); }
      #s2-e3 { left: 220px; top: 940px; width: 500px; background: var(--encre); }
      .perte { position: absolute; font-weight: 800; font-size: 30px; letter-spacing: 1px; color: var(--gris); white-space: nowrap; }
      #s2-p1 { left: 820px; top: 690px; }
      #s2-p2 { left: 720px; top: 920px; }
      #s2-g1 { left: 870px; top: 680px; }
      #s2-g2 { left: 770px; top: 910px; }
      #s2-m { right: -10px; top: 905px; }

      /* ---------- S3 · la nuit : personne ne rappelle ---------- */
      #s3-nuit { position: absolute; inset: 0; transform-origin: 50% 100%;
        background: radial-gradient(circle at 50% 40%, #44198f 0%, #241048 46%, #141019 100%); }
      #s3-sur { color: #fff; }
      #s3-sur .sur-trait { background: var(--or); }
      #s3-tel { position: absolute; left: 70px; top: 410px; width: 470px; height: 820px; padding: 18px;
        border-radius: 64px; background: #0d0a14; box-shadow: 0 34px 70px rgba(0, 0, 0, 0.45);
        border: 3px solid rgba(226, 215, 247, 0.25); }
      #s3-ecran { position: relative; width: 428px; height: 778px; border-radius: 48px; overflow: hidden;
        background: linear-gradient(180deg, #2b1a55 0%, #170f2c 100%); }
      #s3-heure { position: absolute; left: 0; right: 0; top: 70px; text-align: center; font-weight: 700; font-size: 110px;
        letter-spacing: -2px; color: #fff; }
      #s3-date { position: absolute; left: 0; right: 0; top: 190px; text-align: center; font-weight: 600; font-size: 30px;
        color: var(--lilas); }
      .notif { position: absolute; left: 20px; right: 20px; height: 150px; padding: 22px 24px; border-radius: 30px;
        background: rgba(255, 255, 255, 0.94); }
      .notif i { position: absolute; left: 22px; top: 24px; width: 56px; height: 56px; border-radius: 16px; background: var(--violet); }
      .notif b { display: block; margin-left: 74px; font-weight: 800; font-size: 30px; color: var(--encre); }
      .notif span { display: block; margin-left: 74px; margin-top: 6px; font-weight: 600; font-size: 28px; color: var(--gris); }
      #s3-n1 { top: 300px; }
      #s3-n2 { top: 470px; }
      #s3-sans { position: absolute; left: 30px; right: 30px; top: 646px; height: 80px; border-radius: 22px;
        background: var(--or); color: var(--encre); text-align: center; line-height: 80px; font-weight: 900; font-size: 36px;
        letter-spacing: 2px; }
      #s3-cadran { position: absolute; left: 600px; top: 440px; width: 400px; height: 400px; }
      #s3-ticks { position: absolute; inset: 0; }
      .tick { position: absolute; left: 194px; top: 0; width: 12px; height: 36px; border-radius: 6px;
        background: rgba(226, 215, 247, 0.55); transform-origin: 6px 200px; }
      #s3-aiguille { position: absolute; left: 193px; top: 30px; width: 14px; height: 170px; border-radius: 7px;
        background: var(--or); transform-origin: 7px 170px; }
      #s3-centre { position: absolute; left: 182px; top: 182px; width: 36px; height: 36px; border-radius: 50%; background: #fff; }
      #s3-aucun { position: absolute; left: 600px; top: 870px; width: 400px; height: 96px; border-radius: 26px;
        background: #fff; color: var(--encre); text-align: center; line-height: 96px; font-weight: 900; font-size: 40px;
        letter-spacing: 1px; box-shadow: 0 20px 40px rgba(0, 0, 0, 0.35); }
      #s3-m { right: 10px; top: 960px; }

      /* ---------- S4 · avant de changer ta pub ---------- */
      .ligne-cl { position: absolute; left: 60px; width: 640px; height: 170px; padding: 0 30px 0 140px; border-radius: 34px;
        background: #fff; box-shadow: 0 24px 50px rgba(40, 10, 90, 0.18); }
      .ligne-cl b { display: block; padding-top: 30px; font-weight: 900; font-size: 54px; line-height: 1.05; color: var(--encre); }
      .ligne-cl span { display: block; margin-top: 8px; font-weight: 600; font-size: 28px; color: var(--gris); }
      .case { position: absolute; left: 34px; top: 40px; width: 86px; height: 86px; border-radius: 22px;
        border: 6px solid var(--violet); background: #fff; }
      .coche { position: absolute; left: 0; top: 0; width: 74px; height: 74px; font-style: normal; font-weight: 900; font-size: 64px;
        line-height: 74px; text-align: center; color: #fff; }
      #s4-pub { top: 420px; background: #efeaf8; box-shadow: none; }
      #s4-pub b { color: var(--gris); }
      #s4-pub .case { border-color: #cfc8de; }
      #s4-rature { position: absolute; left: 130px; top: 76px; width: 330px; height: 14px; border-radius: 7px;
        background: var(--gris); transform-origin: left center; }
      #s4-page { top: 630px; }
      #s4-suivi { top: 840px; }
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
    <div id="root" data-composition-id="oddysee-serie-60-13" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-pulse" class="plein"><div id="fond-points"></div></div>
        <div id="fond-vignette"></div>
      </section>

      <!-- S1 · dix mille vues… et zéro demande ? / cherche la fuite -->
      <section id="s1" class="clip" {{S1}} data-track-index="1">
        <div class="cam" id="s1-cam"><div class="sec" id="s1-sec"><div class="kb" id="s1-kb">
          <div data-layout-allow-overlap class="sur" id="s1-sur">Ta pub ce mois-ci<i class="sur-trait" id="s1-trait"></i></div>
          <div id="s1-carte" data-layout-allow-overlap>
            <div class="s1-ligne"><div class="s1-label">Vues</div><b class="s1-nombre" id="s1-vues">0</b></div>
            <div class="s1-ligne" id="s1-zero-ligne"><div class="s1-label">Demandes</div><b class="s1-nombre" id="s1-zero">0</b></div>
          </div>
          <div class="masc" id="s1-m"><img id="s1-m-img" src="assets/img/m-s1-moustache-perplexe.webp" alt="" /></div>
          <svg class="goutte" id="s1-goutte" viewBox="0 0 44 60"><path d="M22 2 C22 2 4 26 4 38 a18 18 0 0 0 36 0 C40 26 22 2 22 2 Z" fill="#a877ff" stroke="#fff" stroke-width="3"/></svg>
          <div id="s1-fuite" data-layout-allow-overlap><span>CHERCHE</span><span>LA FUITE</span></div>
        </div></div></div>
      </section>

      <!-- S2 · l'entonnoir : 10 000 vues → 100 clics → 2 formulaires (exemple fictif) -->
      <section id="s2" class="clip" {{S2}} data-track-index="2">
        <div class="cam" id="s2-cam"><div class="sec" id="s2-sec"><div class="kb" id="s2-kb">
          <div data-layout-allow-overlap class="sur" id="s2-sur">Où ça fuit<i class="sur-trait" id="s2-trait"></i></div>
          <div class="tag" id="s2-fictif" data-layout-allow-overlap>EXEMPLE FICTIF</div>
          <i class="fantome" id="s2-f1"></i><i class="fantome" id="s2-f2"></i><i class="fantome" id="s2-f3"></i>
          <div class="etage" id="s2-e1" data-layout-allow-overlap><b>10&nbsp;000</b><span>VUES</span></div>
          <div class="etage" id="s2-e2" data-layout-allow-overlap><b>100</b><span>CLICS</span></div>
          <div class="etage" id="s2-e3" data-layout-allow-overlap><b>2</b><span>FORMULAIRES</span></div>
          <svg class="goutte" id="s2-g1" viewBox="0 0 44 60"><path d="M22 2 C22 2 4 26 4 38 a18 18 0 0 0 36 0 C40 26 22 2 22 2 Z" fill="#a877ff"/></svg>
          <svg class="goutte" id="s2-g2" viewBox="0 0 44 60"><path d="M22 2 C22 2 4 26 4 38 a18 18 0 0 0 36 0 C40 26 22 2 22 2 Z" fill="#a877ff"/></svg>
          <div class="masc" id="s2-m"><img id="s2-m-img" src="assets/img/m-s2-femme-sceptique.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S3 · la nuit : personne ne les a rappelées -->
      <section id="s3" class="clip" {{S3}} data-track-index="3">
        <div id="s3-nuit"></div>
        <div class="cam" id="s3-cam"><div class="sec" id="s3-sec"><div class="kb" id="s3-kb">
          <div data-layout-allow-overlap class="sur" id="s3-sur">Les 2 demandes<i class="sur-trait" id="s3-trait"></i></div>
          <div id="s3-tel"><div id="s3-ecran" data-layout-allow-overlap data-layout-allow-occlusion>
            <div id="s3-heure">21:47</div>
            <div id="s3-date">mardi</div>
            <div class="notif" id="s3-n1"><i></i><b>Nouvelle demande</b><span>Formulaire · ta pub</span></div>
            <div class="notif" id="s3-n2"><i></i><b>Nouvelle demande</b><span>Formulaire · ta pub</span></div>
            <div id="s3-sans">SANS RÉPONSE</div>
          </div></div>
          <div id="s3-cadran">
            <div id="s3-ticks">{{TICKS}}</div>
            <i id="s3-aiguille"></i><i id="s3-centre"></i>
          </div>
          <div id="s3-aucun">0 RAPPEL</div>
          <div class="masc" id="s3-m"><i class="halo"></i><img id="s3-m-img" src="assets/img/m-s3-moustache-colere.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S4 · avant de changer ta pub, regarde ta page… et ton suivi (passage calme) -->
      <section id="s4" class="clip" {{S4}} data-track-index="4">
        <div class="cam" id="s4-cam"><div class="sec" id="s4-sec"><div class="kb" id="s4-kb">
          <div data-layout-allow-overlap class="sur" id="s4-sur">Avant de toucher à ta pub<i class="sur-trait" id="s4-trait"></i></div>
          <div class="ligne-cl" id="s4-pub" data-layout-allow-overlap data-layout-allow-occlusion><i class="case"></i><b data-layout-allow-occlusion>Changer la pub</b><span>Pas en premier</span><i id="s4-rature" data-layout-allow-occlusion></i></div>
          <div class="ligne-cl" id="s4-page" data-layout-allow-overlap><i class="case"><i class="coche" id="s4-c1">✓</i></i><b>1 · Ta page</b><span>Dit-elle quoi faire ?</span></div>
          <div class="ligne-cl" id="s4-suivi" data-layout-allow-overlap><i class="case"><i class="coche" id="s4-c2">✓</i></i><b>2 · Ton suivi</b><span>Qui rappelle, et quand ?</span></div>
          <div class="masc" id="s4-m"><img id="s4-m-img" src="assets/img/m-s4-femme-sourire.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S5 · commente « AUDIT » → on te montre où ça fuit -->
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
            <div id="s5-carte-titre">Où ça fuit</div>
            <div id="s5-carte-sous">En message privé</div>
            <img id="s5-carte-logo" src="assets/img/logo-oddysee-blanc-guide.svg" alt="" />
          </div>
          <div class="masc" id="s5-m"><img id="s5-m-img" src="assets/img/m-s5-femme-victoire.webp" alt="" /></div>
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
          <div class="masc" id="s6-m"><img id="s6-m-img" src="assets/img/m-s6-femme-sourire.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- entête et sous-titres, au-dessus des scènes -->
      <section id="entete" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="10">
        <img id="entete-logo-n" src="assets/img/logo-oddysee-noir.svg" alt="Oddysee" />
        <img id="entete-logo-b" src="assets/img/logo-oddysee-blanc.svg" alt="" />
        <div id="entete-pastille"><i id="entete-point"></i>DIAGNOSTIC PUB</div>
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
      // goutte qui tombe (fuite)
      function goutte(sel, t, chute) {
        tl.fromTo(sel, { y: -20, autoAlpha: 0, scale: 0.6 }, { y: 0, autoAlpha: 1, scale: 1, duration: 0.18, ease: "power2.out" }, t);
        tl.to(sel, { y: chute, duration: 0.45, ease: "power2.in" }, t + 0.18);
        tl.to(sel, { autoAlpha: 0, scaleX: 1.6, scaleY: 0.4, duration: 0.12 }, t + 0.6);
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

      // ---------- S1 · le compteur de vues monte, les demandes restent à zéro ; « CHERCHE LA FUITE » sur la batterie ----------
      kenburns("#s1-kb", 0);
      tl.fromTo("#s1-carte", { scale: 1.05, rotation: -5 }, { scale: 1, rotation: -3, duration: 0.55, ease: "power4.out" }, 0);
      tl.fromTo("#s1-m", { y: 60 }, { y: 0, duration: 0.45, ease: "back.out(2)" }, 0);
      danse("#s1-m-img", 0.5, S[1].debut);
      tl.fromTo("#s1-trait", { scaleX: 0.2 }, { scaleX: 1, duration: 0.45, ease: "power3.out" }, 0.05);
      const vues = { v: 0 };
      const milliers = (n) => String(Math.round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, "\u00a0");
      const ecrireVues = () => { document.getElementById("s1-vues").textContent = milliers(vues.v); };
      tl.fromTo(vues, { v: 0 }, { v: 10000, duration: Math.max(0.5, C.vues + 0.4 - C.dix), ease: "power2.out",
        onUpdate: ecrireVues }, C.dix);
      tl.fromTo("#s1-zero", { scale: 1 }, { scale: 1.25, color: "#f0c860", duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1 }, C.zero);
      tl.set("#s1-zero", { color: "#f0c860" }, C.zero + 0.3);
      secousse("#s1-zero-ligne", C.zero + 0.05, 10);
      tl.fromTo("#s1-fuite", { scale: 2.6, autoAlpha: 0, rotation: 8 },
        { scale: 1, autoAlpha: 1, rotation: -9, duration: 0.16, ease: "power4.in" }, C.cherche - 0.14);
      tl.to("#s1-carte", { backgroundColor: "#3a3640", duration: 0.2 }, C.cherche);
      tl.to("#eclair", { opacity: 0.6, duration: 0.05 }, C.cherche + 0.02);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, C.cherche + 0.07);
      secousse("#s1-sec", C.cherche + 0.02, 26);
      goutte("#s1-goutte", C.fuite + 0.05, 330);
      tl.to("#s1-cam", { x: -1150, duration: 0.3, ease: "power3.in" }, S[1].debut);

      // ---------- S2 · l'entonnoir (exemple fictif) ----------
      tl.fromTo("#s2-cam", { x: 1150 }, { x: 0, duration: 0.3, ease: "power3.out" }, S[1].debut);
      flash(S[1].temps, 0.7);
      kenburns("#s2-kb", 1);
      surTitre(1);
      pop("#s2-fictif", C.exemple - 0.05, { de: 0.5, rot: -6, rotFin: -2 });
      ["#s2-f1", "#s2-f2", "#s2-f3"].forEach((s, i) => tl.fromTo(s, { autoAlpha: 0, scaleX: 0.6 },
        { autoAlpha: 1, scaleX: 1, duration: 0.3, ease: "power3.out" }, C.exemple + 0.25 + i * 0.18));
      pop("#s2-m", S[1].temps + 0.1, { de: 0.4 });
      danse("#s2-m-img", S[1].temps + 0.5, S[1].fin);
      tl.fromTo("#s2-e1", { scaleX: 0.2, autoAlpha: 0 }, { scaleX: 1, autoAlpha: 1, duration: 0.3, ease: "back.out(1.8)" }, C.dix2 - 0.05);
      tl.fromTo("#s2-e2", { scaleX: 0.2, autoAlpha: 0 }, { scaleX: 1, autoAlpha: 1, duration: 0.3, ease: "back.out(1.8)" }, C.cent - 0.05);
      goutte("#s2-g1", C.clics + 0.1, 200);
      tl.to("#s2-e1", { opacity: 0.55, duration: 0.3 }, C.cent3);
      tl.fromTo("#s2-e3", { scaleX: 0.2, autoAlpha: 0 }, { scaleX: 1, autoAlpha: 1, duration: 0.3, ease: "back.out(1.8)" }, C.deux - 0.05);
      tl.to("#s2-e2", { opacity: 0.55, duration: 0.3 }, C.deux);
      goutte("#s2-g2", C.formulaires + 0.1, 200);
      tl.to("#s2-e3", { scale: 1.06, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1 }, C.remplis);

      // ---------- S3 · la nuit tombe : deux demandes, personne ne rappelle ----------
      tl.fromTo("#s3-nuit", { scaleY: 0 }, { scaleY: 1, duration: 0.28, ease: "power4.out" }, S[2].debut);
      tl.set("#entete-logo-n", { autoAlpha: 0 }, S[2].debut + 0.15);
      tl.set("#entete-logo-b", { autoAlpha: 1 }, S[2].debut + 0.15);
      tl.to("#s2-cam", { y: -300, scale: 0.9, duration: 0.28, ease: "power3.in" }, S[2].debut);
      flash(S[2].temps, 0.5);
      surTitre(2);
      kenburns("#s3-kb", 2);
      tl.fromTo("#s3-tel", { y: 900, rotation: 8 }, { y: 0, rotation: -2, duration: 0.45, ease: "power4.out" }, S[2].debut + 0.1);
      tl.fromTo("#s3-cadran", { scale: 0.7, autoAlpha: 0 }, { scale: 1, autoAlpha: 1, duration: 0.4, ease: "power3.out" }, S[2].temps + 0.1);
      pop("#s3-n1", C.demandes - 0.15, { de: 0.6 });
      pop("#s3-n2", C.demandes + 0.1, { de: 0.6 });
      D.tics.forEach((t, i) => tl.to("#s3-aiguille", { rotation: (i + 1) * 90, duration: 0.1, ease: "back.out(3)" }, t));
      pop("#s3-m", C.personne - 0.1, { de: 0.4 });
      danse("#s3-m-img", C.personne + 0.3, S[2].fin);
      tl.to(["#s3-n1", "#s3-n2"], { opacity: 0.45, duration: 0.3 }, C.rappelees);
      pop("#s3-sans", C.rappelees, { de: 2, ease: "power4.in", d: 0.16, rot: -6, rotFin: -3 });
      pop("#s3-aucun", C.rappelees + 0.15, { de: 0.5 });
      secousse("#s3-sec", C.rappelees + 0.16, 12);
      tl.set("#s3-nuit", { transformOrigin: "50% 0%" }, S[3].debut);
      tl.to("#s3-nuit", { scaleY: 0, duration: 0.3, ease: "power4.in" }, S[3].debut);
      tl.to("#s3-cam", { y: -200, autoAlpha: 0, duration: 0.28, ease: "power3.in" }, S[3].debut);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, S[3].debut + 0.2);
      tl.set("#entete-logo-n", { autoAlpha: 1 }, S[3].debut + 0.2);

      // ---------- S4 · avant de changer ta pub : ta page, ton suivi (passage calme) ----------
      tl.fromTo("#s4-cam", { y: 1920 }, { y: 0, duration: 0.4, ease: "power3.out" }, S[3].debut + 0.1);
      kenburns("#s4-kb", 3);
      surTitre(3);
      pop("#s4-pub", C.changer - 0.1, { de: 0.6 });
      tl.fromTo("#s4-rature", { scaleX: 0 }, { scaleX: 1, duration: 0.25, ease: "power3.out" }, C.pub + 0.05);
      tl.to("#s4-pub", { x: -16, rotation: -2, duration: 0.25 }, C.pub + 0.05);
      pop("#s4-page", C.page - 0.35, { de: 0.6 });
      tl.to("#s4-page .case", { backgroundColor: VIOLET, duration: 0.12 }, C.page);
      pop("#s4-c1", C.page, { de: 2, ease: "back.out(3)", d: 0.2 });
      pop("#s4-suivi", C.suivi - 0.45, { de: 0.6 });
      tl.to("#s4-suivi .case", { backgroundColor: VIOLET, duration: 0.12 }, C.suivi);
      pop("#s4-c2", C.suivi, { de: 2, ease: "back.out(3)", d: 0.2 });
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
      pop("#s6-badge", C.clients - 0.1, { de: 0.4 });
      pop("#s6-rappel", C.pas, { de: 0.7 });
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

      window.__timelines["oddysee-serie-60-13"] = tl;
    </script>
  </body>
</html>
