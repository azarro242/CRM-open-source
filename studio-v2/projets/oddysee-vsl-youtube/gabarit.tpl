<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1920, height=1080" />
    <title>Oddysee — VSL YouTube · Différence d'expertise</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      @font-face { font-family: "Instrument Serif"; font-style: italic; font-weight: 400; font-display: block; src: url("assets/fonts/InstrumentSerif-italic-latin.woff2") format("woff2"); }
      @font-face { font-family: "Instrument Serif"; font-style: normal; font-weight: 400; font-display: block; src: url("assets/fonts/InstrumentSerif-normal-latin.woff2") format("woff2"); }
      :root {
        --violet: #632bc5; --violet-vif: #6a3be8; --violet-pale: #a877ff; --lilas: #e2d7f7; --brume: #f7f3ff;
        --or: #f0c860; --encre: #1b1530; --gris: #6f6a7a; --nuit: #0b0820;
        --txt: #1b1530; --cle: #632bc5;
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1920px; height: 1080px; overflow: hidden; background: #0b0820; }
      body { font-family: "Outfit", sans-serif; color: var(--encre); }
      #root { position: relative; width: 1920px; height: 1080px; overflow: hidden; }
      .clip { position: absolute; inset: 0; }
      .g { position: absolute; inset: 0; }
      .abs { position: absolute; }
      .h { opacity: 0; visibility: hidden; }
      img { display: block; }

      /* ---------- fond continu ---------- */
      .fond-img { position: absolute; inset: 0; width: 1920px; height: 1080px; object-fit: cover; }
      .halo { position: absolute; border-radius: 50%; }
      #halo-1 { left: -260px; top: -320px; width: 1100px; height: 1100px;
        background: radial-gradient(circle, rgba(168, 119, 255, 0.42) 0%, rgba(168, 119, 255, 0) 65%); }
      #halo-2 { left: 1080px; top: 380px; width: 1200px; height: 1200px;
        background: radial-gradient(circle, rgba(244, 170, 255, 0.36) 0%, rgba(244, 170, 255, 0) 62%); }
      #halo-3 { left: 600px; top: -500px; width: 900px; height: 900px;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.55) 0%, rgba(255, 255, 255, 0) 60%); }
      #logo-n, #logo-b { position: absolute; left: 72px; top: 52px; width: 132px; height: 50px; }
      #fond-sombre, #logo-b { opacity: 0; }

      /* ---------- sous-titres intégrés ---------- */
      #sous { position: absolute; inset: 0; }
      .st { position: absolute; left: 160px; right: 160px; top: 872px; text-align: center; font-weight: 600;
        font-size: 50px; line-height: 1.22; letter-spacing: -0.3px; color: var(--txt); opacity: 0; visibility: hidden;
        text-shadow: 0 2px 18px rgba(255, 255, 255, 0.35); }
      .st .w { display: inline-block; opacity: 0; }
      .st .cle { color: var(--cle); font-weight: 700; }
      .st .ital { color: var(--cle); font-family: "Instrument Serif", serif; font-style: italic; font-weight: 400;
        font-size: 62px; letter-spacing: 0; }

      /* ---------- grammaire commune ---------- */
      .carte { position: absolute; background: rgba(255, 255, 255, 0.94); border-radius: 26px;
        box-shadow: 0 24px 60px rgba(45, 15, 110, 0.18), 0 2px 8px rgba(45, 15, 110, 0.08); }
      .verre { position: absolute; background: rgba(255, 255, 255, 0.08); border: 1.5px solid rgba(255, 255, 255, 0.2);
        border-radius: 26px; color: #fff; box-shadow: 0 30px 70px rgba(0, 0, 0, 0.35); }
      .por { position: absolute; border-radius: 50%; overflow: hidden; border: 6px solid #fff;
        box-shadow: 0 18px 44px rgba(45, 15, 110, 0.25); background: #ddd; }
      .por img { width: 100%; height: 100%; object-fit: cover; }
      .chipn { display: inline-flex; align-items: center; gap: 8px; height: 34px; padding: 0 16px; border-radius: 17px;
        background: #121019; color: #fff; font-weight: 600; font-size: 18px; white-space: nowrap; }
      .chipn::before { content: ""; width: 9px; height: 9px; border-radius: 50%; background: #fff; }
      .chipv { display: inline-flex; align-items: center; gap: 10px; height: 52px; padding: 0 24px; border-radius: 26px;
        background: var(--violet); color: #fff; font-weight: 700; font-size: 24px; white-space: nowrap;
        box-shadow: 0 14px 34px rgba(99, 43, 197, 0.35); }
      .chipb { display: inline-flex; align-items: center; gap: 10px; height: 50px; padding: 0 22px; border-radius: 25px;
        background: #fff; color: var(--encre); font-weight: 700; font-size: 23px; white-space: nowrap;
        box-shadow: 0 14px 34px rgba(45, 15, 110, 0.18); }
      .chipb .ico, .chipv .ico { width: 26px; height: 26px; }
      .chipb .ico { color: var(--violet); }
      .icoc { display: flex; align-items: center; justify-content: center; width: 58px; height: 58px; border-radius: 16px;
        background: var(--lilas); color: var(--violet); flex: none; }
      .icoc .ico { width: 30px; height: 30px; }
      .verre .icoc { background: rgba(168, 119, 255, 0.22); color: #d9c6ff; }
      .ligne-c { display: flex; align-items: center; gap: 16px; }
      .sk { height: 12px; border-radius: 6px; background: #e7e2f2; }
      .verre .sk { background: rgba(255, 255, 255, 0.18); }
      .tag-illu { position: absolute; font-family: "Instrument Serif", serif; font-style: italic; font-size: 24px; color: var(--gris); }
      .curseur { position: absolute; width: 40px; height: 48px; z-index: 50; }
      .curseur-svg { width: 40px; height: 48px; filter: drop-shadow(0 6px 10px rgba(0, 0, 0, 0.3)); }
      .ico { width: 28px; height: 28px; }
      svg.trait { position: absolute; left: 0; top: 0; width: 1920px; height: 1080px; overflow: visible; }
      .titre-c { font-weight: 700; font-size: 26px; }
      .sous-c { font-weight: 500; font-size: 19px; color: var(--gris); }
      .verre .sous-c { color: rgba(255, 255, 255, 0.65); }

      /* ---------- intro ---------- */
      #i-mot { position: absolute; left: 300px; top: 150px; width: 1200px; height: 150px; font-weight: 800; font-size: 128px;
        letter-spacing: 16px; color: var(--encre); white-space: nowrap; }
      #i-mot span { display: inline-block; }
      #i-sous { position: absolute; left: 306px; top: 300px; width: 700px; height: 50px; font-family: "Instrument Serif", serif;
        font-style: italic; font-size: 44px; color: var(--violet); }

      /* ---------- niveaux ---------- */
      #n-rang { position: absolute; left: 0; top: 0; width: 1920px; height: 1080px; transform-origin: 960px 0px; }
      .nc { position: absolute; width: 300px; height: 340px; padding: 26px 24px; display: flex; flex-direction: column; align-items: center; }
      .nc .por { position: relative; width: 150px; height: 150px; border-width: 5px; }
      .nc h3 { margin-top: 18px; font-weight: 800; font-size: 30px; letter-spacing: 1px; text-transform: uppercase; }
      .barres { display: flex; gap: 8px; margin-top: 14px; }
      .barres i { display: block; width: 34px; height: 10px; border-radius: 5px; background: #e7e2f2; }
      .barres i.on { background: var(--violet); }
      .nc .chipn { margin-top: 16px; }
      .bulle { position: absolute; height: 58px; padding: 0 22px; border-radius: 29px 29px 29px 8px; background: #fff;
        display: flex; align-items: center; gap: 10px; font-weight: 700; font-size: 23px; color: var(--violet);
        box-shadow: 0 16px 36px rgba(45, 15, 110, 0.22); white-space: nowrap; }
      .bulle .ico { width: 24px; height: 24px; }
      .pile { position: absolute; width: 250px; height: 300px; }
      .dm { position: absolute; left: 0; width: 250px; height: 30px; border-radius: 9px; background: #fff; display: flex; align-items: center;
        gap: 8px; padding: 0 10px; font-weight: 600; font-size: 15px; color: var(--encre); box-shadow: 0 6px 14px rgba(45, 15, 110, 0.14); }
      .dm .ico { width: 18px; height: 18px; color: var(--violet); }
      .dm em { flex: 1; height: 7px; border-radius: 4px; background: #ece7f6; }
      .nc.actif { box-shadow: 0 0 0 7px var(--violet), 0 24px 60px rgba(45, 15, 110, 0.25); }
      .demo { position: absolute; inset: 0; }
      .win { position: absolute; width: 540px; height: 310px; border-radius: 18px; background: #fff; overflow: hidden;
        box-shadow: 0 26px 60px rgba(45, 15, 110, 0.22); }
      .win-b { height: 46px; background: #f3effa; display: flex; align-items: center; gap: 8px; padding: 0 16px; font-weight: 600; font-size: 18px; color: var(--gris); }
      .win-b i { display: block; width: 12px; height: 12px; border-radius: 50%; background: #d9d2e8; }
      .win-c { padding: 24px; display: flex; flex-direction: column; gap: 16px; }
      .post { position: absolute; width: 340px; height: 430px; padding: 18px; }
      .post-t { display: flex; align-items: center; gap: 12px; font-weight: 700; font-size: 20px; }
      .post-t i { display: block; width: 42px; height: 42px; border-radius: 50%; background: linear-gradient(135deg, #a877ff, #632bc5); }
      .post-img { margin-top: 14px; height: 220px; border-radius: 14px; background: linear-gradient(140deg, #e2d7f7 0%, #a877ff 55%, #6a3be8 100%);
        display: flex; align-items: center; justify-content: center; color: #fff; }
      .post-img .ico { width: 64px; height: 64px; }
      .post .sk { margin-top: 14px; }
      .copie-cadre { position: absolute; width: 340px; height: 430px; border-radius: 26px; border: 3px dashed var(--violet-pale); }
      .liste-r { display: flex; align-items: center; gap: 18px; height: 74px; padding: 0 22px; border-bottom: 1.5px solid #efeaf7; font-weight: 600; font-size: 24px; }
      .case { display: flex; align-items: center; justify-content: center; width: 38px; height: 38px; border-radius: 10px; border: 3px solid #d6cdea; color: #fff; flex: none; }
      .case .ico { width: 24px; height: 24px; opacity: 0; }
      .sem { display: grid; grid-template-columns: repeat(5, 1fr); gap: 10px; padding: 20px; }
      .sem b { text-align: center; font-weight: 700; font-size: 20px; color: var(--gris); }
      .sem span { height: 210px; border-radius: 12px; background: #f6f3fb; }
      .blk { position: absolute; height: 54px; border-radius: 12px; background: var(--violet); color: #fff; font-weight: 700; font-size: 17px;
        display: flex; align-items: center; padding: 0 12px; box-shadow: 0 10px 22px rgba(99, 43, 197, 0.35); }
      #d3-offre { position: absolute; left: 820px; top: 380px; width: 280px; height: 180px; border-radius: 28px;
        background: linear-gradient(140deg, #6a3be8, #632bc5 60%, #4a1f99); color: #fff; display: flex; flex-direction: column;
        align-items: center; justify-content: center; gap: 10px; box-shadow: 0 30px 60px rgba(99, 43, 197, 0.45); }
      #d3-offre .ico { width: 44px; height: 44px; }
      #d3-offre b { font-weight: 800; font-size: 30px; }

      /* ---------- effets ---------- */
      .onde { position: absolute; border-radius: 50%; border: 3px solid var(--violet-pale); }
      .kcard { width: 380px; height: 220px; padding: 26px; display: flex; flex-direction: column; gap: 16px; }
      .kcard .titre-c { font-size: 25px; }
      .ok { display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 50%; background: #1fa855; color: #fff; }
      .ok .ico { width: 24px; height: 24px; }

      /* ---------- douleur ---------- */
      .verre.vc { width: 330px; height: 96px; padding: 0 20px; display: flex; align-items: center; gap: 16px; font-weight: 700; font-size: 25px; }
      .cal { position: absolute; width: 640px; height: 470px; padding: 26px 28px; background: rgba(18, 12, 44, 0.9); }
      .cal-t { display: flex; justify-content: space-between; align-items: center; font-weight: 800; font-size: 30px; }
      .cal-g { margin-top: 18px; display: grid; grid-template-columns: repeat(7, 1fr); gap: 7px; }
      .cj { height: 60px; border-radius: 10px; background: rgba(255, 255, 255, 0.07); padding: 6px 8px; }
      .cj b { font-weight: 600; font-size: 15px; color: rgba(255, 255, 255, 0.85); }
      .cj span { display: flex; gap: 4px; margin-top: 8px; }
      .cj span i { display: block; width: 26px; height: 9px; border-radius: 5px; background: #a877ff; }
      .cj.vide { background: transparent; }
      .facture { position: absolute; width: 230px; height: 80px; border-radius: 16px; background: #fff; color: var(--encre);
        display: flex; align-items: center; gap: 12px; padding: 0 16px; font-weight: 700; font-size: 22px; box-shadow: 0 18px 40px rgba(0, 0, 0, 0.45); }
      .facture .icoc { width: 46px; height: 46px; background: #ffe2d6; color: #d0482a; }
      .facture .icoc .ico { width: 24px; height: 24px; }
      #dl-horloge { position: absolute; left: 1430px; top: 200px; width: 190px; height: 190px; border-radius: 50%;
        border: 5px solid rgba(255, 255, 255, 0.75); background: rgba(255, 255, 255, 0.06); }
      .aig { position: absolute; left: 92px; bottom: 92px; width: 6px; border-radius: 3px; background: #fff; transform-origin: 50% 100%; }
      #dl-h { height: 52px; } #dl-m { height: 74px; background: #a877ff; }

      /* ---------- oddysee ---------- */
      #o-badge { position: absolute; left: 780px; top: 140px; width: 360px; height: 360px; border-radius: 48px; overflow: hidden;
        box-shadow: 0 40px 90px rgba(106, 59, 232, 0.55); }
      #o-badge img { width: 360px; height: 360px; }
      #o-mot { position: absolute; left: 790px; top: 540px; width: 340px; height: 129px; }
      .nom { position: absolute; display: flex; flex-direction: column; align-items: center; gap: 4px; color: #fff; text-align: center; }
      .nom b { font-weight: 700; font-size: 24px; } .nom span { font-weight: 500; font-size: 18px; color: rgba(255, 255, 255, 0.7); }

      /* ---------- parcours ---------- */
      .pc { width: 380px; height: 360px; padding: 22px; display: flex; flex-direction: column; gap: 16px; }
      .pc-vig { height: 170px; border-radius: 14px; overflow: hidden; background: #f3effa; }
      .pc-vig img { width: 100%; height: 100%; object-fit: cover; object-position: left center; }
      .champ { height: 44px; border-radius: 10px; border: 2px solid #e7e2f2; }
      .bouton { display: flex; align-items: center; justify-content: center; height: 48px; border-radius: 24px; background: var(--violet);
        color: #fff; font-weight: 700; font-size: 20px; }
      .notif { position: absolute; height: 74px; padding: 0 20px 0 12px; border-radius: 20px; background: #fff; display: flex; align-items: center; gap: 14px;
        box-shadow: 0 20px 44px rgba(45, 15, 110, 0.28); white-space: nowrap; }
      .notif .icoc { width: 50px; height: 50px; border-radius: 14px; background: var(--violet); color: #fff; }
      .notif .icoc .ico { width: 26px; height: 26px; }
      .notif b { display: block; font-weight: 700; font-size: 21px; } .notif span { display: block; font-weight: 500; font-size: 16px; color: var(--gris); }
      .sit { width: 440px; height: 330px; overflow: hidden; }
      .sit-fond { position: absolute; inset: 0; }
      .sit-l { position: absolute; left: 24px; bottom: 22px; display: flex; align-items: center; gap: 12px; font-weight: 700; font-size: 26px; }

      /* ---------- preuves ---------- */
      .tuile { width: 300px; height: 300px; padding: 12px; overflow: hidden; }
      .tuile img { width: 276px; height: 236px; object-fit: contain; }
      .tuile b { display: block; text-align: center; font-weight: 700; font-size: 19px; margin-top: 6px; }
      .sect { width: 470px; height: 200px; padding: 24px; display: flex; gap: 20px; align-items: center; }
      .sect .icoc { width: 68px; height: 68px; }
      .sect h4 { font-weight: 700; font-size: 27px; line-height: 1.15; flex: 1; }
      .sect-v { width: 150px; height: 150px; border-radius: 14px; overflow: hidden; background: #f6f3fb; display: flex; align-items: center; justify-content: center; flex: none; }
      .sect-v img { width: 100%; height: 100%; object-fit: cover; object-position: left top; }
      .sect-v img.logo { width: 130px; height: 80px; object-fit: contain; }
      .ref { width: 340px; height: 200px; display: flex; align-items: center; justify-content: center; }
      .ref img { width: 240px; height: 110px; object-fit: contain; }

      /* ---------- meta ---------- */
      #m-badge { position: absolute; left: 670px; top: 140px; width: 580px; height: 318px; border-radius: 30px; overflow: hidden;
        box-shadow: 0 40px 90px rgba(0, 0, 0, 0.5); }
      #m-badge img { width: 580px; height: 318px; }
      #m-brillance { position: absolute; left: -300px; top: 0; width: 160px; height: 318px; transform: skewX(-18deg);
        background: linear-gradient(90deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0)); }
      .verre.sv { width: 250px; height: 84px; padding: 0 18px; display: flex; align-items: center; gap: 14px; font-weight: 700; font-size: 24px; }
      .verre.sv .icoc { width: 48px; height: 48px; } .verre.sv .icoc .ico { width: 26px; height: 26px; }

      /* ---------- engagement ---------- */
      #e-mot { position: absolute; left: 0; right: 0; top: 380px; height: 170px; text-align: center; font-weight: 800; font-size: 150px; letter-spacing: 14px;
        color: #fff; white-space: nowrap; }
      #e-mot span { display: inline-block; }
      .bloc { width: 560px; height: 290px; padding: 34px 38px; display: flex; flex-direction: column; justify-content: center; gap: 12px; }
      .bloc .montant { font-weight: 800; font-size: 76px; letter-spacing: -1px; white-space: nowrap; }
      .bloc .lib { display: flex; align-items: center; gap: 12px; font-weight: 600; font-size: 28px; color: rgba(255, 255, 255, 0.8); }
      .bloc .lib .ico { width: 30px; height: 30px; color: #c9a8ff; }
      #b2 .montant { color: var(--or); }

      /* ---------- outils ---------- */
      #ou-fen { position: absolute; left: 430px; top: 150px; width: 1060px; height: 620px; border-radius: 26px; background: #fff; overflow: hidden;
        box-shadow: 0 40px 90px rgba(45, 15, 110, 0.25); transform-origin: 50% 100%; }
      #ou-barre { position: absolute; left: 60px; right: 60px; top: 70px; height: 92px; border-radius: 46px; border: 2.5px solid #e2dcef;
        display: flex; align-items: center; gap: 18px; padding: 0 30px; font-weight: 500; font-size: 32px; color: var(--encre); }
      #ou-barre .ico { width: 34px; height: 34px; color: var(--violet); }
      #ou-q { white-space: nowrap; }
      .outil { display: inline-flex; align-items: center; height: 58px; padding: 0 28px; border-radius: 29px; border: 2.5px solid #e2dcef; background: #fbfaff;
        font-weight: 700; font-size: 27px; color: var(--encre); }
      #ou-rep { position: absolute; left: 80px; right: 80px; top: 330px; display: flex; flex-direction: column; gap: 22px; }
      #ou-rep .sk { height: 18px; }

      /* ---------- temps ---------- */
      .agenda { width: 500px; height: 560px; padding: 26px; }
      .ag-t { display: flex; align-items: center; gap: 14px; font-weight: 800; font-size: 28px; margin-bottom: 18px; }
      .ag-l { display: flex; align-items: center; gap: 16px; height: 72px; border-top: 1.5px solid #efeaf7; }
      .ag-l b { width: 70px; font-weight: 600; font-size: 19px; color: #5d5869; }
      .ag-l span { flex: 1; height: 50px; position: relative; }
      .occ { position: absolute; inset: 0; border-radius: 12px; background: #eeeaf6; display: flex; align-items: center; padding: 0 14px;
        font-style: normal; font-weight: 600; font-size: 18px; color: #5d5869; }
      #tp-slot { position: absolute; left: 0; top: 0; height: 52px; border-radius: 14px; background: var(--violet); color: #fff; font-weight: 700;
        font-size: 22px; display: flex; align-items: center; justify-content: center; gap: 10px; box-shadow: 0 16px 34px rgba(99, 43, 197, 0.4); }

      /* ---------- question ---------- */
      #q-bulle { position: absolute; left: 700px; top: 250px; width: 900px; height: 330px; border-radius: 40px 40px 40px 10px; background: #fff;
        padding: 50px 60px; box-shadow: 0 30px 70px rgba(45, 15, 110, 0.22); font-weight: 700; font-size: 62px; line-height: 1.2; color: var(--encre); }
      #q-bulle span { display: inline-block; }
      #q-bulle .v { color: var(--violet); }
      .points { position: absolute; display: flex; gap: 12px; padding: 18px 24px; border-radius: 30px; background: #fff; box-shadow: 0 14px 30px rgba(45, 15, 110, 0.18); }
      .points i { display: block; width: 16px; height: 16px; border-radius: 50%; background: var(--violet-pale); }

      /* ---------- audit ---------- */
      #a-titre { position: absolute; left: 560px; top: 250px; width: 800px; height: 300px; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 6px; }
      #a-titre .grand { display: flex; align-items: baseline; gap: 26px; }
      #a-titre .grand b { font-weight: 800; font-size: 128px; letter-spacing: -2px; }
      #a-titre .grand i { font-family: "Instrument Serif", serif; font-style: italic; font-weight: 400; font-size: 140px; color: var(--violet); }
      #a-grille { position: absolute; left: 250px; top: 300px; width: 1420px; height: 470px; padding: 30px; display: grid; grid-template-columns: repeat(3, 1fr); gap: 26px;
        transform-origin: 50% 0%; }
      .zone { border-radius: 20px; background: #f7f4fc; padding: 26px; display: flex; flex-direction: column; gap: 18px; }
      .zone h5 { display: flex; align-items: center; gap: 14px; font-weight: 800; font-size: 30px; }
      .zone .sk { height: 14px; }
      .action { width: 880px; height: 88px; padding: 0 26px; display: flex; align-items: center; gap: 22px; }
      .num { display: flex; align-items: center; justify-content: center; width: 52px; height: 52px; border-radius: 50%; background: var(--violet); color: #fff;
        font-weight: 800; font-size: 26px; flex: none; }
      .action b { font-weight: 700; font-size: 27px; white-space: nowrap; }
      .action .sk { flex: 1; }

      /* ---------- cta ---------- */
      #c-nav { position: absolute; left: 1060px; top: 90px; }
      #c-fen { position: absolute; left: 230px; top: 110px; width: 1460px; height: 690px; border-radius: 24px; background: #fff; overflow: hidden;
        box-shadow: 0 40px 100px rgba(45, 15, 110, 0.28); transform-origin: 50% 50%; }
      #c-chrome { height: 50px; background: #f3effa; display: flex; align-items: center; gap: 9px; padding: 0 20px; }
      #c-chrome i { display: block; width: 13px; height: 13px; border-radius: 50%; background: #d9d2e8; }
      #c-chrome span { margin-left: 24px; height: 30px; width: 420px; border-radius: 15px; background: #fff; font-weight: 500; font-size: 16px; color: var(--gris);
        display: flex; align-items: center; padding: 0 16px; }
      #c-entete { height: 92px; display: flex; align-items: center; justify-content: space-between; padding: 0 48px; }
      #c-entete img { width: 150px; height: 57px; }
      #c-menu { display: flex; gap: 26px; height: 48px; padding: 0 30px; border-radius: 24px; background: #f0edf6; align-items: center; font-weight: 500; font-size: 18px; color: #8a8496; }
      #c-menu b { color: var(--violet); font-weight: 500; }
      #c-dem { height: 50px; padding: 0 26px; border-radius: 25px; background: var(--violet); color: #fff; font-weight: 700; font-size: 18px; display: flex; align-items: center; }
      #c-titre { position: absolute; left: 60px; top: 230px; font-weight: 500; font-size: 76px; letter-spacing: -1.5px; }
      #c-champ { position: absolute; left: 60px; top: 380px; width: 560px; height: 76px; border-radius: 14px; border: 2px solid #1b1530; display: flex; align-items: center;
        justify-content: space-between; padding: 0 24px; font-weight: 500; font-size: 22px; background: #fff; }
      #c-champ .ico { width: 26px; height: 26px; }
      #c-resa { position: absolute; left: 760px; top: 170px; width: 640px; height: 490px; padding: 30px; border-radius: 22px; background: #fff;
        box-shadow: 0 30px 70px rgba(45, 15, 110, 0.28); border: 1.5px solid #eee8f8; }
      #c-resa h6 { font-weight: 800; font-size: 32px; }
      .resa-g { display: flex; gap: 26px; margin-top: 22px; }
      .mini-cal { display: grid; grid-template-columns: repeat(7, 38px); gap: 8px; }
      .mini-cal b { height: 38px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 16px; color: var(--encre); background: #f6f3fb; }
      .mini-cal b.off { color: #c9c3d6; background: transparent; }
      .creneaux { display: flex; flex-direction: column; gap: 12px; width: 220px; }
      .creneaux b { height: 54px; border-radius: 12px; border: 2px solid #ddd5ee; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 21px; color: var(--violet); }
      #c-equipe { position: absolute; left: 30px; bottom: 26px; display: flex; align-items: center; gap: 12px; font-weight: 600; font-size: 19px; color: var(--gris); }
      #c-equipe .por { position: relative; width: 50px; height: 50px; border-width: 3px; margin-left: -18px; }
      #c-equipe .por:first-child { margin-left: 0; }

      /* ---------- capacité ---------- */
      .dossier { width: 300px; height: 330px; padding: 26px; display: flex; flex-direction: column; gap: 18px; }
      .prog { height: 12px; border-radius: 6px; background: rgba(255, 255, 255, 0.15); overflow: hidden; }
      .prog i { display: block; height: 12px; width: 100%; border-radius: 6px; background: linear-gradient(90deg, #a877ff, #6a3be8); transform-origin: 0 50%; }
      #k-cadre { position: absolute; left: 250px; top: 220px; width: 1420px; height: 430px; border-radius: 34px; border: 3px solid #a877ff; }
      #k-bouton { position: absolute; left: 660px; top: 480px; width: 600px; height: 120px; border-radius: 60px; background: linear-gradient(135deg, #7c4dff, #632bc5);
        color: #fff; display: flex; align-items: center; justify-content: center; gap: 18px; font-weight: 800; font-size: 40px; box-shadow: 0 30px 70px rgba(106, 59, 232, 0.55); }
      #k-bouton .ico { width: 40px; height: 40px; }

      /* ---------- fin ---------- */
      .fc { width: 300px; height: 300px; padding: 26px; display: flex; flex-direction: column; align-items: center; }
      .fc .por { position: relative; width: 140px; height: 140px; border-width: 4px; }
      .fc h3 { margin-top: 18px; font-weight: 800; font-size: 28px; letter-spacing: 1px; text-transform: uppercase; }
      .fc .barres i { background: rgba(255, 255, 255, 0.18); } .fc .barres i.on { background: #a877ff; }
      #f-badge { position: absolute; left: 815px; top: 110px; width: 290px; height: 290px; border-radius: 40px; overflow: hidden; box-shadow: 0 40px 90px rgba(106, 59, 232, 0.55); }
      #f-badge img { width: 290px; height: 290px; }
      #f-mot { position: absolute; left: 820px; top: 430px; width: 280px; height: 106px; }
      #f-bouton { position: absolute; left: 700px; top: 590px; width: 520px; height: 100px; border-radius: 50px; background: linear-gradient(135deg, #7c4dff, #632bc5);
        color: #fff; display: flex; align-items: center; justify-content: center; gap: 16px; font-weight: 800; font-size: 34px; box-shadow: 0 26px 60px rgba(106, 59, 232, 0.55); }
      #f-site { position: absolute; left: 0; right: 0; top: 730px; text-align: center; font-weight: 500; font-size: 28px; color: rgba(255, 255, 255, 0.8); }
      #flash { position: absolute; inset: 0; background: #fff; opacity: 0; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="oddysee-vsl-youtube" data-start="0" data-width="1920" data-height="1080" data-duration="%%DUREE%%">

      <!-- ===================== fond continu ===================== -->
      <section id="fond" class="clip" data-start="0" data-duration="%%DUREE%%" data-track-index="0">
        <img class="fond-img" id="fond-clair" src="assets/img/fond-clair.jpg" alt="" />
        <div class="halo" id="halo-1"></div>
        <div class="halo" id="halo-2"></div>
        <div class="halo" id="halo-3"></div>
        <img class="fond-img" id="fond-sombre" src="assets/img/fond-sombre.jpg" alt="" />
        <img id="logo-n" src="assets/img/logo-oddysee-noir.svg" alt="Oddysee" />
        <img id="logo-b" src="assets/img/logo-oddysee-blanc.svg" alt="Oddysee" />
      </section>

      <!-- ===================== S01 · accroche ===================== -->
      <section id="intro" class="clip" data-start="%%G:intro:debut%%" data-duration="%%G:intro:duree%%" data-track-index="1">
        <div class="g" id="g-intro">
          <div id="i-mot"><span>E</span><span>X</span><span>P</span><span>E</span><span>R</span><span>T</span><span>I</span><span>S</span><span>E</span></div>
          <div id="i-sous" class="h">change les résultats</div>
          <svg class="trait" viewBox="0 0 1920 1080">
            <defs>
              <linearGradient id="i-gc" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#a877ff" /><stop offset="1" stop-color="#632bc5" /></linearGradient>
              <linearGradient id="i-ga" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#a877ff" stop-opacity="0.45" /><stop offset="1" stop-color="#a877ff" stop-opacity="0" /></linearGradient>
            </defs>
            <path id="i-aire" d="%%COURBE_AIRE%%" fill="url(#i-ga)" opacity="0" />
            <line x1="300" y1="762" x2="1640" y2="762" stroke="#1b1530" stroke-opacity="0.18" stroke-width="2" />
            <path id="i-courbe" d="%%COURBE%%" fill="none" stroke="url(#i-gc)" stroke-width="9" stroke-linecap="round" />
            <circle class="i-nd" id="i-n0" r="13" fill="#fff" stroke="#632bc5" stroke-width="5" opacity="0" />
            <circle class="i-nd" id="i-n1" r="13" fill="#fff" stroke="#632bc5" stroke-width="5" opacity="0" />
            <circle class="i-nd" id="i-n2" r="13" fill="#fff" stroke="#632bc5" stroke-width="5" opacity="0" />
            <circle class="i-nd" id="i-n3" r="13" fill="#fff" stroke="#632bc5" stroke-width="5" opacity="0" />
            <circle id="i-tete" r="15" fill="#632bc5" stroke="#fff" stroke-width="5" opacity="0" />
          </svg>
        </div>
      </section>

      <!-- ===================== S02–S08 · quatre niveaux ===================== -->
      <section id="niv" class="clip" data-start="%%G:niv:debut%%" data-duration="%%G:niv:duree%%" data-track-index="2">
        <div class="g" id="g-niv">
          <div id="n-rang">
            <svg class="trait" viewBox="0 0 1920 1080"><path id="n-esc" d="M390 330 L390 300 L770 300 L770 260 L1150 260 L1150 220 L1530 220 L1530 190" fill="none" stroke="#a877ff" stroke-width="4" stroke-dasharray="2 12" stroke-linecap="round" opacity="0.8" /></svg>
            <div class="carte nc h" id="n-c0" style="left: 240px; top: 330px"><div class="por"><img src="assets/img/p-debutant.webp" alt="" /></div><h3>Débutant</h3><div class="barres"><i class="on"></i><i></i><i></i><i></i></div><span class="chipn">Niveau 1</span></div>
            <div class="carte nc h" id="n-c1" style="left: 620px; top: 290px"><div class="por"><img src="assets/img/p-amateur.webp" alt="" /></div><h3>Amateur</h3><div class="barres"><i class="on"></i><i class="on"></i><i></i><i></i></div><span class="chipn">Niveau 2</span></div>
            <div class="carte nc h" id="n-c2" style="left: 1000px; top: 250px"><div class="por"><img src="assets/img/p-pro.webp" alt="" /></div><h3>Professionnel</h3><div class="barres"><i class="on"></i><i class="on"></i><i class="on"></i><i></i></div><span class="chipn">Niveau 3</span></div>
            <div class="carte nc h" id="n-c3" style="left: 1380px; top: 210px"><div class="por"><img src="assets/img/p-expert.webp" alt="" /></div><h3>Expert</h3><div class="barres"><i class="on"></i><i class="on"></i><i class="on"></i><i class="on"></i></div><span class="chipn">Niveau 4</span></div>
            <div class="bulle h" id="n-b0" style="left: 278px; top: 254px">%%ICO:chat%%Plus de clients</div>
            <div class="bulle h" id="n-b1" style="left: 658px; top: 214px">%%ICO:chat%%Plus de clients</div>
            <div class="bulle h" id="n-b2" style="left: 1038px; top: 174px">%%ICO:chat%%Plus de clients</div>
            <div class="bulle h" id="n-b3" style="left: 1418px; top: 134px">%%ICO:chat%%Plus de clients</div>
          </div>
          <div class="pile" id="n-p0" style="left: 265px; top: 500px">
            <div class="dm h" style="top: 266px">%%ICO:mail%%Demande<em></em></div>
          </div>
          <div class="pile" id="n-p1" style="left: 645px; top: 500px">
            <div class="dm h" style="top: 266px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 232px">%%ICO:mail%%Demande<em></em></div>
          </div>
          <div class="pile" id="n-p2" style="left: 1025px; top: 500px">
            <div class="dm h" style="top: 266px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 232px">%%ICO:mail%%Demande<em></em></div>
            <div class="dm h" style="top: 198px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 164px">%%ICO:mail%%Demande<em></em></div>
          </div>
          <div class="pile" id="n-p3" style="left: 1405px; top: 500px">
            <div class="dm h" style="top: 266px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 232px">%%ICO:mail%%Demande<em></em></div>
            <div class="dm h" style="top: 198px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 164px">%%ICO:mail%%Demande<em></em></div>
            <div class="dm h" style="top: 130px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 96px">%%ICO:mail%%Demande<em></em></div>
            <div class="dm h" style="top: 62px">%%ICO:mail%%Demande<em></em></div><div class="dm h" style="top: 28px">%%ICO:mail%%Demande<em></em></div>
          </div>
          <div class="tag-illu h" id="n-illu" style="left: 1690px; top: 806px">Illustration</div>

          <!-- S05 · débutant -->
          <div class="demo" id="d0">
            <div class="win h" id="d0-w0" style="left: 470px; top: 280px"><div class="win-b"><i></i><i></i><i></i>&nbsp;Outil publicitaire</div><div class="win-c"><div class="sk" style="width: 70%"></div><div class="sk" style="width: 90%"></div><div class="sk" style="width: 55%"></div></div></div>
            <div class="win h" id="d0-w1" style="left: 690px; top: 360px"><div class="win-b"><i></i><i></i><i></i>&nbsp;Réseaux sociaux</div><div class="win-c"><div class="sk" style="width: 60%"></div><div class="sk" style="width: 85%"></div><div class="sk" style="width: 40%"></div></div></div>
            <div class="win h" id="d0-w2" style="left: 910px; top: 440px"><div class="win-b"><i></i><i></i><i></i>&nbsp;Tableau de suivi</div><div class="win-c"><div class="sk" style="width: 80%"></div><div class="sk" style="width: 50%"></div><div class="sk" style="width: 70%"></div></div></div>
            <div class="curseur h" id="d0-cur" style="left: 0; top: 0">%%CURSEUR%%</div>
          </div>
          <!-- S06 · amateur -->
          <div class="demo" id="d1">
            <div class="copie-cadre h" id="d1-cad1" style="left: 790px; top: 270px"></div>
            <div class="copie-cadre h" id="d1-cad2" style="left: 1250px; top: 270px"></div>
            <div class="carte post h" id="d1-p0" style="left: 330px; top: 270px"><div class="post-t"><i></i>Ta publication</div><div class="post-img">%%ICO:post%%</div><div class="sk" style="width: 85%"></div><div class="sk" style="width: 60%"></div></div>
            <div class="carte post h" id="d1-p1" style="left: 330px; top: 270px"><div class="post-t"><i></i>Ta publication</div><div class="post-img">%%ICO:post%%</div><div class="sk" style="width: 85%"></div><div class="sk" style="width: 60%"></div></div>
            <div class="carte post h" id="d1-p2" style="left: 330px; top: 270px"><div class="post-t"><i></i>Ta publication</div><div class="post-img">%%ICO:post%%</div><div class="sk" style="width: 85%"></div><div class="sk" style="width: 60%"></div></div>
            <div class="chipb h" id="d1-chip" style="position: absolute; left: 700px; top: 730px">%%ICO:doc%%Copier · coller</div>
          </div>
          <!-- S07 · professionnel -->
          <div class="demo" id="d2">
            <div class="carte h" id="d2-liste" style="left: 300px; top: 290px; width: 600px; height: 330px; padding: 20px 10px">
              <div class="liste-r"><span class="case" id="d2-k0">%%ICO:check%%</span>Publier chaque semaine</div>
              <div class="liste-r"><span class="case" id="d2-k1">%%ICO:check%%</span>Lancer une campagne</div>
              <div class="liste-r"><span class="case" id="d2-k2">%%ICO:check%%</span>Relancer les contacts</div>
            </div>
            <div class="carte h" id="d2-sem" style="left: 1000px; top: 250px; width: 620px; height: 420px">
              <div class="ag-t" style="padding: 22px 24px 0; margin: 0">%%ICO:cal%%Semaine</div>
              <div class="sem"><b>Lun</b><b>Mar</b><b>Mer</b><b>Jeu</b><b>Ven</b><span></span><span></span><span></span><span></span><span></span></div>
            </div>
            <div class="blk h" id="d2-b0" style="left: 1032px; top: 380px; width: 104px">Publier</div>
            <div class="blk h" id="d2-b1" style="left: 1260px; top: 470px; width: 104px">Campagne</div>
            <div class="blk h" id="d2-b2" style="left: 1488px; top: 560px; width: 104px">Relances</div>
          </div>
          <!-- S08 · expert -->
          <div class="demo" id="d3">
            <svg class="trait" viewBox="0 0 1920 1080"><path id="d3-lien" d="M1395 560 C 1300 620, 1180 560, 1100 500" fill="none" stroke="#632bc5" stroke-width="5" stroke-linecap="round" /></svg>
            <div class="por h" id="d3-g1" style="left: 400px; top: 330px; width: 130px; height: 130px"><img src="assets/img/p-g1.webp" alt="" /></div>
            <div class="por h" id="d3-g2" style="left: 560px; top: 560px; width: 120px; height: 120px"><img src="assets/img/p-g2.webp" alt="" /></div>
            <div class="por h" id="d3-g4" style="left: 640px; top: 250px; width: 110px; height: 110px"><img src="assets/img/p-g4.webp" alt="" /></div>
            <div class="por h" id="d3-g5" style="left: 1240px; top: 230px; width: 120px; height: 120px"><img src="assets/img/p-g5.webp" alt="" /></div>
            <div class="por h" id="d3-g6" style="left: 1440px; top: 300px; width: 110px; height: 110px"><img src="assets/img/p-g6.webp" alt="" /></div>
            <div class="por h" id="d3-g7" style="left: 300px; top: 560px; width: 110px; height: 110px"><img src="assets/img/p-g7.webp" alt="" /></div>
            <div class="por h" id="d3-g3" style="left: 1380px; top: 520px; width: 150px; height: 150px"><img src="assets/img/p-g3.webp" alt="" /></div>
            <div class="bulle h" id="d3-besoin" style="left: 1440px; top: 690px">%%ICO:cible%%Son vrai besoin</div>
            <div id="d3-offre" class="h">%%ICO:etoile%%<b>Ton entreprise</b></div>
            <div class="chipv h" id="d3-choix" style="position: absolute; left: 860px; top: 590px">%%ICO:check%%Choisie</div>
          </div>
        </div>
      </section>

      <!-- ===================== S09 · effets concrets ===================== -->
      <section id="effets" class="clip" data-start="%%G:effets:debut%%" data-duration="%%G:effets:duree%%" data-track-index="3">
        <div class="g" id="g-effets">
          <div class="onde h" id="e-o1" style="left: 790px; top: 230px; width: 340px; height: 340px"></div>
          <div class="onde h" id="e-o2" style="left: 790px; top: 230px; width: 340px; height: 340px"></div>
          <div class="por h" id="e-por" style="left: 810px; top: 250px; width: 300px; height: 300px"><img src="assets/img/p-dirigeant.webp" alt="" /></div>
          <div class="chipb h" id="e-chip" style="position: absolute; left: 812px; top: 590px">%%ICO:valise%%Chef d'entreprise</div>
          <svg class="trait" viewBox="0 0 1920 1080">
            <path id="e-l1" d="M560 400 L650 400" fill="none" stroke="#a877ff" stroke-width="4" stroke-dasharray="3 10" stroke-linecap="round" />
            <path id="e-l2" d="M1030 400 L1110 400" fill="none" stroke="#a877ff" stroke-width="4" stroke-dasharray="3 10" stroke-linecap="round" />
            <path id="e-l3" d="M1490 400 L1570 400" fill="none" stroke="#a877ff" stroke-width="4" stroke-dasharray="3 10" stroke-linecap="round" />
          </svg>
          <div class="carte kcard h" id="e-k1" style="left: 650px; top: 290px">
            <div class="ligne-c"><span class="icoc">%%ICO:mail%%</span><div><div class="titre-c">Nouvelle demande</div><div class="sous-c">Reçue à l'instant</div></div></div>
            <div class="sk" style="width: 90%"></div><div class="sk" style="width: 60%"></div>
          </div>
          <div class="carte kcard h" id="e-k2" style="left: 1110px; top: 290px">
            <div class="ligne-c"><span class="icoc">%%ICO:cal%%</span><div><div class="titre-c">Rendez-vous</div><div class="sous-c">Confirmé</div></div></div>
            <div class="ligne-c"><span class="ok">%%ICO:check%%</span><div class="sk" style="flex: 1"></div></div>
          </div>
          <div class="carte kcard h" id="e-k3" style="left: 1570px; top: 290px; width: 300px">
            <div class="ligne-c"><span class="icoc">%%ICO:euro%%</span><div><div class="titre-c">Paiement</div><div class="sous-c">Reçu</div></div></div>
            <div class="ligne-c"><span class="ok">%%ICO:check%%</span><div class="sk" style="flex: 1"></div></div>
          </div>
          <div class="chipn h" id="e-t1" style="position: absolute; left: 650px; top: 236px">Demandes</div>
          <div class="chipn h" id="e-t2" style="position: absolute; left: 1110px; top: 236px">Rendez-vous</div>
          <div class="chipn h" id="e-t3" style="position: absolute; left: 1570px; top: 236px">Clients</div>
          <div class="tag-illu h" id="e-illu" style="left: 1660px; top: 540px">Exemple</div>
        </div>
      </section>

      <!-- ===================== S10–S12 · douleur ===================== -->
      <section id="douleur" class="clip" data-start="%%G:douleur:debut%%" data-duration="%%G:douleur:duree%%" data-track-index="4">
        <div class="g" id="g-douleur">
          <svg class="trait" viewBox="0 0 1920 1080">
            <path id="dl-l1" d="M840 380 L700 330" stroke="rgba(255,255,255,0.35)" stroke-width="3" stroke-dasharray="3 9" fill="none" />
            <path id="dl-l2" d="M1080 340 L1180 270" stroke="rgba(255,255,255,0.35)" stroke-width="3" stroke-dasharray="3 9" fill="none" />
            <path id="dl-l3" d="M1080 440 L1200 520" stroke="rgba(255,255,255,0.35)" stroke-width="3" stroke-dasharray="3 9" fill="none" />
          </svg>
          <div class="por h" id="dl-por" style="left: 840px; top: 260px; width: 240px; height: 240px"><img src="assets/img/p-dirigeant.webp" alt="" /></div>
          <div class="verre vc h" id="dl-c1" style="left: 380px; top: 280px"><span class="icoc">%%ICO:euro%%</span>Budget publicitaire</div>
          <div class="verre vc h" id="dl-c2" style="left: 1180px; top: 210px"><span class="icoc">%%ICO:post%%</span>Publications</div>
          <div class="verre vc h" id="dl-c3" style="left: 1200px; top: 480px"><span class="icoc">%%ICO:user%%</span>Prestataire</div>
          <div class="carte h" id="dl-inbox" style="left: 1120px; top: 220px; width: 560px; height: 400px; padding: 28px">
            <div class="ligne-c"><span class="icoc">%%ICO:mail%%</span><div class="titre-c" style="font-size: 30px">Boîte de réception</div></div>
            <div style="margin-top: 56px; display: flex; flex-direction: column; align-items: center; gap: 16px; color: #b9b2c9">
              <svg class="ico" style="width: 86px; height: 86px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-6l-2 3h-4l-2-3H2"/><path d="M5.5 5h13L22 12v6a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-6z"/></svg>
              <div style="font-weight: 700; font-size: 28px; color: #8f88a3">Aucune nouvelle demande</div>
            </div>
          </div>
          <div class="bulle h" id="dl-quoi" style="left: 640px; top: 210px; font-size: 40px; height: 72px">?</div>

          <div class="verre cal h" id="dl-cal1" style="left: 640px; top: 170px"><div class="cal-t">Ce mois-ci<span class="chipv" style="height: 40px; font-size: 18px">Complet</span></div><div class="cal-g">%%CAL_PLEIN%%</div></div>
          <div class="verre cal h" id="dl-cal2" data-layout-allow-overlap style="left: 640px; top: 170px"><div class="cal-t">Le mois suivant<span class="sous-c" style="font-size: 20px">Vide</span></div><div class="cal-g">%%CAL_VIDE%%</div></div>
          <div class="facture h" id="dl-f1" data-layout-allow-overlap style="left: 690px; top: 330px"><span class="icoc">%%ICO:facture%%</span>Loyer</div>
          <div class="facture h" id="dl-f2" data-layout-allow-overlap style="left: 960px; top: 420px"><span class="icoc">%%ICO:facture%%</span>Salaires</div>
          <div class="facture h" id="dl-f3" data-layout-allow-overlap style="left: 760px; top: 520px"><span class="icoc">%%ICO:facture%%</span>Fournisseurs</div>
          <div id="dl-horloge" class="h"><i class="aig" id="dl-h"></i><i class="aig" id="dl-m"></i></div>
          <div class="por h" id="dl-por2" style="left: 260px; top: 250px; width: 220px; height: 220px"><img src="assets/img/p-dirigeant.webp" alt="" /></div>
          <div class="chipb h" id="dl-cherche" style="position: absolute; left: 210px; top: 500px">%%ICO:loupe%%Chercher des clients…</div>
          <div class="chipb h" id="dl-dev" style="position: absolute; left: 190px; top: 580px">%%ICO:graph%%Développer l'entreprise</div>
        </div>
      </section>

      <!-- ===================== S13 · Oddysee ===================== -->
      <section id="odd" class="clip" data-start="%%G:odd:debut%%" data-duration="%%G:odd:duree%%" data-track-index="5">
        <div class="g" id="g-odd">
          <div id="o-badge" class="h"><img src="assets/img/logo-onde.jpg" alt="Oddysee" /></div>
          <img id="o-mot" class="h" src="assets/img/logo-oddysee-blanc.svg" alt="Oddysee" />
          <div class="por h" id="o-p1" style="left: 360px; top: 230px; width: 230px; height: 230px"><img src="assets/img/p-alvarez.webp" alt="" /></div>
          <div class="nom h" id="o-n1" style="left: 300px; top: 485px; width: 350px"><b>Alvarez Mouko</b><span>Fondateur</span></div>
          <div class="por h" id="o-p2" style="left: 1340px; top: 170px; width: 180px; height: 180px"><img src="assets/img/p-hamza.webp" alt="" /></div>
          <div class="nom h" id="o-n2" style="left: 1280px; top: 365px; width: 300px"><b>Hamza Outmassint</b><span>Développeur</span></div>
          <div class="por h" id="o-p3" style="left: 1440px; top: 450px; width: 180px; height: 180px"><img src="assets/img/p-imad.webp" alt="" /></div>
          <div class="nom h" id="o-n3" style="left: 1380px; top: 645px; width: 300px"><b>Imad El Qadi</b><span>Développeur</span></div>
          <div id="flash"></div>
        </div>
      </section>

      <!-- ===================== S14–S15 · parcours ===================== -->
      <section id="parcours" class="clip" data-start="%%G:parcours:debut%%" data-duration="%%G:parcours:duree%%" data-track-index="6">
        <div class="g" id="g-parcours">
          <svg class="trait" viewBox="0 0 1920 1080"><path id="p-chemin" d="M90 430 C 180 360, 220 470, 270 430 M650 430 L 770 430 M1150 430 L 1270 430" fill="none" stroke="#632bc5" stroke-width="5" stroke-linecap="round" stroke-dasharray="4 12" /></svg>
          <div class="carte pc h" id="p-c1" style="left: 270px; top: 250px"><div class="pc-vig"><img src="assets/img/site-hero.jpg" alt="" /></div><div class="ligne-c"><span class="icoc">%%ICO:oeil%%</span><div class="titre-c">Découvrir</div></div><div class="sk" style="width: 80%"></div></div>
          <div class="carte pc h" id="p-c2" style="left: 770px; top: 250px"><div class="pc-vig" style="padding: 22px; display: flex; flex-direction: column; gap: 14px"><div class="sk" style="width: 55%; height: 18px; background: #d9cdf3"></div><div class="sk" style="width: 90%"></div><div class="sk" style="width: 75%"></div><div class="sk" style="width: 82%"></div></div><div class="ligne-c"><span class="icoc">%%ICO:doc%%</span><div class="titre-c">Comprendre</div></div><div class="sk" style="width: 70%"></div></div>
          <div class="carte pc h" id="p-c3" style="left: 1270px; top: 250px"><div class="pc-vig" style="padding: 22px; display: flex; flex-direction: column; gap: 12px; background: #fff; border: 2px solid #f0ebf8"><div class="champ"></div><div class="champ"></div><div class="bouton">Envoyer</div></div><div class="ligne-c"><span class="icoc">%%ICO:chat%%</span><div class="titre-c">Contacter</div></div><div class="sk" style="width: 60%"></div></div>
          <div class="por h" id="p-v1" style="left: 0; top: 0; width: 64px; height: 64px; border-width: 3px"><img src="assets/img/p-g2.webp" alt="" /></div>
          <div class="por h" id="p-v2" style="left: 0; top: 0; width: 64px; height: 64px; border-width: 3px"><img src="assets/img/p-g4.webp" alt="" /></div>
          <div class="notif h" id="p-notif" style="left: 1330px; top: 170px"><span class="icoc">%%ICO:mail%%</span><div><b>Nouvelle demande</b><span>Formulaire du site</span></div></div>

          <div class="carte sit h" id="p-s1" style="left: 200px; top: 250px"><div class="sit-fond" style="background: linear-gradient(150deg, #f7f3ff, #e2d7f7)"></div><div class="por" style="left: 140px; top: 40px; width: 160px; height: 160px"><img src="assets/img/p-dirigeant.webp" alt="" /></div><div class="sit-l"><span class="icoc">%%ICO:valise%%</span>Au travail</div></div>
          <div class="carte sit h" id="p-s2" style="left: 740px; top: 250px"><div class="sit-fond" style="background: linear-gradient(150deg, #ffe9dc, #f6d3f0)"></div><div style="position: absolute; left: 170px; top: 60px; color: #d94f8a"><svg viewBox="0 0 24 24" style="width: 100px; height: 100px" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20.8 4.6a5.5 5.5 0 0 0-7.8 0L12 5.7l-1-1.1a5.5 5.5 0 0 0-7.8 7.8l1 1.1L12 21l7.8-7.5 1-1.1a5.5 5.5 0 0 0 0-7.8z"/></svg></div><div class="sit-l"><span class="icoc">%%ICO:maison%%</span>Avec tes proches</div></div>
          <div class="carte sit h" id="p-s3" style="left: 1280px; top: 250px"><img class="sit-fond" src="assets/img/ciel.jpg" alt="" style="width: 440px; height: 330px; object-fit: cover; object-position: 50% 35%" /><div class="sit-l" style="color: #fff"><span class="icoc" style="background: rgba(255,255,255,0.25); color: #fff">%%ICO:lune%%</span>Pendant que tu dors</div></div>
          <div class="notif h" id="p-n1" style="left: 250px; top: 196px"><span class="icoc">%%ICO:mail%%</span><div><b>Nouvelle demande</b></div></div>
          <div class="notif h" id="p-n2" style="left: 790px; top: 196px"><span class="icoc">%%ICO:mail%%</span><div><b>Nouvelle demande</b></div></div>
          <div class="notif h" id="p-n3" style="left: 1330px; top: 196px"><span class="icoc">%%ICO:mail%%</span><div><b>Nouvelle demande</b></div></div>
        </div>
      </section>

      <!-- ===================== S16–S18 · preuves ===================== -->
      <section id="preuves" class="clip" data-start="%%G:preuves:debut%%" data-duration="%%G:preuves:duree%%" data-track-index="7">
        <div class="g" id="g-preuves">
          <div class="chipb h" id="r-titre" style="position: absolute; left: 790px; top: 130px">%%ICO:etoile%%Nos réalisations</div>
          <div class="carte tuile h" id="r-t0" style="left: 430px; top: 210px"><img src="assets/img/proj-montessorie-mockup.webp" alt="" /><b>Planète Montessori</b></div>
          <div class="carte tuile h" id="r-t1" style="left: 810px; top: 210px"><img src="assets/img/proj-hubwell-mockup.webp" alt="" /><b>Hubwell</b></div>
          <div class="carte tuile h" id="r-t2" style="left: 1190px; top: 210px"><img src="assets/img/proj-caravanserai-mockup.webp" alt="" /><b>Caravan Seraï</b></div>
          <div class="carte tuile h" id="r-t3" style="left: 620px; top: 540px; height: 260px"><img src="assets/img/proj-azergtours-mockup.webp" alt="" style="height: 200px" /><b>Azergtours</b></div>
          <div class="carte tuile h" id="r-t4" style="left: 1000px; top: 540px; height: 260px"><img src="assets/img/proj-ngbm-mockup.webp" alt="" style="height: 200px" /><b>NGBM</b></div>
          <div class="chipv h" id="r-ag" style="position: absolute; left: 1540px; top: 300px">Grandes agences</div>
          <div class="chipv h" id="r-inf" style="position: absolute; left: 1540px; top: 380px">Influenceurs</div>

          <div class="carte sect h" id="r-s0" style="left: 210px; top: 230px"><span class="icoc">%%ICO:formation%%</span><h4>Formation</h4></div>
          <div class="carte sect h" id="r-s1" style="left: 725px; top: 230px"><span class="icoc">%%ICO:panier%%</span><h4>E-commerce</h4></div>
          <div class="carte sect h" id="r-s2" style="left: 1240px; top: 230px"><span class="icoc">%%ICO:immeuble%%</span><h4>Immobilier</h4><div class="sect-v"><img src="assets/img/proj-hubwell-capture.webp" alt="" /></div></div>
          <div class="carte sect h" id="r-s3" style="left: 210px; top: 470px"><span class="icoc">%%ICO:croix%%</span><h4>Établissements hospitaliers</h4><div class="sect-v"><img class="logo" src="assets/img/ref-clinic-chifa.svg" alt="" /></div></div>
          <div class="carte sect h" id="r-s4" style="left: 725px; top: 470px"><span class="icoc">%%ICO:ecole%%</span><h4>Écoles</h4><div class="sect-v"><img src="assets/img/proj-montessorie-capture.webp" alt="" /></div></div>
          <div class="carte sect h" id="r-s5" style="left: 1240px; top: 470px"><span class="icoc">%%ICO:magasin%%</span><h4>Centres commerciaux</h4><div class="sect-v"><img class="logo" src="assets/img/ref-menaramall.svg" alt="" /></div></div>

          <div class="chipb h" id="r-titre2" style="position: absolute; left: 800px; top: 250px">%%ICO:etoile%%Nos références</div>
          <div class="carte ref h" id="r-l0" style="left: 210px; top: 380px"><img src="assets/img/ref-adidas.svg" alt="Adidas" /></div>
          <div class="carte ref h" id="r-l1" style="left: 590px; top: 380px"><img src="assets/img/ref-puma.svg" alt="Puma" /></div>
          <div class="carte ref h" id="r-l2" style="left: 970px; top: 380px"><img src="assets/img/ref-pmis.svg" alt="Planète Montessori" /></div>
          <div class="carte ref h" id="r-l3" style="left: 1350px; top: 380px"><img src="assets/img/ref-menaramall.svg" alt="Menara Mall" /></div>
        </div>
      </section>

      <!-- ===================== S19 · Meta ===================== -->
      <section id="meta" class="clip" data-start="%%G:meta:debut%%" data-duration="%%G:meta:duree%%" data-track-index="8">
        <div class="g" id="g-meta">
          <svg class="trait" viewBox="0 0 1920 1080">
            <path id="m-arc" d="M1250 300 C 1340 220, 1400 240, 1440 300" fill="none" stroke="#a877ff" stroke-width="4" stroke-dasharray="4 10" stroke-linecap="round" />
            <path id="m-c1" d="M560 640 C 900 640, 1100 640, 1330 640" fill="none" stroke="rgba(255,255,255,0.45)" stroke-width="3" />
            <path id="m-c2" d="M860 640 L 1330 640" fill="none" stroke="rgba(255,255,255,0.0)" stroke-width="3" />
          </svg>
          <div id="m-badge" class="h"><img src="assets/img/meta-partner.png" alt="Meta Business Partner" /><div id="m-brillance"></div></div>
          <div class="chipv h" id="m-ans" style="position: absolute; left: 820px; top: 490px">%%ICO:etoile%%Depuis plus de 5 ans</div>
          <div class="verre h" id="m-dublin" style="left: 1400px; top: 300px; width: 330px; height: 120px; padding: 0 22px; display: flex; align-items: center; gap: 16px">
            <span class="icoc">%%ICO:pin%%</span><div><div class="titre-c">Dublin</div><div class="sous-c">Auprès des équipes Meta</div></div></div>
          <div class="verre sv h" id="m-s1" style="left: 300px; top: 600px"><span class="icoc">%%ICO:cible%%</span>Attirer</div>
          <div class="verre sv h" id="m-s2" style="left: 600px; top: 600px"><span class="icoc">%%ICO:chat%%</span>Convaincre</div>
          <div class="verre sv h" id="m-s3" style="left: 900px; top: 600px"><span class="icoc">%%ICO:check%%</span>Convertir</div>
          <div class="chipv h" id="m-but" style="position: absolute; left: 1330px; top: 614px">%%ICO:graph%%Développer la clientèle</div>
        </div>
      </section>

      <!-- ===================== S20–S22 · engagement ===================== -->
      <section id="engage" class="clip" data-start="%%G:engage:debut%%" data-duration="%%G:engage:duree%%" data-track-index="9">
        <div class="g" id="g-engage">
          <div class="por h" id="g-alv" style="left: 870px; top: 150px; width: 180px; height: 180px"><img src="assets/img/p-alvarez.webp" alt="" /></div>
          <div id="e-mot"><span>E</span><span>N</span><span>G</span><span>A</span><span>G</span><span>E</span><span>M</span><span>E</span><span>N</span><span>T</span></div>
          <div class="verre bloc h" id="b1" style="left: 300px; top: 260px"><div class="montant">3 000 000 DH</div><div class="lib">%%ICO:immeuble%%Investis dans ton entreprise</div></div>
          <div class="verre bloc h" id="b2" style="left: 1060px; top: 260px"><div class="montant">1 000 €</div><div class="lib">%%ICO:cible%%Pour une stratégie clients</div></div>
          <div class="bulle h" id="b-q" style="left: 905px; top: 600px; font-size: 40px; height: 72px">?</div>
          <div class="chipv h" id="g-prets" style="position: absolute; left: 740px; top: 190px">%%ICO:check%%Dirigeants prêts à agir</div>
          <div class="verre vc h" id="g-strat" style="left: 420px; top: 400px; width: 380px"><span class="icoc">%%ICO:doc%%</span>Budget stratégie</div>
          <div class="verre vc h" id="g-pub" style="left: 1120px; top: 400px; width: 380px"><span class="icoc">%%ICO:pub%%</span>Budget publicité</div>
          <div class="chipv h" id="g-but" style="position: absolute; left: 790px; top: 640px; height: 72px; font-size: 30px; border-radius: 36px">%%ICO:graph%%Développer la clientèle</div>
        </div>
      </section>

      <!-- ===================== S23 · outils ===================== -->
      <section id="outils" class="clip" data-start="%%G:outils:debut%%" data-duration="%%G:outils:duree%%" data-track-index="10">
        <div class="g" id="g-outils">
          <div id="ou-fen" class="h">
            <div id="ou-barre">%%ICO:loupe%%<span id="ou-q">Comment trouver plus de clients ?</span></div>
            <div style="position: absolute; left: 80px; top: 200px; display: flex; gap: 20px">
              <span class="outil h" id="ou-1">ChatGPT</span><span class="outil h" id="ou-2">Claude</span><span class="outil h" id="ou-3">Google</span>
            </div>
            <div id="ou-rep"><div class="sk h" style="width: 92%"></div><div class="sk h" style="width: 84%"></div><div class="sk h" style="width: 88%"></div><div class="sk h" style="width: 60%"></div></div>
          </div>
        </div>
      </section>

      <!-- ===================== S24 · temps ===================== -->
      <section id="temps" class="clip" data-start="%%G:temps:debut%%" data-duration="%%G:temps:duree%%" data-track-index="11">
        <div class="g" id="g-temps">
          <div class="carte agenda h" id="tp-a1" style="left: 300px; top: 200px"><div class="ag-t"><span class="icoc">%%ICO:cal%%</span>Ton agenda</div>%%AG_TOI%%</div>
          <div class="carte agenda h" id="tp-a2" style="left: 1120px; top: 200px"><div class="ag-t"><span class="icoc">%%ICO:cal%%</span>Agenda Oddysee</div>%%AG_ODD%%</div>
          <div id="tp-slot" class="h" data-layout-allow-overlap data-layout-allow-occlusion style="left: 400px; top: 444px; width: 1120px">%%ICO:check%%Séance de travail · ton entreprise</div>
          <div class="chipb h" id="tp-c1" style="position: absolute; left: 380px; top: 130px">%%ICO:horloge%%Ton temps</div>
          <div class="chipb h" id="tp-c2" style="position: absolute; left: 1250px; top: 130px">%%ICO:horloge%%Le nôtre aussi</div>
        </div>
      </section>

      <!-- ===================== S25 · question ===================== -->
      <section id="question" class="clip" data-start="%%G:question:debut%%" data-duration="%%G:question:duree%%" data-track-index="12">
        <div class="g" id="g-question">
          <div class="por h" id="q-por" style="left: 330px; top: 300px; width: 260px; height: 260px"><img src="assets/img/p-dirigeant.webp" alt="" /></div>
          <div class="points h" id="q-pts" style="left: 560px; top: 250px"><i></i><i></i><i></i></div>
          <div id="q-bulle" class="h"><span id="q0">«&#8239;Qu’est-ce</span> <span id="q1">que</span> <span id="q2">vous</span> <span id="q3">pourriez</span> <span id="q4">faire</span> <span id="q5">pour</span> <span id="q6" class="v">mon</span> <span id="q7" class="v">entreprise&#8239;?&#8239;»</span></div>
        </div>
      </section>

      <!-- ===================== S26–S28 · audit ===================== -->
      <section id="audit" class="clip" data-start="%%G:audit:debut%%" data-duration="%%G:audit:duree%%" data-track-index="13">
        <div class="g" id="g-audit">
          <div id="a-titre" class="h"><span class="chipv" style="height: 44px; font-size: 20px">%%ICO:loupe%%Regardons ensemble</span><div class="grand"><b>Audit</b><i>gratuit</i></div></div>
          <div class="carte h" id="a-grille">
            <div class="zone" id="a-z0"><h5><span class="icoc">%%ICO:graph%%</span>Situation</h5><div class="sk" style="width: 90%"></div><div class="sk" style="width: 70%"></div><div class="sk" style="width: 80%"></div><div class="sk" style="width: 55%"></div></div>
            <div class="zone" id="a-z1"><h5><span class="icoc">%%ICO:eclair%%</span>Blocages</h5><div class="sk" style="width: 75%"></div><div class="sk" style="width: 88%"></div><div class="sk" style="width: 60%"></div><div class="sk" style="width: 70%"></div></div>
            <div class="zone" id="a-z2"><h5><span class="icoc">%%ICO:etoile%%</span>Opportunités</h5><div class="sk" style="width: 85%"></div><div class="sk" style="width: 65%"></div><div class="sk" style="width: 78%"></div><div class="sk" style="width: 50%"></div></div>
          </div>
          <div class="carte action h" id="a-x1" style="left: 300px; top: 250px"><span class="num">1</span><b>Action prioritaire</b><div class="sk"></div></div>
          <div class="carte action h" id="a-x2" style="left: 300px; top: 370px"><span class="num">2</span><b>Action prioritaire</b><div class="sk"></div></div>
          <div class="carte action h" id="a-x3" style="left: 300px; top: 490px"><span class="num">3</span><b>Action prioritaire</b><div class="sk"></div></div>
          <div class="notif h" id="a-msg" style="left: 1280px; top: 330px"><span class="icoc">%%ICO:mail%%</span><div><b>Nouvelle demande</b><span>Prospect intéressé</span></div></div>
          <div class="notif h" id="a-rdv" style="left: 1280px; top: 450px"><span class="icoc" style="background: #1fa855">%%ICO:check%%</span><div><b>Rendez-vous confirmé</b><span>Nouveau client</span></div></div>
        </div>
      </section>

      <!-- ===================== S29 · clic ===================== -->
      <section id="cta" class="clip" data-start="%%G:cta:debut%%" data-duration="%%G:cta:duree%%" data-track-index="14">
        <div class="g" id="g-cta">
          <div id="c-fen" class="h">
            <div id="c-chrome"><i></i><i></i><i></i><span>oddysee.fr/contact</span></div>
            <div id="c-entete"><img src="assets/img/logo-oddysee-noir.svg" alt="Oddysee" /><div id="c-menu"><span>Accueil</span><span>À propos</span><span>Services</span><span>Projets</span><b>Contact</b></div><div id="c-dem">Démarrer maintenant</div></div>
            <div id="c-titre">Prêt à parler ?</div>
            <div id="c-champ">Vérifiez si on peut travailler avec vous %%ICO:fleche%%</div>
            <div id="c-resa" class="h">
              <h6>Réserve ton audit</h6>
              <div class="resa-g">
                <div class="mini-cal">
                  <b class="off">L</b><b class="off">M</b><b class="off">M</b><b class="off">J</b><b class="off">V</b><b class="off">S</b><b class="off">D</b>
                  <b>2</b><b>3</b><b>4</b><b>5</b><b id="c-jour">6</b><b class="off">7</b><b class="off">8</b>
                  <b>9</b><b>10</b><b>11</b><b>12</b><b>13</b><b class="off">14</b><b class="off">15</b>
                  <b>16</b><b>17</b><b>18</b><b>19</b><b>20</b><b class="off">21</b><b class="off">22</b>
                </div>
                <div class="creneaux"><b>10:00</b><b id="c-slot">11:30</b><b>15:00</b></div>
              </div>
              <div id="c-equipe"><span class="por"><img src="assets/img/p-alvarez.webp" alt="" /></span><span class="por"><img src="assets/img/p-hamza.webp" alt="" /></span><span class="por"><img src="assets/img/p-imad.webp" alt="" /></span>&nbsp;Avec l'équipe Oddysee</div>
            </div>
          </div>
          <div class="chipv h" id="c-desc" style="position: absolute; left: 1380px; top: 740px">%%ICO:fleche%%Lien dans la description</div>
          <div class="tag-illu h" id="c-illu" style="left: 240px; top: 812px">Illustration du parcours de réservation</div>
          <div class="curseur h" id="c-cur" style="left: 0; top: 0">%%CURSEUR%%</div>
        </div>
      </section>

      <!-- ===================== S30–S31 · capacité ===================== -->
      <section id="capa" class="clip" data-start="%%G:capa:debut%%" data-duration="%%G:capa:duree%%" data-track-index="15">
        <div class="g" id="g-capa">
          <div id="k-cadre" class="h"></div>
          <div class="chipv h" id="k-chip" style="position: absolute; left: 610px; top: 192px">%%ICO:check%%Accompagnement limité pour préserver la qualité</div>
          <div class="verre dossier h" id="k-d0" style="left: 300px; top: 270px"><span class="icoc">%%ICO:dossier%%</span><div class="titre-c">Dossier suivi</div><div class="sk" style="width: 80%"></div><div class="sk" style="width: 60%"></div><div class="prog"><i></i></div></div>
          <div class="verre dossier h" id="k-d1" style="left: 640px; top: 270px"><span class="icoc">%%ICO:dossier%%</span><div class="titre-c">Dossier suivi</div><div class="sk" style="width: 70%"></div><div class="sk" style="width: 85%"></div><div class="prog"><i></i></div></div>
          <div class="verre dossier h" id="k-d2" style="left: 980px; top: 270px"><span class="icoc">%%ICO:dossier%%</span><div class="titre-c">Dossier suivi</div><div class="sk" style="width: 90%"></div><div class="sk" style="width: 50%"></div><div class="prog"><i></i></div></div>
          <div class="verre dossier h" id="k-d3" style="left: 1320px; top: 270px"><span class="icoc">%%ICO:dossier%%</span><div class="titre-c">Dossier suivi</div><div class="sk" style="width: 65%"></div><div class="sk" style="width: 75%"></div><div class="prog"><i></i></div></div>
          <div id="k-bouton" class="h">%%ICO:cal%%Réserve ton audit</div>
          <div class="curseur h" id="k-cur" style="left: 0; top: 0">%%CURSEUR%%</div>
        </div>
      </section>

      <!-- ===================== S32 · conclusion ===================== -->
      <section id="fin" class="clip" data-start="%%G:fin:debut%%" data-duration="%%G:fin:duree%%" data-track-index="16">
        <div class="g" id="g-fin">
          <div class="verre fc h" id="f-c0" style="left: 240px; top: 330px"><div class="por"><img src="assets/img/p-debutant.webp" alt="" /></div><h3>Débutant</h3><div class="barres"><i class="on"></i><i></i><i></i><i></i></div></div>
          <div class="verre fc h" id="f-c1" style="left: 620px; top: 290px"><div class="por"><img src="assets/img/p-amateur.webp" alt="" /></div><h3>Amateur</h3><div class="barres"><i class="on"></i><i class="on"></i><i></i><i></i></div></div>
          <div class="verre fc h" id="f-c2" style="left: 1000px; top: 250px"><div class="por"><img src="assets/img/p-pro.webp" alt="" /></div><h3>Professionnel</h3><div class="barres"><i class="on"></i><i class="on"></i><i class="on"></i><i></i></div></div>
          <div class="verre fc h" id="f-c3" style="left: 1380px; top: 210px"><div class="por"><img src="assets/img/p-expert.webp" alt="" /></div><h3>Expert</h3><div class="barres"><i class="on"></i><i class="on"></i><i class="on"></i><i class="on"></i></div></div>
          <div id="f-badge" class="h"><img src="assets/img/logo-onde.jpg" alt="Oddysee" /></div>
          <img id="f-mot" class="h" src="assets/img/logo-oddysee-blanc.svg" alt="Oddysee" />
          <div id="f-bouton" class="h">%%ICO:cal%%Réserve ton audit</div>
          <div id="f-site" class="h">oddysee.fr · lien dans la description</div>
        </div>
      </section>

      <audio id="voix" src="voix.mp3" data-start="0" data-duration="201.25" data-track-index="30" data-volume="1"></audio>

      <!-- ===================== sous-titres intégrés ===================== -->
      <section id="sous-titres" class="clip" data-start="0" data-duration="%%DUREE%%" data-track-index="20">
        <div id="sous">
        %%SOUS%%
        </div>
      </section>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const D = %%DATA%%;
      const G = D.G;
      const tl = gsap.timeline({ paused: true });
      const T = (l, k = 0) => { const a = D.L[l]; return a[k < 0 ? a.length + k : k][0]; };
      const E = (l, k = -1) => { const a = D.L[l]; return a[k < 0 ? a.length + k : k][1]; };
      const FONDU = 0.4;

      // ---------- outils ----------
      function inn(sel, t, o) {
        o = o || {};
        tl.fromTo(sel, { autoAlpha: 0, y: o.y === undefined ? 26 : o.y, x: o.x || 0, scale: o.s === undefined ? 1 : o.s },
          { autoAlpha: 1, y: 0, x: 0, scale: 1, duration: o.d || 0.45, ease: o.ease || "power3.out", stagger: o.st || 0 }, t);
      }
      function pop(sel, t, o) {
        o = o || {};
        tl.fromTo(sel, { autoAlpha: 0, scale: o.de || 0.5 }, { autoAlpha: 1, scale: 1, duration: o.d || 0.4, ease: "back.out(2.2)", stagger: o.st || 0 }, t);
      }
      function out(sel, t, o) {
        o = o || {};
        tl.to(sel, { autoAlpha: 0, y: o.y || 0, x: o.x || 0, scale: o.s === undefined ? 1 : o.s, duration: o.d || 0.3, ease: "power2.in", stagger: o.st || 0 }, t);
      }
      function trace(sel, t, d, ease) {
        document.querySelectorAll(sel).forEach((p) => {
          const L = p.getTotalLength();
          tl.set(p, { strokeDasharray: L + " " + L, strokeDashoffset: L }, 0);
          tl.to(p, { strokeDashoffset: 0, duration: d || 0.7, ease: ease || "power2.inOut" }, t);
        });
      }
      function traceTirets(sel, t, d) {  // traits en pointillés : révélés par un masque d'opacité progressif
        tl.fromTo(sel, { opacity: 0 }, { opacity: 1, duration: d || 0.5, ease: "power1.out" }, t);
      }
      function clic(cur, t, cible) {
        tl.to(cur, { scale: 0.82, duration: 0.08, ease: "power2.out", yoyo: true, repeat: 1 }, t);
        if (cible) tl.to(cible, { scale: 0.95, duration: 0.08, ease: "power2.out", yoyo: true, repeat: 1 }, t);
      }
      function vers(cur, t, x, y, d, ease) { tl.to(cur, { x: x, y: y, duration: d || 0.5, ease: ease || "power2.inOut" }, t); }

      // ---------- fondus entre groupes et thème ----------
      const noms = Object.keys(G);
      noms.forEach((n, i) => {
        const g = "#g-" + n;
        if (i > 0) tl.fromTo(g, { autoAlpha: 0 }, { autoAlpha: 1, duration: 2 * FONDU, ease: "power1.inOut" }, G[n].coupe - FONDU);
        if (i < noms.length - 1) tl.to(g, { autoAlpha: 0, duration: 2 * FONDU, ease: "power1.inOut" }, G[noms[i + 1]].coupe - FONDU);
      });
      noms.forEach((n, i) => {
        if (i === 0) return;
        const prec = G[noms[i - 1]].theme, th = G[n].theme;
        if (prec === th) return;
        const s = th === "sombre";
        const t0 = G[n].coupe - 0.5;
        tl.to("#fond-sombre", { opacity: s ? 1 : 0, duration: 1.0, ease: "power1.inOut" }, t0);
        tl.to("#logo-n", { opacity: s ? 0 : 1, duration: 0.8 }, t0);
        tl.to("#logo-b", { opacity: s ? 1 : 0, duration: 0.8 }, t0);
        tl.to("#sous", { "--txt": s ? "#ffffff" : "#1b1530", "--cle": s ? "#c9a8ff" : "#632bc5", duration: 0.8 }, t0);
      });
      // logo discret masqué quand le logo est déjà au centre de l'image
      tl.to("#logo-b", { opacity: 0, duration: 0.4 }, G.odd.coupe);
      tl.to("#logo-b", { opacity: 0, duration: 0.4 }, G.fin.coupe);
      // halos qui dérivent lentement (fini)
      tl.to("#halo-1", { x: 260, y: 140, duration: 34, ease: "sine.inOut", yoyo: true, repeat: 5 }, 0);
      tl.to("#halo-2", { x: -320, y: -160, duration: 41, ease: "sine.inOut", yoyo: true, repeat: 4 }, 0);
      tl.to("#halo-3", { x: 340, y: 120, duration: 29, ease: "sine.inOut", yoyo: true, repeat: 6 }, 0);

      // ---------- S01 · accroche ----------
      tl.from("#i-mot span", { autoAlpha: 0, y: 50, duration: 0.5, ease: "power3.out", stagger: 0.06 }, 0.05);
      {
        const p = document.querySelector("#i-courbe"), L = p.getTotalLength(), tete = document.querySelector("#i-tete");
        const ns = [0.18, 0.42, 0.66, 0.9].map((f) => p.getPointAtLength(L * f));
        ns.forEach((pt, i) => { const c = document.querySelector("#i-n" + i); c.setAttribute("cx", pt.x); c.setAttribute("cy", pt.y); });
        const pr = { v: 0 };
        const maj = () => {
          const pt = p.getPointAtLength(L * pr.v);
          p.style.strokeDashoffset = L * (1 - pr.v);
          tete.setAttribute("cx", pt.x); tete.setAttribute("cy", pt.y);
          document.querySelector("#i-aire").setAttribute("opacity", (0.95 * pr.v).toFixed(3));
        };
        tl.set(p, { strokeDasharray: L + " " + L, strokeDashoffset: L }, 0);
        tl.set(tete, { opacity: 1 }, T(0, 10));
        tl.to(pr, { v: 0.38, duration: T(0, 14) - T(0, 10), ease: "none", onUpdate: maj }, T(0, 10));
        tl.to(pr, { v: 1, duration: 0.55, ease: "power3.in", onUpdate: maj }, T(0, 14));
        [0.18, 0.42, 0.66, 0.9].forEach((f, i) => {
          const t = f <= 0.38 ? T(0, 10) + (T(0, 14) - T(0, 10)) * (f / 0.38) : T(0, 14) + 0.55 * Math.pow((f - 0.38) / 0.62, 1 / 3);
          tl.fromTo("#i-n" + i, { opacity: 0, scale: 0.2, transformOrigin: "50% 50%" }, { opacity: 1, scale: 1, duration: 0.3, ease: "back.out(3)" }, t);
        });
        tl.to(tete, { scale: 1.6, transformOrigin: "50% 50%", duration: 0.18, yoyo: true, repeat: 1 }, T(0, 14) + 0.55);
      }
      inn("#i-sous", T(0, 11), { y: 14 });

      // ---------- S02–S08 · niveaux ----------
      [3, 4, 6, 8].forEach((k, i) => inn("#n-c" + i, T(1, k) - 0.05, { y: 60, d: 0.5, ease: "back.out(1.6)" }));
      traceTirets("#n-esc", T(1, 3), 2.6);
      tl.to("#n-rang", { y: 26, duration: 0.6, ease: "power2.inOut" }, T(2, 0));
      pop("#n-b0, #n-b1, #n-b2, #n-b3", T(2, 11), { de: 0.6 });
      // les bulles deviennent des piles de demandes
      out("#n-b0, #n-b1, #n-b2, #n-b3", T(3, 0) - 0.1, { y: -10 });
      tl.to("#n-rang", { y: -120, duration: 0.6, ease: "power3.inOut" }, T(3, 0) - 0.1);
      tl.to(".nc", { scale: 0.78, transformOrigin: "50% 0%", duration: 0.6, ease: "power3.inOut" }, T(3, 0) - 0.1);
      tl.to("#n-esc", { opacity: 0, duration: 0.3 }, T(3, 0) - 0.1);
      ["#n-p0", "#n-p1", "#n-p2", "#n-p3"].forEach((p, i) => {
        inn(p + " .dm", T(3, 5) + i * 0.32, { y: 22, d: 0.28, st: 0.07, ease: "back.out(2)" });
      });
      inn("#n-illu", T(3, 6), { y: 6 });
      tl.to("#n-p3 .dm", { x: 6, duration: 0.07, yoyo: true, repeat: 5, ease: "none" }, T(3, -2));
      // rangée en fil d'Ariane en haut ; démonstrations au centre
      out("#n-p0 .dm, #n-p1 .dm, #n-p2 .dm, #n-p3 .dm, #n-illu", T(4, 0) - 0.45, { d: 0.3 });
      tl.to("#n-rang", { y: -40, scale: 0.4, duration: 0.6, ease: "power3.inOut" }, T(4, 0) - 0.4);
      const actif = (i, t) => {
        tl.to(".nc", { opacity: 0.5, duration: 0.25 }, t);
        tl.to("#n-c" + i, { opacity: 1, duration: 0.25 }, t);
        tl.to(".nc", { boxShadow: "0 0 0 0px rgba(99,43,197,0), 0 24px 60px rgba(45,15,110,0.18)", duration: 0.25 }, t);
        tl.to("#n-c" + i, { boxShadow: "0 0 0 9px #632bc5, 0 24px 60px rgba(45,15,110,0.25)", duration: 0.25 }, t);
      };
      // S05 débutant : fenêtres et curseur hésitant
      actif(0, T(4, 0) - 0.2);
      inn("#d0-w0", T(4, 0), { y: 30, s: 0.94 }); inn("#d0-w1", T(4, 2), { y: 30, s: 0.94 }); inn("#d0-w2", T(4, 3), { y: 30, s: 0.94 });
      gsap.set("#d0-cur", { x: 1500, y: 760 });
      tl.fromTo("#d0-cur", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.3 }, T(4, 0) + 0.2);
      vers("#d0-cur", T(4, 0) + 0.25, 700, 360, 0.5); vers("#d0-cur", T(4, 1) + 0.25, 860, 470, 0.35);
      vers("#d0-cur", T(4, 2) + 0.15, 790, 410, 0.3); vers("#d0-cur", T(4, 3) + 0.1, 1120, 560, 0.4); vers("#d0-cur", T(4, 4) + 0.2, 1010, 520, 0.35);
      out("#d0 .win, #d0-cur", T(5, 0) - 0.3, { d: 0.25, y: -14 });
      // S06 amateur : copier-coller
      actif(1, T(5, 0) - 0.2);
      inn("#d1-p0", T(5, 0) - 0.1, { y: 30 });
      inn("#d1-cad1, #d1-cad2", T(5, 1) - 0.2, { y: 0, d: 0.3 });
      tl.set("#d1-p1", { autoAlpha: 1 }, T(5, 1)); tl.to("#d1-p1", { x: 460, duration: 0.55, ease: "power3.out" }, T(5, 1));
      tl.set("#d1-p2", { autoAlpha: 1 }, T(5, 6) - 0.2); tl.to("#d1-p2", { x: 920, duration: 0.55, ease: "power3.out" }, T(5, 6) - 0.2);
      pop("#d1-chip", T(5, 1) + 0.2);
      out("#d1 > *", T(6, 0) - 0.3, { d: 0.25, y: -14 });
      // S07 professionnel : actions cochées puis planifiées
      actif(2, T(6, 0) - 0.2);
      inn("#d2-liste", T(6, 0) - 0.1, { x: -30, y: 0 }); inn("#d2-sem", T(6, 1), { x: 30, y: 0 });
      [2, 3, 5].forEach((k, i) => {
        tl.to("#d2-k" + i, { backgroundColor: "#632bc5", borderColor: "#632bc5", duration: 0.15 }, T(6, k));
        tl.to("#d2-k" + i + " .ico", { opacity: 1, duration: 0.15 }, T(6, k));
      });
      [0, 1, 2].forEach((i) => tl.fromTo("#d2-b" + i, { autoAlpha: 0, x: -520 + i * -120, y: -60 + i * -90, scale: 0.7 },
        { autoAlpha: 1, x: 0, y: 0, scale: 1, duration: 0.55, ease: "power3.out" }, T(6, 6) + i * 0.14));
      out("#d2 > *", T(7, 0) - 0.3, { d: 0.25, y: -14 });
      // S08 expert : un besoin, une offre, un lien
      actif(3, T(7, 0) - 0.2);
      pop("#d3-offre", T(7, 0), { de: 0.7 });
      pop("#d3-g1, #d3-g2, #d3-g4, #d3-g5, #d3-g6, #d3-g7, #d3-g3", T(7, 0) + 0.2, { st: 0.08, de: 0.4 });
      tl.to("#d3-g1, #d3-g2, #d3-g4, #d3-g5, #d3-g6, #d3-g7", { opacity: 0.28, scale: 0.88, duration: 0.5 }, T(7, 3));
      tl.to("#d3-g3", { scale: 1.12, duration: 0.5, ease: "back.out(2)" }, T(7, 3));
      pop("#d3-besoin", T(7, 3) + 0.3);
      trace("#d3-lien", T(7, 7), 0.6);
      pop("#d3-choix", T(7, 13), { de: 0.6 });
      tl.to("#d3-offre", { scale: 1.12, duration: 0.25, yoyo: true, repeat: 1, ease: "power2.out" }, T(7, 14));

      // ---------- S09 · effets ----------
      pop("#e-por", T(8, 0) - 0.15, { de: 0.7 });
      [["#e-o1", 0], ["#e-o2", 0.9]].forEach(([o, dt]) => tl.fromTo(o, { autoAlpha: 0.7, scale: 1 }, { autoAlpha: 0, scale: 1.45, duration: 1.8, ease: "power1.out", repeat: 1 }, T(8, 0) + dt));
      inn("#e-chip", T(8, 4), { y: 14 });
      tl.to("#e-chip", { autoAlpha: 0, duration: 0.25 }, T(9, 0) - 0.4);
      tl.to("#e-por", { x: -540, scale: 0.867, duration: 0.6, ease: "power3.inOut" }, T(9, 0) - 0.4);
      traceTirets("#e-l1", T(9, 1), 0.4); inn("#e-k1", T(9, 2) - 0.05, { x: 30, y: 0 }); inn("#e-t1", T(9, 2), { y: 8 });
      traceTirets("#e-l2", T(9, 7), 0.4); inn("#e-k2", T(9, 8) - 0.05, { x: 30, y: 0 }); inn("#e-t2", T(9, 8), { y: 8 });
      traceTirets("#e-l3", T(9, 14), 0.4); inn("#e-k3", T(9, 15) - 0.05, { x: 30, y: 0 }); inn("#e-t3", T(9, 15), { y: 8 });
      inn("#e-illu", T(9, 16), { y: 6 });
      tl.to("#e-k1, #e-k2, #e-k3", { boxShadow: "0 0 0 5px #a877ff, 0 24px 60px rgba(45,15,110,0.25)", duration: 0.3, stagger: 0.12 }, T(9, -2));

      // ---------- S10–S12 · douleur ----------
      pop("#dl-por", T(10, 0) - 0.2, { de: 0.8 });
      inn("#dl-c1", T(10, 10), { x: -30, y: 0 }); traceTirets("#dl-l1", T(10, 10), 0.4);
      inn("#dl-c2", T(10, 12), { x: 30, y: 0 }); traceTirets("#dl-l2", T(10, 12), 0.4);
      inn("#dl-c3", T(10, 14), { x: 30, y: 0 }); traceTirets("#dl-l3", T(10, 14), 0.4);
      tl.to("#dl-c1, #dl-c2, #dl-c3, #dl-l1, #dl-l2, #dl-l3", { autoAlpha: 0.25, duration: 0.4 }, T(10, 16));
      out("#dl-c2, #dl-c3, #dl-l2, #dl-l3", T(10, 22) - 0.2);
      tl.to("#dl-por", { x: -240, duration: 0.6, ease: "power3.inOut" }, T(10, 22) - 0.2);
      out("#dl-c1, #dl-l1", T(10, 22) - 0.2);
      inn("#dl-inbox", T(10, 22), { x: 40, y: 0 });
      pop("#dl-quoi", T(10, -2));
      // S11 mois plein, mois vide
      out("#dl-por, #dl-inbox, #dl-quoi", T(11, 0) - 0.4, { d: 0.3 });
      inn("#dl-cal1", T(11, 0) - 0.15, { y: 30 });
      tl.to("#dl-cal1", { x: -900, autoAlpha: 0, duration: 0.5, ease: "power3.in" }, T(11, 4) - 0.05);
      tl.fromTo("#dl-cal2", { autoAlpha: 0, x: 900 }, { autoAlpha: 1, x: 0, duration: 0.6, ease: "power3.out" }, T(11, 4) + 0.2);
      // S12 charges qui tombent, horloge
      inn("#dl-horloge", T(12, 0), { y: 0, s: 0.7 });
      tl.to("#dl-h", { rotation: 360, duration: 6, ease: "none" }, T(12, 0));
      tl.to("#dl-m", { rotation: 360 * 6, duration: 6, ease: "none" }, T(12, 0));
      [4, 5, 7].forEach((k, i) => tl.fromTo("#dl-f" + (i + 1), { autoAlpha: 0, y: -420, rotation: -8 + i * 7 },
        { autoAlpha: 1, y: 0, rotation: -3 + i * 3, duration: 0.55, ease: "bounce.out" }, T(12, k)));
      tl.to("#dl-cal2", { x: 180, duration: 0.6, ease: "power2.inOut" }, T(12, 9) - 0.3);
      tl.to("#dl-f1, #dl-f2, #dl-f3", { x: 180, duration: 0.6, ease: "power2.inOut" }, T(12, 9) - 0.3);
      tl.to("#dl-horloge", { x: 130, y: -60, scale: 0.75, duration: 0.6 }, T(12, 9) - 0.3);
      pop("#dl-por2", T(12, 9) - 0.1, { de: 0.7 });
      inn("#dl-cherche", T(12, 15), { y: 12 });
      tl.to("#dl-cherche .ico", { rotation: 20, duration: 0.18, yoyo: true, repeat: 5 }, T(12, 15) + 0.3);
      tl.fromTo("#dl-dev", { autoAlpha: 0, y: 12 }, { autoAlpha: 0.55, y: 0, duration: 0.4 }, T(12, -3));

      // ---------- S13 · Oddysee ----------
      tl.fromTo("#o-badge", { autoAlpha: 0, scale: 0.55, rotation: -8 }, { autoAlpha: 1, scale: 1, rotation: 0, duration: 0.8, ease: "back.out(1.7)" }, G.odd.coupe + 0.3);
      tl.fromTo("#flash", { opacity: 0 }, { opacity: 0.3, duration: 0.08 }, G.odd.coupe + 0.3);
      tl.to("#flash", { opacity: 0, duration: 0.3 }, G.odd.coupe + 0.38);
      inn("#o-mot", T(13, 1), { y: 20 });
      pop("#o-p1", T(13, 2), { de: 0.6 }); inn("#o-n1", T(13, 2) + 0.15, { y: 10 });
      pop("#o-p2", T(13, 3), { de: 0.6 }); inn("#o-n2", T(13, 3) + 0.15, { y: 10 });
      pop("#o-p3", T(13, 4), { de: 0.6 }); inn("#o-n3", T(13, 4) + 0.15, { y: 10 });
      tl.to("#o-badge", { scale: 1.06, duration: 0.25, yoyo: true, repeat: 1 }, T(13, -1));

      // ---------- S14–S15 · parcours ----------
      traceTirets("#p-chemin", T(14, 1), 1.2);
      inn("#p-c1", T(14, 1), { y: 30 }); inn("#p-c2", T(14, 3), { y: 30 }); inn("#p-c3", T(14, 5), { y: 30 });
      ["#p-v1", "#p-v2"].forEach((v, i) => {
        tl.fromTo(v, { autoAlpha: 0, x: 40, y: 400 + i * 40 }, { autoAlpha: 1, x: 120 + i * 30, duration: 0.4 }, T(14, 8) + i * 0.15);
        tl.to(v, { x: 420 + i * 70, y: 210, duration: 0.5, ease: "power2.inOut" }, T(14, 10) - 0.1 + i * 0.1);
        tl.to(v, { x: 920 + i * 70, y: 210, duration: 0.5, ease: "power2.inOut" }, T(14, 14) - 0.1 + i * 0.1);
        tl.to(v, { x: 1420 + i * 70, y: 210, duration: 0.5, ease: "power2.inOut" }, T(14, -1) - 0.1 + i * 0.1);
      });
      tl.to("#p-c1", { boxShadow: "0 0 0 5px #a877ff, 0 24px 60px rgba(45,15,110,0.2)", duration: 0.25 }, T(14, 10));
      tl.to("#p-c2", { boxShadow: "0 0 0 5px #a877ff, 0 24px 60px rgba(45,15,110,0.2)", duration: 0.25 }, T(14, 14));
      tl.to("#p-c3", { boxShadow: "0 0 0 5px #632bc5, 0 24px 60px rgba(45,15,110,0.2)", duration: 0.25 }, T(14, -1));
      out("#p-v1, #p-v2", E(14) - 0.1, { d: 0.2 });
      pop("#p-notif", E(14) - 0.05, { de: 0.6 });
      out("#p-c1, #p-c2, #p-c3, #p-chemin, #p-notif", T(15, 0) - 0.5, { d: 0.3, y: -16 });
      [[1, 0], [2, 5], [3, 15]].forEach(([n, k]) => { inn("#p-s" + n, T(15, k) - 0.1, { y: 30 }); pop("#p-n" + n, T(15, k) + 0.4, { de: 0.6 }); });

      // ---------- S16–S18 · preuves ----------
      inn("#r-titre", T(16, 0), { y: 14 });
      inn("#r-t0, #r-t1, #r-t2, #r-t3, #r-t4", T(16, 1), { y: 40, st: 0.2, s: 0.92 });
      tl.to("#r-t0, #r-t1, #r-t2, #r-t3, #r-t4", { x: -150, duration: 0.6, ease: "power2.inOut" }, T(16, 11) - 0.3);
      tl.to("#r-titre", { x: -150, duration: 0.6, ease: "power2.inOut" }, T(16, 11) - 0.3);
      pop("#r-ag", T(16, 12)); pop("#r-inf", T(16, 16));
      out("#r-titre, #r-t0, #r-t1, #r-t2, #r-t3, #r-t4, #r-ag, #r-inf", T(17, 0) - 0.45, { d: 0.3, s: 0.94 });
      [[0, 2], [1, 4], [2, 5], [3, 9], [4, 11], [5, 14]].forEach(([n, k]) => inn("#r-s" + n, T(17, k) - 0.05, { y: 26, s: 0.95 }));
      out("#r-s0, #r-s1, #r-s2, #r-s3, #r-s4, #r-s5", T(18, 0) - 0.3, { d: 0.3, s: 0.95 });
      inn("#r-titre2", T(18, 0), { y: 14 });
      [4, 5, 6, 8].forEach((k, i) => pop("#r-l" + i, T(18, k) - 0.02, { de: 0.7 }));

      // ---------- S19 · Meta ----------
      tl.fromTo("#m-badge", { autoAlpha: 0, scale: 1.25 }, { autoAlpha: 1, scale: 1, duration: 0.8, ease: "power3.out" }, T(19, 3) - 0.3);
      tl.fromTo("#m-brillance", { x: 0 }, { x: 1060, duration: 0.9, ease: "power2.inOut" }, T(19, 4));
      pop("#m-ans", T(19, 9), { de: 0.6 });
      trace("#m-arc", T(19, 19), 0.8); inn("#m-dublin", T(19, 21) - 0.1, { x: 30, y: 0 });
      tl.to("#m-badge", { scale: 0.86, y: -30, duration: 0.6, ease: "power2.inOut" }, T(19, 22) - 0.3);
      tl.to("#m-ans", { y: -60, duration: 0.6, ease: "power2.inOut" }, T(19, 22) - 0.3);
      inn("#m-s1", T(19, 23), { y: 20 }); inn("#m-s2", T(19, 25), { y: 20 }); inn("#m-s3", T(19, 26), { y: 20 });
      trace("#m-c1", T(19, 28), 1.0);
      pop("#m-but", T(19, -3), { de: 0.6 });

      // ---------- S20–S22 · engagement ----------
      pop("#g-alv", T(20, 0), { de: 0.7 });
      tl.fromTo("#e-mot span", { autoAlpha: 0, y: 40 }, { autoAlpha: 1, y: 0, duration: 0.5, ease: "power3.out", stagger: 0.05 }, T(20, 6) - 0.1);
      tl.fromTo("#e-mot", { scale: 1 }, { scale: 1.05, duration: 1.8, ease: "power1.out" }, T(20, 6));
      out("#e-mot, #g-alv", T(21, 0) - 0.3, { y: -30 });
      inn("#b1", T(21, 3) - 0.1, { y: 30 });
      inn("#b2", T(21, 17) - 0.1, { y: 30 });
      tl.to("#b1, #b2", { opacity: 0.45, duration: 0.4 }, T(21, 26));
      pop("#b-q", T(21, 30));
      tl.to("#b-q", { scale: 1.15, duration: 0.3, yoyo: true, repeat: 3 }, T(21, 30) + 0.4);
      out("#b1, #b2, #b-q", T(22, 0) - 0.4, { d: 0.3, y: -20 });
      inn("#g-prets", T(22, 4), { y: 14 });
      inn("#g-strat", T(22, 10), { x: -30, y: 0 });
      inn("#g-pub", T(22, 16), { x: 30, y: 0 });
      tl.to("#g-strat", { x: 140, y: 70, duration: 0.6, ease: "power3.inOut" }, E(22) - 0.1);
      tl.to("#g-pub", { x: -140, y: 70, duration: 0.6, ease: "power3.inOut" }, E(22) - 0.1);
      pop("#g-but", E(22) + 0.35, { de: 0.6 });

      // ---------- S23 · outils ----------
      tl.fromTo("#ou-fen", { autoAlpha: 0, rotationX: 22, y: 60, transformPerspective: 1600 }, { autoAlpha: 1, rotationX: 0, y: 0, duration: 0.9, ease: "power3.out" }, T(23, 0) - 0.25);
      tl.fromTo("#ou-q", { clipPath: "inset(0 100% 0 0)" }, { clipPath: "inset(0 0% 0 0)", duration: T(23, 8) - T(23, 2), ease: "none" }, T(23, 2));
      pop("#ou-1", T(23, 9)); pop("#ou-2", T(23, 10)); pop("#ou-3", T(23, 12));
      inn("#ou-rep .sk", T(23, 14), { y: 8, st: 0.15, d: 0.3 });

      // ---------- S24 · temps ----------
      inn("#tp-a1", T(24, 0) - 0.2, { x: -40, y: 0 }); inn("#tp-a2", T(24, 0), { x: 40, y: 0 });
      tl.to("#tp-a1", { x: 120, duration: 0.7, ease: "power3.inOut" }, T(24, 4));
      tl.to("#tp-a2", { x: -120, duration: 0.7, ease: "power3.inOut" }, T(24, 4));
      tl.fromTo("#tp-slot", { autoAlpha: 0, scaleX: 0.2 }, { autoAlpha: 1, scaleX: 1, duration: 0.5, ease: "power3.out" }, T(24, 7));
      inn("#tp-c1", T(24, 14), { y: 12 }); inn("#tp-c2", T(24, 18), { y: 12 });

      // ---------- S25 · question ----------
      pop("#q-por", T(25, 0) - 0.1, { de: 0.7 });
      pop("#q-pts", T(25, 8));
      tl.to("#q-pts i", { y: -8, duration: 0.22, yoyo: true, repeat: 7, stagger: 0.1 }, T(25, 8) + 0.3);
      out("#q-pts", T(25, 17) - 0.2, { d: 0.2 });
      tl.fromTo("#q-bulle", { autoAlpha: 0, scale: 0.6, transformOrigin: "0% 100%" }, { autoAlpha: 1, scale: 1, duration: 0.4, ease: "back.out(1.8)" }, T(25, 17) - 0.15);
      [18, 19, 20, 21, 22, 23, 24, 25].forEach((k, i) => tl.fromTo("#q" + i, { opacity: 0.12, y: 10 }, { opacity: 1, y: 0, duration: 0.2 }, T(25, k)));

      // ---------- S26–S28 · audit ----------
      pop("#a-titre", T(26, 7) - 0.2, { de: 0.8 });
      tl.fromTo("#a-titre .grand i", { opacity: 0, x: -20 }, { opacity: 1, x: 0, duration: 0.35 }, T(26, -1));
      tl.set("#a-titre .grand i", { opacity: 0 }, 0);
      tl.to("#a-titre", { y: -200, scale: 0.55, duration: 0.6, ease: "power3.inOut" }, T(27, 0) - 0.4);
      tl.fromTo("#a-grille", { autoAlpha: 0, rotationX: 16, y: 60, transformPerspective: 1800 }, { autoAlpha: 1, rotationX: 0, y: 0, duration: 0.8, ease: "power3.out" }, T(27, 0) - 0.2);
      const zone = (i, t, fond) => {
        tl.to("#a-grille .zone", { opacity: 0.45, duration: 0.25 }, t);
        tl.to("#a-z" + i, { opacity: 1, backgroundColor: fond, scale: 1.04, duration: 0.3 }, t);
        if (i > 0) tl.to("#a-z" + (i - 1), { scale: 1, duration: 0.3 }, t);
      };
      zone(0, T(27, 1), "#ece4fb"); zone(1, T(27, 10), "#fde6ea"); zone(2, T(27, 13), "#fdf3d6");
      out("#a-grille", T(28, 0) - 0.3, { d: 0.3, y: -20 });
      inn("#a-x1", T(28, 3), { x: -40, y: 0 }); inn("#a-x2", T(28, 5), { x: -40, y: 0 }); inn("#a-x3", T(28, 7), { x: -40, y: 0 });
      inn("#a-msg", T(28, 12), { x: 40, y: 0 });
      tl.to("#a-msg", { y: 120, autoAlpha: 0, duration: 0.35, ease: "power2.in" }, T(28, 15));
      pop("#a-rdv", T(28, 15) + 0.1, { de: 0.7 });

      // ---------- S29 · clic sur le vrai parcours ----------
      tl.fromTo("#c-fen", { autoAlpha: 0, rotationY: -14, rotationX: 6, scale: 0.92, transformPerspective: 2200 },
        { autoAlpha: 1, rotationY: 0, rotationX: 0, scale: 1, duration: 1.0, ease: "power3.out" }, G.cta.coupe);
      gsap.set("#c-cur", { x: 1500, y: 900 });
      tl.fromTo("#c-cur", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.3 }, T(29, 0) - 0.2);
      vers("#c-cur", T(29, 0), 760, 640, 0.6);
      clic("#c-cur", T(29, 3) + 0.35, "#c-champ");
      tl.to("#c-champ", { borderColor: "#632bc5", backgroundColor: "#f4effd", duration: 0.2 }, T(29, 3) + 0.35);
      pop("#c-desc", T(29, 4), { de: 0.7 });
      tl.fromTo("#c-resa", { autoAlpha: 0, x: 60 }, { autoAlpha: 1, x: 0, duration: 0.5, ease: "power3.out" }, T(29, 8) - 0.1);
      vers("#c-cur", T(29, 8) + 0.1, 1240, 540, 0.4);
      clic("#c-cur", T(29, 8) + 0.5);
      tl.to("#c-jour", { backgroundColor: "#632bc5", color: "#fff", duration: 0.15 }, T(29, 8) + 0.5);
      vers("#c-cur", T(29, 9) + 0.05, 1440, 446, 0.35);
      clic("#c-cur", T(29, 10) + 0.3, "#c-slot");
      tl.to("#c-slot", { backgroundColor: "#632bc5", color: "#fff", borderColor: "#632bc5", duration: 0.15 }, T(29, 10) + 0.3);
      inn("#c-illu", T(29, 8), { y: 6 });

      // ---------- S30–S31 · capacité ----------
      inn("#k-d0, #k-d1, #k-d2, #k-d3", T(30, 4) - 0.1, { y: 40, st: 0.18 });
      tl.fromTo("#g-capa .prog i", { scaleX: 0 }, { scaleX: 1, duration: 0.9, ease: "power2.out", stagger: 0.12 }, T(30, 9));
      tl.fromTo("#k-cadre", { autoAlpha: 0, scale: 1.06 }, { autoAlpha: 1, scale: 1, duration: 0.5, ease: "power3.out" }, T(30, 14));
      inn("#k-chip", T(30, 14) + 0.25, { y: 12 });
      tl.to("#k-d0, #k-d1, #k-d2, #k-d3", { y: -60, opacity: 0.35, duration: 0.6, ease: "power3.inOut" }, T(30, 22) - 0.4);
      tl.to("#k-cadre", { y: -60, opacity: 0.6, duration: 0.6, ease: "power3.inOut" }, T(30, 22) - 0.4);
      tl.to("#k-chip", { y: -60, duration: 0.6, ease: "power3.inOut" }, T(30, 22) - 0.4);
      pop("#k-bouton", T(30, 22) - 0.1, { de: 0.6 });
      gsap.set("#k-cur", { x: 1500, y: 900 });
      tl.fromTo("#k-cur", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.3 }, T(30, 22) - 0.3);
      vers("#k-cur", T(30, 22) - 0.25, 1080, 560, 0.45);
      clic("#k-cur", T(30, 23) + 0.25, "#k-bouton");
      tl.to("#k-cadre", { boxShadow: "0 0 50px rgba(168,119,255,0.9)", opacity: 1, duration: 0.4, yoyo: true, repeat: 1 }, T(30, -3));

      // ---------- S32 · conclusion ----------
      [0, 1, 2, 3].forEach((i) => inn("#f-c" + i, G.fin.coupe + 0.15 + i * 0.16, { y: 40 }));
      tl.to("#f-c0, #f-c1, #f-c2", { opacity: 0.3, duration: 0.4 }, T(31, 6));
      tl.to("#f-c3", { scale: 1.1, boxShadow: "0 0 0 6px #a877ff, 0 30px 70px rgba(0,0,0,0.4)", duration: 0.5, ease: "back.out(2)" }, T(31, 6));
      out("#f-c0, #f-c1, #f-c2, #f-c3", T(31, 15) - 0.1, { d: 0.35, y: -20 });
      tl.fromTo("#f-badge", { autoAlpha: 0, scale: 0.6 }, { autoAlpha: 1, scale: 1, duration: 0.7, ease: "back.out(1.7)" }, T(31, 15) + 0.2);
      inn("#f-mot", E(31) - 0.1, { y: 16 });
      pop("#f-bouton", E(31) + 0.3, { de: 0.7 });
      inn("#f-site", E(31) + 0.6, { y: 10 });

      // ---------- sous-titres : mot à mot, glissement latéral ----------
      D.S.forEach((c, n) => {
        const id = "#st" + n;
        tl.fromTo(id, { autoAlpha: 0, x: 34 }, { autoAlpha: 1, x: 0, duration: 0.24, ease: "power2.out" }, c.d);
        c.m.forEach(([i, t]) => tl.fromTo("#w" + i, { opacity: 0, y: 14 }, { opacity: 1, y: 0, duration: 0.2, ease: "power2.out" }, Math.max(c.d, t - 0.04)));
        tl.to(id, { autoAlpha: 0, x: -34, duration: 0.15, ease: "power2.in" }, c.f - 0.1);
      });

      window.__timelines["oddysee-vsl-youtube"] = tl;
    </script>
  </body>
</html>
