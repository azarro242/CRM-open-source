<!doctype html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <title>Audio V1 — Claude Max 6 mois</title>
    <link href="assets/fonts/fonts.css" rel="stylesheet" />
    <script src="vendor/gsap.min.js"></script>
    <style>
      :root {
        --noir: #0a0a0f;
        --noir2: #12121a;
        --noir3: #1c1c28;
        --violet: #7c5cfc;
        --violet-clair: #9d80ff;
        --violet-tclair: #c4b0ff;
        --gold: #d4a847;
        --gold-clair: #f0c860;
        --texte: #f5f3ee;
        --texte2: #8b8a99;
      }
      body { margin: 0; background: #000; font-family: "DM Sans", sans-serif; color: var(--texte); }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden; background: #000; }

      /* ------ fond : moitié haute décor, moitié basse noir pur ------ */
      #fond { position: absolute; inset: 0; background: #000; }
      #panneau-haut {
        position: absolute; top: 0; left: 0; width: 1080px; height: 960px; overflow: hidden;
        background:
          radial-gradient(720px 480px at 50% 18%, rgba(124, 92, 252, 0.16), transparent 70%),
          radial-gradient(560px 420px at 82% 88%, rgba(212, 168, 71, 0.07), transparent 70%),
          var(--noir);
      }
      .particule { position: absolute; border-radius: 50%; background: var(--violet-clair); opacity: 0.22; }
      #progress {
        position: absolute; top: 0; left: 0; width: 1080px; height: 7px;
        background: linear-gradient(90deg, var(--violet), var(--gold));
        transform: scaleX(0); transform-origin: left center;
      }
      #dim-final { position: absolute; inset: 0; background: var(--noir); opacity: 0; visibility: hidden; }

      /* ------ scènes : confinées à la moitié haute ------ */
      .scene { position: absolute; top: 0; left: 0; width: 1080px; height: 960px; overflow: hidden; }
      .wrap {
        position: absolute; inset: 0; display: flex; flex-direction: column;
        align-items: center; justify-content: center; gap: 34px; padding: 70px 60px 210px;
        box-sizing: border-box;
      }
      .masque { opacity: 0; visibility: hidden; }

      .badge-etape {
        font-weight: 900; font-size: 34px; letter-spacing: 4px; color: #fff;
        background: linear-gradient(135deg, var(--violet), #5a3de0);
        padding: 14px 36px; border-radius: 999px;
      }
      .carte {
        background: var(--noir2); border: 2px solid #2a2a3c; border-radius: 28px;
        box-shadow: 0 30px 80px rgba(0, 0, 0, 0.55);
      }
      .pill-gold {
        font-weight: 900; font-size: 40px; color: var(--noir);
        background: linear-gradient(135deg, var(--gold-clair), var(--gold));
        padding: 16px 42px; border-radius: 999px;
      }
      .serif { font-family: "Cormorant Garamond", serif; }

      /* S1 — hook */
      #s1-intro { font-family: "Cormorant Garamond", serif; font-style: italic; font-weight: 600;
        font-size: 68px; color: var(--texte); text-align: center; max-width: 860px; line-height: 1.2; }
      #s1-label { font-weight: 800; font-size: 30px; letter-spacing: 10px; color: var(--violet-tclair); }
      #s1-big { font-family: "Cormorant Garamond", serif; font-weight: 700; font-size: 176px;
        line-height: 0.95; text-align: center; }
      #s1-big .ligne2 { display: block; font-family: "DM Sans", sans-serif; font-weight: 900;
        font-size: 118px; color: var(--gold-clair); letter-spacing: 2px; }
      #s1-pill { font-weight: 900; font-size: 46px; color: #fff; letter-spacing: 2px;
        background: linear-gradient(135deg, var(--violet), #5a3de0); padding: 20px 52px;
        border-radius: 999px; box-shadow: 0 18px 50px rgba(124, 92, 252, 0.4); }
      #s1-chrono { display: flex; align-items: center; gap: 18px; font-weight: 800; font-size: 40px;
        color: var(--texte); background: var(--noir3); padding: 16px 34px; border-radius: 999px; }
      #s1-parti { font-family: "Cormorant Garamond", serif; font-style: italic; font-weight: 600;
        font-size: 58px; color: var(--gold-clair); }

      /* S2 — navigateur */
      #s2 .navigateur { width: 880px; padding: 26px; }
      #s2 .barre-titre { display: flex; gap: 12px; margin-bottom: 22px; }
      #s2 .pastille { width: 20px; height: 20px; border-radius: 50%; }
      #s2 .barre-url { display: flex; align-items: center; gap: 16px; background: var(--noir3);
        border-radius: 999px; padding: 22px 34px; }
      #s2-url { font-weight: 800; font-size: 52px; color: var(--texte); letter-spacing: 1px; }
      #s2-url .c { opacity: 0; visibility: hidden; }
      #s2 .zone-page { height: 240px; margin-top: 22px; border-radius: 18px;
        background: linear-gradient(180deg, #191926, #10101a);
        display: grid; place-items: center; }
      #s2 .zone-page span { font-family: "Cormorant Garamond", serif; font-size: 56px;
        color: var(--violet-tclair); font-weight: 600; }

      /* S3 — formulaire */
      #s3 .formulaire { width: 780px; padding: 44px 50px; display: flex; flex-direction: column; gap: 26px; }
      #s3 .titre-form { font-weight: 800; font-size: 42px; color: var(--texte); }
      #s3 .champ { height: 64px; border-radius: 14px; background: var(--noir3); overflow: hidden; }
      #s3 .remplissage { width: 100%; height: 100%; border-radius: 14px;
        background: linear-gradient(90deg, rgba(124, 92, 252, 0.5), rgba(124, 92, 252, 0.22));
        transform: scaleX(0); transform-origin: left center; }
      #s3-bouton { align-self: center; margin-top: 8px; }

      /* S4 — envoi + mail */
      #s4-plane { color: var(--violet-clair); }
      #s4-mail { position: relative; color: var(--gold-clair); }
      #s4-notif { position: absolute; top: -6px; right: -10px; width: 44px; height: 44px;
        border-radius: 50%; background: #e0483e; color: #fff; font-weight: 900; font-size: 30px;
        display: grid; place-items: center; }
      #s4-banniere { font-weight: 900; font-size: 52px; color: var(--gold-clair);
        border: 3px solid var(--gold); border-radius: 22px; padding: 22px 44px;
        background: rgba(212, 168, 71, 0.08); }
      #s4-avec { font-weight: 800; font-size: 36px; color: #fff;
        background: linear-gradient(135deg, var(--violet), #5a3de0);
        padding: 14px 34px; border-radius: 999px; }

      /* S5 — guide */
      #s5 .guide { width: 800px; padding: 48px 56px; display: flex; flex-direction: column; gap: 26px; }
      #s5 .titre-guide { font-family: "Cormorant Garamond", serif; font-weight: 700; font-size: 84px;
        line-height: 1.02; }
      #s5 .ligne-check { display: flex; align-items: center; gap: 20px; font-weight: 700;
        font-size: 40px; color: var(--texte); }
      #s5 .ligne-check svg { color: var(--gold-clair); flex: none; }
      #s5-tag { align-self: flex-start; }

      /* S6 — communauté */
      #s6-avatars { display: flex; }
      #s6-avatars .avatar { width: 110px; height: 110px; border-radius: 50%; margin: 0 -14px;
        border: 4px solid var(--noir); display: grid; place-items: center;
        font-weight: 900; font-size: 40px; color: #fff; }
      #s6-titre { font-family: "Cormorant Garamond", serif; font-weight: 700; font-size: 104px; }
      #s6-titre em { font-style: italic; color: var(--violet-tclair); }
      .chip { font-weight: 800; font-size: 38px; padding: 16px 36px; border-radius: 999px; }
      #s6-chip1 { background: var(--noir3); color: var(--texte); }
      #s6-chip1 b { color: var(--violet-tclair); }
      #s6-chip2 { background: linear-gradient(135deg, var(--gold-clair), var(--gold)); color: var(--noir); }
      #s6-chips { display: flex; gap: 22px; }

      /* S7 — commente / abonne */
      #s7 .action { display: flex; align-items: center; gap: 30px; }
      #s7 .action .txt { font-weight: 900; font-size: 88px; letter-spacing: 1px; }
      #s7-commente .txt { color: var(--texte); }
      #s7-commente svg { color: var(--violet-clair); }
      #s7-sous { font-weight: 500; font-size: 40px; color: var(--texte2); }
      #s7-abonne .txt { color: var(--gold-clair); }
      #s7-abonne svg { color: var(--gold-clair); }

      /* S8 — final */
      #s8-recap { width: 820px; padding: 44px 54px; display: flex; flex-direction: column; gap: 30px; }
      #s8-recap .ligne-check { display: flex; align-items: center; gap: 22px; font-weight: 700;
        font-size: 42px; }
      #s8-recap .ligne-check svg { color: var(--violet-clair); flex: none; }
      #s8-cta { display: flex; flex-direction: column; align-items: center; gap: 26px; }
      #s8-cta .gros { font-weight: 900; font-size: 128px; letter-spacing: 2px;
        background: linear-gradient(135deg, var(--gold-clair), var(--gold));
        -webkit-background-clip: text; background-clip: text; color: transparent; }
      #s8-cta svg { color: var(--gold-clair); }

      /* ------ sous-titres : bas de la moitié haute ------ */
      #captions { position: absolute; top: 0; left: 0; width: 1080px; height: 960px; }
      .cap {
        position: absolute; left: 40px; right: 40px; top: 782px; text-align: center;
        font-weight: 800; font-size: 54px; line-height: 1.22; color: var(--texte);
        text-shadow: 0 4px 24px rgba(0, 0, 0, 0.8); opacity: 0; visibility: hidden;
      }
      .cap .kw { color: var(--gold-clair); }
      .cap .kv { color: var(--violet-clair); }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="audio-v1" data-start="0" data-width="1080" data-height="1920" data-duration="53">

      <!-- fond permanent : moitié basse noir pur réservée à l'autre vidéo -->
      <div id="fond" class="clip" data-start="0" data-duration="53" data-track-index="0">
        <div id="panneau-haut">
          <div class="particule" style="width:10px;height:10px;left:120px;top:180px"></div>
          <div class="particule" style="width:6px;height:6px;left:920px;top:120px"></div>
          <div class="particule" style="width:8px;height:8px;left:820px;top:560px"></div>
          <div class="particule" style="width:5px;height:5px;left:200px;top:700px"></div>
          <div class="particule" style="width:12px;height:12px;left:540px;top:90px;opacity:.14"></div>
          <div class="particule" style="width:7px;height:7px;left:60px;top:460px"></div>
          <div id="progress"></div>
          <div id="dim-final"></div>
        </div>
      </div>

      <!-- ================= SCÈNE 1 · HOOK 0 → 10.6 ================= -->
      <section id="s1" class="clip scene" data-start="0" data-duration="10.6" data-track-index="1">
        <div class="wrap">
          <div id="s1-intro" class="masque">« Tu ne le sais peut-être pas… »</div>
          <div id="s1-label" class="masque">ANTHROPIC</div>
          <div id="s1-big" class="masque">6 MOIS <span class="ligne2">GRATUITS</span></div>
          <div id="s1-pill" class="masque">CLAUDE MAX</div>
          <div id="s1-chrono" class="masque">
            <svg width="52" height="52" viewBox="0 0 48 48" fill="none">
              <circle cx="24" cy="26" r="18" stroke="#f0c860" stroke-width="4" />
              <path d="M24 26 L24 14" stroke="#f0c860" stroke-width="4" stroke-linecap="round" />
              <path d="M18 4 L30 4" stroke="#f0c860" stroke-width="4" stroke-linecap="round" />
            </svg>
            en moins de 60 secondes
          </div>
        </div>
        <div id="s1-parti" class="masque" style="position:absolute;left:0;right:0;top:64px;text-align:center">C'est parti →</div>
      </section>

      <!-- ================= SCÈNE 2 · ÉTAPE 1 10.6 → 13.92 ================= -->
      <section id="s2" class="clip scene" data-start="10.6" data-duration="3.32" data-track-index="1">
        <div class="wrap" id="s2-wrap">
          <div class="badge-etape">ÉTAPE 1</div>
          <div class="carte navigateur">
            <div class="barre-titre">
              <div class="pastille" style="background:#e0483e"></div>
              <div class="pastille" style="background:#e8b73a"></div>
              <div class="pastille" style="background:#4fbf67"></div>
            </div>
            <div class="barre-url">
              <svg width="40" height="40" viewBox="0 0 24 24" fill="none">
                <rect x="5" y="11" width="14" height="9" rx="2" stroke="#8b8a99" stroke-width="2" />
                <path d="M8 11 V8 a4 4 0 0 1 8 0 v3" stroke="#8b8a99" stroke-width="2" />
              </svg>
              <div id="s2-url"><span class="c">c</span><span class="c">l</span><span class="c">a</span><span class="c">u</span><span class="c">d</span><span class="c">e</span><span class="c">.</span><span class="c">c</span><span class="c">o</span><span class="c">m</span></div>
            </div>
            <div class="zone-page"><span>Claude</span></div>
          </div>
        </div>
      </section>

      <!-- ================= SCÈNE 3 · ÉTAPE 2 13.92 → 19.28 ================= -->
      <section id="s3" class="clip scene" data-start="13.92" data-duration="5.36" data-track-index="1">
        <div class="wrap" id="s3-wrap">
          <div class="badge-etape">ÉTAPE 2</div>
          <div class="carte formulaire">
            <div class="titre-form">Le formulaire</div>
            <div class="champ"><div class="remplissage" id="s3-r1"></div></div>
            <div class="champ"><div class="remplissage" id="s3-r2"></div></div>
            <div class="champ"><div class="remplissage" id="s3-r3"></div></div>
            <div id="s3-bouton" class="pill-gold masque">POSTULER</div>
          </div>
        </div>
      </section>

      <!-- ================= SCÈNE 4 · ÉTAPE 3 19.28 → 26.9 ================= -->
      <section id="s4" class="clip scene" data-start="19.28" data-duration="7.62" data-track-index="1">
        <div class="wrap" id="s4-wrap">
          <div class="badge-etape">ÉTAPE 3</div>
          <div id="s4-plane" class="masque">
            <svg width="150" height="150" viewBox="0 0 48 48" fill="none">
              <path d="M4 24 L44 8 L32 42 L24 30 Z" stroke="currentColor" stroke-width="3" stroke-linejoin="round" />
              <path d="M24 30 L44 8" stroke="currentColor" stroke-width="3" />
            </svg>
          </div>
          <div id="s4-mail" class="masque">
            <svg width="190" height="150" viewBox="0 0 56 44" fill="none">
              <rect x="3" y="5" width="50" height="36" rx="6" stroke="currentColor" stroke-width="3" />
              <path d="M5 9 L28 26 L51 9" stroke="currentColor" stroke-width="3" stroke-linejoin="round" />
            </svg>
            <div id="s4-notif">1</div>
          </div>
          <div id="s4-banniere" class="masque">PLAN GRATUIT · 6 MOIS</div>
          <div id="s4-avec" class="masque">avec CLAUDE MAX</div>
        </div>
      </section>

      <!-- ================= SCÈNE 5 · GUIDE 26.9 → 32.5 ================= -->
      <section id="s5" class="clip scene" data-start="26.9" data-duration="5.6" data-track-index="1">
        <div class="wrap" id="s5-wrap">
          <div class="carte guide">
            <div class="titre-guide serif">Le <em style="color:var(--gold-clair)">guide complet</em></div>
            <div class="ligne-check masque" id="s5-l1">
              <svg width="44" height="44" viewBox="0 0 24 24" fill="none"><path d="M4 12.5 L10 18 L20 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
              Accéder à Claude Max
            </div>
            <div class="ligne-check masque" id="s5-l2">
              <svg width="44" height="44" viewBox="0 0 24 24" fill="none"><path d="M4 12.5 L10 18 L20 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
              Étape par étape
            </div>
            <div id="s5-tag" class="pill-gold masque">100% GRATUIT</div>
          </div>
        </div>
      </section>

      <!-- ================= SCÈNE 6 · COMMUNAUTÉ 32.5 → 37.56 ================= -->
      <section id="s6" class="clip scene" data-start="32.5" data-duration="5.06" data-track-index="1">
        <div class="wrap" id="s6-wrap">
          <div id="s6-avatars">
            <div class="avatar masque" style="background:linear-gradient(135deg,#7c5cfc,#5a3de0)">A</div>
            <div class="avatar masque" style="background:linear-gradient(135deg,#d4a847,#b8892f)">K</div>
            <div class="avatar masque" style="background:linear-gradient(135deg,#4fbf67,#2f8f47)">S</div>
            <div class="avatar masque" style="background:linear-gradient(135deg,#e0483e,#b02f27)">M</div>
            <div class="avatar masque" style="background:linear-gradient(135deg,#9d80ff,#7c5cfc)">+</div>
          </div>
          <div id="s6-titre" class="masque">Communauté <em>IA</em></div>
          <div id="s6-chips">
            <div id="s6-chip1" class="chip masque"><b>FR</b> · 100% francophone</div>
            <div id="s6-chip2" class="chip masque">Gratuite</div>
          </div>
        </div>
      </section>

      <!-- ================= SCÈNE 7 · ENGAGE 37.56 → 41.58 ================= -->
      <section id="s7" class="clip scene" data-start="37.56" data-duration="4.02" data-track-index="1">
        <div class="wrap" id="s7-wrap">
          <div id="s7-commente" class="action masque">
            <svg width="110" height="110" viewBox="0 0 48 48" fill="none">
              <path d="M6 10 h36 v24 h-22 l-8 8 v-8 h-6 Z" stroke="currentColor" stroke-width="3" stroke-linejoin="round" />
              <path d="M14 20 h20 M14 26 h12" stroke="currentColor" stroke-width="3" stroke-linecap="round" />
            </svg>
            <div class="txt">COMMENTE</div>
          </div>
          <div id="s7-sous" class="masque">ce que tu veux, sous la vidéo</div>
          <div id="s7-abonne" class="action masque">
            <svg id="s7-bell" width="110" height="110" viewBox="0 0 48 48" fill="none">
              <path d="M24 6 a12 12 0 0 1 12 12 v8 l5 8 H7 l5 -8 v-8 A12 12 0 0 1 24 6 Z" stroke="currentColor" stroke-width="3" stroke-linejoin="round" />
              <path d="M19 40 a5 5 0 0 0 10 0" stroke="currentColor" stroke-width="3" />
            </svg>
            <div class="txt">SOIS ABONNÉ</div>
          </div>
        </div>
      </section>

      <!-- ================= SCÈNE 8 · FINAL 41.58 → 53 ================= -->
      <section id="s8" class="clip scene" data-start="41.58" data-duration="11.42" data-track-index="1">
        <div class="wrap" id="s8-wrap">
          <div id="s8-recap" class="carte">
            <div class="ligne-check masque" id="s8-l1">
              <svg width="46" height="46" viewBox="0 0 24 24" fill="none"><path d="M4 12.5 L10 18 L20 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
              Je t'envoie l'accès à la communauté
            </div>
            <div class="ligne-check masque" id="s8-l2">
              <svg width="46" height="46" viewBox="0 0 24 24" fill="none"><path d="M4 12.5 L10 18 L20 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
              Tu crées ton compte
            </div>
            <div class="ligne-check masque" id="s8-l3">
              <svg width="46" height="46" viewBox="0 0 24 24" fill="none"><path d="M4 12.5 L10 18 L20 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/></svg>
              <span>Claude Max · <b style="color:var(--gold-clair)">6 mois illimité</b></span>
            </div>
          </div>
          <div id="s8-cta" class="masque">
            <svg width="130" height="130" viewBox="0 0 48 48" fill="none">
              <path d="M24 6 a12 12 0 0 1 12 12 v8 l5 8 H7 l5 -8 v-8 A12 12 0 0 1 24 6 Z" stroke="currentColor" stroke-width="3" stroke-linejoin="round" />
              <path d="M19 40 a5 5 0 0 0 10 0" stroke="currentColor" stroke-width="3" />
            </svg>
            <div class="gros">ABONNE-TOI</div>
          </div>
        </div>
      </section>

      <!-- ================= SOUS-TITRES (moitié haute, zone basse) ================= -->
      <div id="captions" class="clip" data-start="0" data-duration="53" data-track-index="2">
{{CAPTIONS_HTML}}
      </div>

      <!-- ================= AUDIO : voix off + effets sonores ================= -->
      <audio id="vo" src="Audio-V1.mp3" data-start="0" data-track-index="10" data-volume="1"></audio>

      <audio id="wh-1" src="assets/sfx/whoosh-short.mp3" data-start="10.52" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-2" src="assets/sfx/whoosh-short.mp3" data-start="13.84" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-3" src="assets/sfx/whoosh-short.mp3" data-start="19.20" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-4" src="assets/sfx/whoosh-short.mp3" data-start="26.82" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-5" src="assets/sfx/whoosh-short.mp3" data-start="32.42" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-6" src="assets/sfx/whoosh-short.mp3" data-start="37.48" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>
      <audio id="wh-7" src="assets/sfx/whoosh-short.mp3" data-start="41.50" data-duration="0.57" data-track-index="11" data-volume="0.5"></audio>

      <audio id="imp-1" src="assets/sfx/impact-bass-1.mp3" data-start="5.04" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>
      <audio id="imp-2" src="assets/sfx/impact-bass-1.mp3" data-start="48.56" data-duration="2.11" data-track-index="12" data-volume="0.55"></audio>

      <audio id="pop-1" src="assets/sfx/pop.mp3" data-start="6.27" data-duration="0.72" data-track-index="13" data-volume="0.5"></audio>
      <audio id="typ-1" src="assets/sfx/typing.mp3" data-start="12.50" data-duration="1.40" data-track-index="13" data-volume="0.4"></audio>
      <audio id="kp-1" src="assets/sfx/key-press.mp3" data-start="16.50" data-duration="0.43" data-track-index="13" data-volume="0.5"></audio>
      <audio id="kp-2" src="assets/sfx/key-press.mp3" data-start="18.74" data-duration="0.43" data-track-index="13" data-volume="0.5"></audio>
      <audio id="notif-1" src="assets/sfx/notification.mp3" data-start="22.42" data-duration="2.45" data-track-index="13" data-volume="0.4"></audio>
      <audio id="pop-2" src="assets/sfx/pop.mp3" data-start="31.90" data-duration="0.72" data-track-index="13" data-volume="0.5"></audio>
      <audio id="pop-3" src="assets/sfx/pop.mp3" data-start="40.49" data-duration="0.72" data-track-index="13" data-volume="0.5"></audio>
      <audio id="clk-1" src="assets/sfx/click-soft.mp3" data-start="42.60" data-duration="0.36" data-track-index="13" data-volume="0.55"></audio>
      <audio id="clk-2" src="assets/sfx/click-soft.mp3" data-start="43.50" data-duration="0.36" data-track-index="13" data-volume="0.55"></audio>
      <audio id="clk-3" src="assets/sfx/click-soft.mp3" data-start="45.30" data-duration="0.36" data-track-index="13" data-volume="0.55"></audio>

      <audio id="spark-1" src="assets/sfx/sparkle.mp3" data-start="33.05" data-duration="1.80" data-track-index="14" data-volume="0.45"></audio>
      <audio id="riser-1" src="assets/sfx/riser.mp3" data-start="45.60" data-duration="3.00" data-media-start="6.5" data-track-index="14" data-volume="0.3"></audio>
    </div>

    <script>
      window.__timelines = window.__timelines || {};
      const tl = gsap.timeline({ paused: true });

      /* ---------- fond ---------- */
      tl.fromTo("#progress", { scaleX: 0 }, { scaleX: 1, duration: 52.5, ease: "none" }, 0);
      tl.to(".particule", { y: -70, duration: 53, ease: "none" }, 0);
      tl.to("#dim-final", { autoAlpha: 1, duration: 0.55 }, 52.35);

      /* ---------- S1 · hook ---------- */
      tl.fromTo("#s1-intro", { autoAlpha: 0, y: 36 }, { autoAlpha: 1, y: 0, duration: 0.5, ease: "power3.out" }, 0.05);
      tl.to("#s1-intro", { autoAlpha: 0, y: -26, duration: 0.3, ease: "power2.in" }, 2.1);
      tl.fromTo("#s1-label", { autoAlpha: 0, y: 18 }, { autoAlpha: 1, y: 0, duration: 0.5, ease: "power2.out" }, 2.45);
      tl.fromTo("#s1-big", { autoAlpha: 0, scale: 1.7 }, { autoAlpha: 1, scale: 1, duration: 0.4, ease: "power4.out" }, 5.04);
      tl.fromTo("#s1-pill", { autoAlpha: 0, scale: 0.3 }, { autoAlpha: 1, scale: 1, duration: 0.45, ease: "back.out(2.2)" }, 6.27);
      tl.fromTo("#s1-chrono", { autoAlpha: 0, y: 30 }, { autoAlpha: 1, y: 0, duration: 0.35, ease: "power2.out" }, 8.45);
      tl.fromTo("#s1-parti", { autoAlpha: 0, x: -50 }, { autoAlpha: 1, x: 0, duration: 0.3, ease: "power3.out" }, 9.62);
      tl.to("#s1 .wrap, #s1-parti", { autoAlpha: 0, x: -60, duration: 0.22, ease: "power2.in" }, 10.36);
      tl.set("#s1 .wrap, #s1-parti", { autoAlpha: 0 }, 10.6);

      /* ---------- S2 · étape 1 ---------- */
      tl.fromTo("#s2-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 10.62);
      tl.fromTo("#s2-url .c", { autoAlpha: 0 }, { autoAlpha: 1, duration: 0.05, stagger: 0.09 }, 12.55);
      tl.to("#s2-wrap", { autoAlpha: 0, x: -60, duration: 0.2, ease: "power2.in" }, 13.7);
      tl.set("#s2-wrap", { autoAlpha: 0 }, 13.92);

      /* ---------- S3 · étape 2 ---------- */
      tl.fromTo("#s3-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 13.94);
      tl.fromTo("#s3-r1", { scaleX: 0 }, { scaleX: 1, duration: 0.5, ease: "power2.out" }, 15.9);
      tl.fromTo("#s3-r2", { scaleX: 0 }, { scaleX: 1, duration: 0.5, ease: "power2.out" }, 16.5);
      tl.fromTo("#s3-r3", { scaleX: 0 }, { scaleX: 1, duration: 0.5, ease: "power2.out" }, 17.1);
      tl.fromTo("#s3-bouton", { autoAlpha: 0, y: 26 }, { autoAlpha: 1, y: 0, duration: 0.3, ease: "power2.out" }, 18.0);
      tl.to("#s3-bouton", { scale: 0.92, duration: 0.09, ease: "power2.in" }, 18.7);
      tl.to("#s3-bouton", { scale: 1, duration: 0.14, ease: "back.out(3)" }, 18.79);
      tl.to("#s3-wrap", { autoAlpha: 0, x: -60, duration: 0.2, ease: "power2.in" }, 19.06);
      tl.set("#s3-wrap", { autoAlpha: 0 }, 19.28);

      /* ---------- S4 · étape 3 ---------- */
      tl.fromTo("#s4-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 19.3);
      tl.fromTo("#s4-plane", { autoAlpha: 0, x: -80, y: 20, rotate: -8 }, { autoAlpha: 1, x: 0, y: 0, rotate: 0, duration: 0.45, ease: "power2.out" }, 19.9);
      tl.to("#s4-plane", { x: 620, y: -180, rotate: 14, autoAlpha: 0, duration: 0.7, ease: "power2.in" }, 20.9);
      tl.fromTo("#s4-mail", { autoAlpha: 0, y: -320, scale: 0.7 }, { autoAlpha: 1, y: 0, scale: 1, duration: 0.55, ease: "bounce.out" }, 22.35);
      tl.fromTo("#s4-notif", { autoAlpha: 0, scale: 0 }, { autoAlpha: 1, scale: 1, duration: 0.3, ease: "back.out(3)" }, 22.95);
      tl.fromTo("#s4-banniere", { autoAlpha: 0, scale: 0.8 }, { autoAlpha: 1, scale: 1, duration: 0.35, ease: "back.out(1.8)" }, 23.6);
      tl.fromTo("#s4-avec", { autoAlpha: 0, y: 24 }, { autoAlpha: 1, y: 0, duration: 0.3, ease: "power2.out" }, 25.99);
      tl.to("#s4-wrap", { autoAlpha: 0, x: -60, duration: 0.2, ease: "power2.in" }, 26.66);
      tl.set("#s4-wrap", { autoAlpha: 0 }, 26.9);

      /* ---------- S5 · guide ---------- */
      tl.fromTo("#s5-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 26.92);
      tl.fromTo("#s5-l1", { autoAlpha: 0, x: 40 }, { autoAlpha: 1, x: 0, duration: 0.35, ease: "power2.out" }, 29.2);
      tl.fromTo("#s5-l2", { autoAlpha: 0, x: 40 }, { autoAlpha: 1, x: 0, duration: 0.35, ease: "power2.out" }, 30.3);
      tl.fromTo("#s5-tag", { autoAlpha: 0, scale: 0.4 }, { autoAlpha: 1, scale: 1, duration: 0.4, ease: "back.out(2.2)" }, 31.88);
      tl.to("#s5-wrap", { autoAlpha: 0, x: -60, duration: 0.2, ease: "power2.in" }, 32.26);
      tl.set("#s5-wrap", { autoAlpha: 0 }, 32.5);

      /* ---------- S6 · communauté ---------- */
      tl.fromTo("#s6-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 32.52);
      tl.fromTo("#s6-avatars .avatar", { autoAlpha: 0, scale: 0.2, y: 24 }, { autoAlpha: 1, scale: 1, y: 0, duration: 0.4, ease: "back.out(2.4)", stagger: 0.12 }, 32.95);
      tl.fromTo("#s6-titre", { autoAlpha: 0, y: 34 }, { autoAlpha: 1, y: 0, duration: 0.45, ease: "power3.out" }, 33.3);
      tl.fromTo("#s6-chip1", { autoAlpha: 0, y: 26 }, { autoAlpha: 1, y: 0, duration: 0.35, ease: "power2.out" }, 35.55);
      tl.fromTo("#s6-chip2", { autoAlpha: 0, scale: 0.4 }, { autoAlpha: 1, scale: 1, duration: 0.38, ease: "back.out(2.4)" }, 36.45);
      tl.to("#s6-wrap", { autoAlpha: 0, x: -60, duration: 0.2, ease: "power2.in" }, 37.32);
      tl.set("#s6-wrap", { autoAlpha: 0 }, 37.56);

      /* ---------- S7 · engage ---------- */
      tl.fromTo("#s7-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 37.58);
      tl.fromTo("#s7-commente", { autoAlpha: 0, scale: 0.5 }, { autoAlpha: 1, scale: 1, duration: 0.4, ease: "back.out(2)" }, 37.62);
      tl.fromTo("#s7-sous", { autoAlpha: 0, y: 22 }, { autoAlpha: 1, y: 0, duration: 0.3, ease: "power2.out" }, 38.62);
      tl.fromTo("#s7-abonne", { autoAlpha: 0, scale: 0.5 }, { autoAlpha: 1, scale: 1, duration: 0.4, ease: "back.out(2)" }, 40.42);
      tl.to("#s7-bell", { rotate: 13, duration: 0.09, yoyo: true, repeat: 5, transformOrigin: "50% 12%", ease: "sine.inOut" }, 40.85);
      tl.set("#s7-bell", { rotate: 0 }, 41.45);
      tl.to("#s7-wrap", { autoAlpha: 0, x: -60, duration: 0.2, ease: "power2.in" }, 41.36);
      tl.set("#s7-wrap", { autoAlpha: 0 }, 41.58);

      /* ---------- S8 · final ---------- */
      tl.fromTo("#s8-wrap", { autoAlpha: 0, x: 130 }, { autoAlpha: 1, x: 0, duration: 0.4, ease: "power3.out" }, 41.6);
      tl.fromTo("#s8-l1", { autoAlpha: 0, x: 40 }, { autoAlpha: 1, x: 0, duration: 0.35, ease: "power2.out" }, 42.55);
      tl.fromTo("#s8-l2", { autoAlpha: 0, x: 40 }, { autoAlpha: 1, x: 0, duration: 0.35, ease: "power2.out" }, 43.45);
      tl.fromTo("#s8-l3", { autoAlpha: 0, x: 40 }, { autoAlpha: 1, x: 0, duration: 0.35, ease: "power2.out" }, 45.25);
      tl.to("#s8-recap", { autoAlpha: 0.14, scale: 0.9, y: -60, duration: 0.4, ease: "power2.inOut" }, 48.45);
      tl.fromTo("#s8-cta", { autoAlpha: 0, scale: 0.35 }, { autoAlpha: 1, scale: 1, duration: 0.45, ease: "back.out(2)" }, 48.6);
      tl.to("#s8-cta", { scale: 1.05, duration: 0.5, yoyo: true, repeat: 4, ease: "sine.inOut" }, 49.3);

      /* ---------- sous-titres ---------- */
      {{CAPTIONS_TWEENS}}

      window.__timelines["audio-v1"] = tl;
    </script>
  </body>
</html>
