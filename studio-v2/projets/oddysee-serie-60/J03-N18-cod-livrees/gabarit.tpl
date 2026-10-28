<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Oddysee — Série 60 · N18 · Cinquante commandes reçues… trente livrées</title>
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

      /* ---------- S1 · cinquante commandes, trente livrées ---------- */
      #s1-tab { position: absolute; left: 90px; top: 400px; width: 900px; height: 280px; padding: 26px 40px;
        border-radius: 40px; background: #fff; box-shadow: 0 34px 70px rgba(40, 10, 90, 0.25); }
      #s1-tab-titre { font-weight: 800; font-size: 30px; letter-spacing: 2px; color: var(--gris); }
      #s1-tab-titre em { font-style: normal; margin-left: 12px; padding: 2px 14px; border-radius: 16px; background: var(--or);
        color: var(--encre); font-size: 28px; letter-spacing: 2px; }
      .stat { position: absolute; top: 90px; width: 380px; }
      .stat span { display: block; font-weight: 800; font-size: 30px; letter-spacing: 2px; color: var(--gris); }
      .stat b { display: inline-block; margin-top: 6px; font-weight: 900; font-size: 120px; line-height: 1; transform-origin: left center; }
      #s1-st1 { left: 40px; }
      #s1-st1 b { color: var(--violet); }
      #s1-st2 { left: 480px; }
      #s1-st2 b { color: #157a3c; }
      #s1-vente { position: absolute; left: 150px; top: 700px; width: 740px; height: 200px; display: flex; flex-direction: column;
        align-items: center; justify-content: center; border-radius: 30px; border: 10px solid #fff; background: var(--violet-vif);
        color: #fff; font-weight: 900; font-size: 88px; line-height: 1; letter-spacing: 3px; text-align: center;
        box-shadow: 0 24px 50px rgba(40, 10, 90, 0.45); }
      #s1-m, #s1-m2 { right: 4px; top: 905px; }

      /* ---------- S2 · les autres reviennent ; la pub payée pour cinquante ---------- */
      .retour { position: absolute; top: 430px; width: 420px; height: 220px; padding: 26px 30px; border-radius: 34px; background: #fff;
        box-shadow: 0 24px 50px rgba(40, 10, 90, 0.18); }
      .colis { position: relative; display: block; width: 110px; height: 90px; border-radius: 12px; background: #c99a5b; }
      .colis::before { content: ""; position: absolute; left: 47px; top: 0; width: 16px; height: 90px; background: #e8cf9c; }
      .retour b { display: inline-block; margin-top: 18px; height: 60px; padding: 0 24px; border-radius: 30px; font-weight: 900;
        font-size: 34px; line-height: 60px; letter-spacing: 2px; }
      #s2-r1 { left: 90px; }
      #s2-r1 b { background: #d1452a; color: #fff; }
      #s2-r2 { left: 560px; }
      #s2-r2 b { background: #e4e1ea; color: #4a4554; }
      #s2-ticket { position: absolute; left: 90px; top: 700px; width: 560px; height: 230px; padding: 26px 36px; border-radius: 34px;
        background: #fff; box-shadow: 0 24px 50px rgba(40, 10, 90, 0.2); border-top: 10px dashed var(--lilas); }
      #s2-ticket span { display: block; font-weight: 800; font-size: 30px; letter-spacing: 2px; color: var(--gris); }
      #s2-ticket b { display: block; margin-top: 8px; font-weight: 900; font-size: 84px; line-height: 1; color: var(--encre); }
      #s2-ticket small { display: block; margin-top: 10px; font-weight: 700; font-size: 32px; color: var(--violet); }
      #s2-m { right: -10px; top: 905px; }

      /* ---------- S3 · le vrai coût par vente ---------- */
      #s3-nuit { position: absolute; inset: 0; transform-origin: 50% 100%;
        background: radial-gradient(circle at 50% 30%, #8a5cff 0%, #632bc5 45%, #2a1060 100%); }
      #s3-sur { color: #fff; }
      #s3-sur .sur-trait { background: var(--or); }
      #s3-fictif { position: absolute; left: 400px; top: 400px; height: 56px; padding: 0 24px; display: flex; align-items: center;
        border-radius: 28px; background: var(--or); color: var(--encre); font-weight: 900; font-size: 28px; letter-spacing: 3px; }
      #s3-grille { position: absolute; left: 400px; top: 485px; width: 620px; display: grid; grid-template-columns: repeat(10, 1fr);
        gap: 10px; }
      .cmd { position: relative; display: block; height: 50px; border-radius: 10px; background: rgba(255, 255, 255, 0.24); }
      .cmd i { position: absolute; inset: 0; border-radius: 10px; background: var(--or); opacity: 0; }
      #s3-calcul { position: absolute; left: 400px; top: 820px; width: 620px; height: 300px; padding: 26px 34px; border-radius: 36px;
        background: #fff; box-shadow: 0 30px 60px rgba(0, 0, 0, 0.35); }
      #s3-calcul span { display: inline-block; font-weight: 800; font-size: 40px; color: var(--encre); }
      #s3-div { margin-left: 12px; }
      #s3-resultat { display: flex; align-items: center; gap: 18px; margin-top: 18px; }
      #s3-resultat b { display: block; height: 100px; padding: 0 28px; border-radius: 50px; background: var(--or); color: var(--encre);
        font-weight: 900; font-size: 68px; line-height: 100px; }
      #s3-resultat small { display: block; font-weight: 800; font-size: 34px; color: var(--violet); }
      #s3-vingt { position: relative; display: inline-block; margin-top: 16px; font-weight: 800; font-size: 34px; color: var(--gris); }
      #s3-barre { position: absolute; left: -6px; right: -6px; top: 20px; height: 7px; border-radius: 4px; background: #d1452a;
        transform-origin: 0 50%; }
      #s3-m { left: 0px; top: 905px; }
      /* corps violet sur fond violet : un liseré blanc garde la mascotte lisible */
      #s3-m img { filter: drop-shadow(0 0 3px rgba(255, 255, 255, 0.95)) drop-shadow(0 0 10px rgba(255, 255, 255, 0.55)); }

      /* ---------- S4 · commande → confirmation → expédition ---------- */
      #s4-ligne { position: absolute; left: 115px; top: 500px; width: 8px; height: 420px; border-radius: 4px;
        background: var(--lilas); transform-origin: 50% 0; }
      .piece { position: absolute; left: 60px; width: 640px; height: 170px; padding: 28px 30px 0 140px; border-radius: 34px;
        background: #fff; box-shadow: 0 24px 50px rgba(40, 10, 90, 0.18); }
      .piece em { position: absolute; left: 30px; top: 40px; width: 90px; height: 90px; border-radius: 50%; background: var(--violet);
        color: #fff; font-style: normal; font-weight: 900; font-size: 48px; line-height: 90px; text-align: center; }
      .piece b { display: block; font-weight: 900; font-size: 44px; line-height: 1.05; color: var(--encre); }
      .piece small { display: block; margin-top: 8px; font-weight: 600; font-size: 28px; color: var(--gris); }
      #s4-p1 { top: 420px; }
      #s4-p2 { top: 620px; }
      #s4-p2 em { background: var(--whatsapp); }
      #s4-p3 { top: 820px; }
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
    <div id="root" data-composition-id="oddysee-serie-60-n18" data-start="0" data-width="1080" data-height="1920" data-duration="{{DUREE}}">

      <section id="fond" class="clip" data-start="0" data-duration="{{DUREE}}" data-track-index="0">
        <div id="fond-base"></div>
        <div id="fond-pulse" class="plein"><div id="fond-points"></div></div>
        <div id="fond-vignette"></div>
      </section>

      <!-- S1 · cinquante commandes reçues… trente livrées ? / une commande n'est pas une vente -->
      <section id="s1" class="clip" {{S1}} data-track-index="1">
        <div class="cam" id="s1-cam"><div class="sec" id="s1-sec"><div class="kb" id="s1-kb">
          <div data-layout-allow-overlap class="sur" id="s1-sur">Ta boutique<i class="sur-trait" id="s1-trait"></i></div>
          <div id="s1-tab" data-layout-allow-overlap>
            <div id="s1-tab-titre">CE MOIS-CI<em>EXEMPLE FICTIF</em></div>
            <div class="stat" id="s1-st1"><span>COMMANDES REÇUES</span><b id="s1-n1">0</b></div>
            <div class="stat" id="s1-st2"><span>LIVRÉES ET PAYÉES</span><b id="s1-n2">0</b></div>
          </div>
          <div class="masc" id="s1-m"><img id="s1-m-img" src="assets/img/m-s1a-moustache-stupefait.webp" alt="" /></div>
          <div class="masc" id="s1-m2"><img id="s1-m2-img" src="assets/img/m-s1b-pochoir-mecontent.webp" alt="" /></div>
          <div id="s1-vente" data-layout-allow-overlap><span>PAS UNE</span><span>VENTE</span></div>
        </div></div></div>
      </section>

      <!-- S2 · les autres refusent ou disparaissent / la pub payée pour cinquante -->
      <section id="s2" class="clip" {{S2}} data-track-index="2">
        <div class="cam" id="s2-cam"><div class="sec" id="s2-sec"><div class="kb" id="s2-kb">
          <div data-layout-allow-overlap class="sur" id="s2-sur">Les vingt autres<i class="sur-trait" id="s2-trait"></i></div>
          <div class="retour" id="s2-r1" data-layout-allow-overlap><i class="colis"></i><b>REFUSÉ</b></div>
          <div class="retour" id="s2-r2" data-layout-allow-overlap><i class="colis"></i><b>INJOIGNABLE</b></div>
          <div id="s2-ticket" data-layout-allow-overlap><span>TA PUB</span><b>1 000 DH</b><small>payée pour 50 commandes</small></div>
          <div class="masc" id="s2-m"><img id="s2-m-img" src="assets/img/m-s2-barbu-inquiet.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S3 · exemple fictif : 33 DH la vente, pas 20 (partie B) -->
      <section id="s3" class="clip" {{S3}} data-track-index="3">
        <div id="s3-nuit"></div>
        <div class="cam" id="s3-cam"><div class="sec" id="s3-sec"><div class="kb" id="s3-kb">
          <div data-layout-allow-overlap class="sur" id="s3-sur">Ton vrai coût<i class="sur-trait" id="s3-trait"></i></div>
          <div id="s3-fictif" data-layout-allow-overlap>EXEMPLE FICTIF</div>
          <div id="s3-grille"><i class="cmd"></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"><i id="s3-k19"></i></i><i class="cmd"><i id="s3-k0"></i></i><i class="cmd"><i id="s3-k4"></i></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"><i id="s3-k3"></i></i><i class="cmd"><i id="s3-k9"></i></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"><i id="s3-k13"></i></i><i class="cmd"><i id="s3-k27"></i></i><i class="cmd"></i><i class="cmd"><i id="s3-k16"></i></i><i class="cmd"></i><i class="cmd"><i id="s3-k20"></i></i><i class="cmd"><i id="s3-k21"></i></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"><i id="s3-k18"></i></i><i class="cmd"><i id="s3-k8"></i></i><i class="cmd"><i id="s3-k17"></i></i><i class="cmd"><i id="s3-k1"></i></i><i class="cmd"><i id="s3-k10"></i></i><i class="cmd"><i id="s3-k23"></i></i><i class="cmd"><i id="s3-k28"></i></i><i class="cmd"><i id="s3-k15"></i></i><i class="cmd"><i id="s3-k29"></i></i><i class="cmd"><i id="s3-k5"></i></i><i class="cmd"></i><i class="cmd"><i id="s3-k14"></i></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"></i><i class="cmd"><i id="s3-k25"></i></i><i class="cmd"><i id="s3-k2"></i></i><i class="cmd"></i><i class="cmd"><i id="s3-k11"></i></i><i class="cmd"><i id="s3-k24"></i></i><i class="cmd"></i><i class="cmd"><i id="s3-k26"></i></i><i class="cmd"><i id="s3-k12"></i></i><i class="cmd"><i id="s3-k22"></i></i><i class="cmd"><i id="s3-k6"></i></i><i class="cmd"><i id="s3-k7"></i></i></div>
          <div id="s3-calcul" data-layout-allow-overlap>
            <span id="s3-pub">1 000 DH de pub</span><span id="s3-div">÷ 30 ventes</span>
            <div id="s3-resultat"><b>33 DH</b><small>la vente</small></div>
            <div id="s3-vingt">pas 20 DH<i id="s3-barre"></i></div>
          </div>
          <div class="masc" id="s3-m"><img id="s3-m-img" src="assets/img/m-s3-barbu-designe.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S4 · confirme chaque commande avant d'expédier (passage calme) -->
      <section id="s4" class="clip" {{S4}} data-track-index="4">
        <div class="cam" id="s4-cam"><div class="sec" id="s4-sec"><div class="kb" id="s4-kb">
          <div data-layout-allow-overlap class="sur" id="s4-sur">Le bon réflexe<i class="sur-trait" id="s4-trait"></i></div>
          <i id="s4-ligne"></i>
          <div class="piece" id="s4-p1" data-layout-allow-overlap><em>1</em><b>Commande reçue</b><small>Tu la notes tout de suite</small></div>
          <div class="piece" id="s4-p2" data-layout-allow-overlap><em>2</em><b>Confirmation</b><small>Par appel ou WhatsApp, vite</small></div>
          <div class="piece" id="s4-p3" data-layout-allow-overlap><em>3</em><b>Expédition</b><small>Seulement après le oui</small></div>
          <div class="masc" id="s4-m"><img id="s4-m-img" src="assets/img/m-s4-pochoir-idee.webp" alt="" /></div>
        </div></div></div>
      </section>

      <!-- S5 · commente « AUDIT » → on calcule ton vrai coût -->
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
            <div id="s5-carte-titre">Ton vrai coût</div>
            <div id="s5-carte-sous">Par vente livrée</div>
            <img id="s5-carte-logo" src="assets/img/logo-oddysee-blanc-guide.svg" alt="" />
          </div>
          <div class="masc" id="s5-m"><img id="s5-m-img" src="assets/img/m-s5-gomina-rire-salut.webp" alt="" /></div>
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
          <div class="masc" id="s6-m"><img id="s6-m-img" src="assets/img/m-s6-femme-victoire.webp" alt="" /></div>
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

      // ---------- S1 · les compteurs ; « PAS UNE VENTE » sur la batterie ----------
      kenburns("#s1-kb", 0);
      tl.fromTo("#s1-tab", { scale: 1.05, rotation: -4 }, { scale: 1, rotation: -2, duration: 0.55, ease: "power4.out" }, 0);
      tl.fromTo("#s1-m", { y: 60 }, { y: 0, duration: 0.45, ease: "back.out(2)" }, 0);
      danse("#s1-m-img", 0.5, C.une);
      tl.fromTo("#s1-trait", { scaleX: 0.2 }, { scaleX: 1, duration: 0.45, ease: "power3.out" }, 0.05);
      tl.set("#s1-m2", { autoAlpha: 0 }, 0);
      const n1 = { v: 0 }, n2 = { v: 0 };
      const ecrire1 = () => { document.getElementById("s1-n1").textContent = String(Math.round(n1.v)); };
      const ecrire2 = () => { document.getElementById("s1-n2").textContent = String(Math.round(n2.v)); };
      tl.fromTo(n1, { v: 0 }, { v: 50, duration: Math.max(0.5, C.recues + 0.3 - C.cinquante), ease: "power2.out", onUpdate: ecrire1 }, C.cinquante);
      tl.fromTo(n2, { v: 0 }, { v: 30, duration: 0.45, ease: "power2.out", onUpdate: ecrire2 }, C.trente - 0.05);
      tl.fromTo("#s1-n2", { scale: 1 }, { scale: 1.18, duration: 0.12, ease: "power2.out", yoyo: true, repeat: 1 }, C.livrees);
      // « Une commande n'est pas une vente » sur l'entrée de la batterie
      tl.set("#s1-m", { autoAlpha: 0 }, C.une - 0.02);
      tl.set("#s1-m2", { autoAlpha: 1 }, C.une - 0.02);
      tl.fromTo("#s1-m2", { scale: 0.9 }, { scale: 1, duration: 0.3, ease: "back.out(2)" }, C.une - 0.02);
      danse("#s1-m2-img", C.une + 0.3, S[1].debut);
      tl.to("#eclair", { opacity: 0.6, duration: 0.05 }, C.une + 0.02);
      tl.to("#eclair", { opacity: 0, duration: 0.3, ease: "power2.out" }, C.une + 0.07);
      secousse("#s1-sec", C.une + 0.02, 26);
      tl.to("#s1-n1", { color: "#9a94a6", duration: 0.15 }, C.une);
      tl.fromTo("#s1-vente", { scale: 2.6, autoAlpha: 0, rotation: 8 },
        { scale: 1, autoAlpha: 1, rotation: -6, duration: 0.16, ease: "power4.in" }, C.pas - 0.14);
      tl.to("#s1-cam", { x: -1150, duration: 0.3, ease: "power3.in" }, S[1].debut);

      // ---------- S2 · les colis reviennent ; la pub payée pour cinquante ----------
      tl.fromTo("#s2-cam", { x: 1150 }, { x: 0, duration: 0.3, ease: "power3.out" }, S[1].debut);
      flash(S[1].temps, 0.7);
      kenburns("#s2-kb", 1);
      surTitre(1);
      pop("#s2-m", S[1].temps + 0.1, { de: 0.4 });
      danse("#s2-m-img", S[1].temps + 0.5, S[1].fin);
      tl.fromTo("#s2-r1", { x: -300, autoAlpha: 0, rotation: -8 }, { x: 0, autoAlpha: 1, rotation: -3, duration: 0.35, ease: "back.out(1.8)" }, C.refusent - 0.12);
      tl.fromTo("#s2-r2", { x: 300, autoAlpha: 0, rotation: 8 }, { x: 0, autoAlpha: 1, rotation: 3, duration: 0.35, ease: "back.out(1.8)" }, C.disparaissent - 0.12);
      pop("#s2-ticket", C.mais - 0.05, { de: 0.6, rot: -3, rotFin: -1 });
      tl.fromTo("#s2-ticket small", { scale: 1 }, { scale: 1.12, duration: 0.14, ease: "power2.out", yoyo: true, repeat: 1, transformOrigin: "0% 50%" }, C.cinquante3);

      // ---------- S3 · partie B : 1 000 DH ÷ 30 ventes = 33 DH la vente ----------
      tl.fromTo("#s3-nuit", { scaleY: 0 }, { scaleY: 1, duration: 0.28, ease: "power4.out" }, S[2].debut);
      tl.set("#entete-logo-n", { autoAlpha: 0 }, S[2].debut + 0.15);
      tl.set("#entete-logo-b", { autoAlpha: 1 }, S[2].debut + 0.15);
      tl.to("#s2-cam", { y: -300, scale: 0.9, duration: 0.28, ease: "power3.in" }, S[2].debut);
      flash(S[2].temps, 0.5);
      surTitre(2);
      kenburns("#s3-kb", 2);
      pop("#s3-fictif", C.exemple - 0.05, { de: 0.5, rot: -4, rotFin: -2 });
      tl.fromTo(".cmd", { scale: 0.4, autoAlpha: 0 }, { scale: 1, autoAlpha: 1, duration: 0.18, ease: "back.out(2)", stagger: 0.008 }, S[2].temps);
      // 30 commandes livrées s'allument par paquets de 5, au tempo
      for (let g = 0; g < 6; g++) {
        const t = D.tics[Math.min(g, D.tics.length - 1)] + (g >= D.tics.length ? 0.12 * (g - D.tics.length + 1) : 0);
        for (let k = 0; k < 5; k++) tl.to("#s3-k" + (g * 5 + k), { opacity: 1, duration: 0.08 }, t + k * 0.03);
      }
      pop("#s3-calcul", C.mille - 0.15, { de: 0.6 });
      tl.set(["#s3-div", "#s3-resultat", "#s3-vingt"], { autoAlpha: 0 }, 0);
      tl.fromTo("#s3-div", { autoAlpha: 0, x: -20 }, { autoAlpha: 1, x: 0, duration: 0.2 }, C.trente4 - 0.05);
      tl.fromTo("#s3-resultat", { autoAlpha: 0, x: -30 }, { autoAlpha: 1, x: 0, duration: 0.25, ease: "back.out(2)" }, C.trentetrois - 0.1);
      tl.fromTo("#s3-resultat b", { scale: 1.6 }, { scale: 1, duration: 0.3, ease: "back.out(3)" }, C.trentetrois - 0.1);
      tl.fromTo("#s3-vingt", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.15 }, C.pas4 - 0.05);
      tl.fromTo("#s3-barre", { scaleX: 0 }, { scaleX: 1, duration: 0.2, ease: "power3.out" }, C.vingt);
      pop("#s3-m", S[2].temps + 0.1, { de: 0.4 });
      danse("#s3-m-img", S[2].temps + 0.5, S[2].fin);
      tl.set("#s3-nuit", { transformOrigin: "50% 0%" }, S[3].debut);
      tl.to("#s3-nuit", { scaleY: 0, duration: 0.3, ease: "power4.in" }, S[3].debut);
      tl.to("#s3-cam", { y: -200, autoAlpha: 0, duration: 0.28, ease: "power3.in" }, S[3].debut);
      tl.set("#entete-logo-b", { autoAlpha: 0 }, S[3].debut + 0.2);
      tl.set("#entete-logo-n", { autoAlpha: 1 }, S[3].debut + 0.2);

      // ---------- S4 · le bon réflexe (passage calme) ----------
      tl.fromTo("#s4-cam", { y: 1920 }, { y: 0, duration: 0.4, ease: "power3.out" }, S[3].debut + 0.1);
      kenburns("#s4-kb", 3);
      surTitre(3);
      tl.fromTo("#s4-ligne", { scaleY: 0 }, { scaleY: 1, duration: Math.max(0.6, C.expedier - C.commande5), ease: "none" }, C.commande5);
      pop("#s4-p1", C.commande5 - 0.25, { de: 0.6 });
      pop("#s4-p2", C.appel - 0.25, { de: 0.6 });
      pop("#s4-p3", C.expedier - 0.25, { de: 0.6 });
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
      pop("#s6-badge", C.encaissees - 0.1, { de: 0.4 });
      pop("#s6-rappel", C.promesses - 0.2, { de: 0.7 });
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

      window.__timelines["oddysee-serie-60-n18"] = tl;
    </script>
  </body>
</html>
