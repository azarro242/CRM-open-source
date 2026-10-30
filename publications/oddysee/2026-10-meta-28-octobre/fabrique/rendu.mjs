// Rendu des visuels de l'article (PNG) et du guide (PDF) avec le Chromium de Playwright.
//   node rendu.mjs visuels   → ../article/images/*.png
//   node rendu.mjs guide     → ../guide/guide-meta-ads-oddysee.pdf
import { createRequire } from "module";
import path from "path";
import { fileURLToPath } from "url";
const require = createRequire(import.meta.url);
const { chromium } = require("playwright");
const ICI = path.dirname(fileURLToPath(import.meta.url));
const quoi = process.argv[2] || "visuels";

const navigateur = await chromium.launch();
const page = await navigateur.newPage({ deviceScaleFactor: 1 });

if (quoi === "visuels") {
  await page.setViewportSize({ width: 1700, height: 1000 });
  await page.goto("file://" + path.join(ICI, "graphiques.html"));
  await page.evaluate(() => document.fonts.ready);
  const noms = {
    "g-og": "partage-1200x630", "g-calendrier": "calendrier-meta-ads", "g-chemin": "desactiver-navigation-produit",
    "g-ab": "test-ab-navigation-produit", "g-robots": "robots-txt-meta", "g-checklist": "checklist-meta-ads",
  };
  for (const [id, nom] of Object.entries(noms)) {
    await page.locator("#" + id).screenshot({ path: path.join(ICI, "..", "article", "images", nom + ".png") });
    console.log("image :", nom);
  }
} else {
  // couverture sans pied de page, puis contenu numéroté ; assemblés par fabriquer.py
  await page.goto("file://" + path.join(ICI, "guide-couverture.html"));
  await page.evaluate(() => document.fonts.ready);
  await page.pdf({ path: path.join(ICI, "couverture.pdf"), format: "A4", printBackground: true,
                   margin: { top: 0, right: 0, bottom: 0, left: 0 } });
  await page.goto("file://" + path.join(ICI, "guide.html"));
  await page.evaluate(() => document.fonts.ready);
  const pied = `<div style="width:100%;padding:0 16mm;font:8px sans-serif;color:#6f6a7a;display:flex;justify-content:space-between">
    <span>Oddysee · Les bonnes pratiques Meta Ads · octobre 2026</span>
    <span>oddysee.fr · page <span class="pageNumber"></span>/<span class="totalPages"></span></span></div>`;
  await page.pdf({ path: path.join(ICI, "contenu.pdf"), format: "A4", printBackground: true,
                   displayHeaderFooter: true, headerTemplate: "<span></span>", footerTemplate: pied,
                   margin: { top: "16mm", right: "16mm", bottom: "18mm", left: "16mm" } });
  console.log("PDF : couverture + contenu");
}
await navigateur.close();
