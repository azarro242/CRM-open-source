# Recadre les portraits en carré centré sur le visage -> assets/img/p-*.webp (600 px)
from PIL import Image
import sys, json
C = {  # nom: (source, cx, cy, taille) fractions de la largeur/hauteur ; taille = fraction de la largeur
 "debutant":   ("sources/uniques/u077.jpg", .50, .30, .62),
 "amateur":    ("sources/uniques/u046.jpg", .52, .30, .42),
 "pro":        ("sources/uniques/u009.png", .66, .19, .40),
 "expert":     ("sources/uniques/u013.png", .50, .30, .60),
 "dirigeant":  ("sources/uniques/u066.webp", .46, .30, .46),
 "g1": ("sources/uniques/u090.png", .50, .40, .60),
 "g2": ("sources/uniques/u084.jpg", .50, .26, .62),
 "g3": ("sources/uniques/u033.jpg", .50, .30, .66),
 "g4": ("sources/uniques/u082.png", .50, .30, .56),
 "g5": ("sources/uniques/u104.jpg", .54, .30, .55),
 "g6": ("sources/uniques/u119.jpg", .50, .30, .70),
 "g7": ("sources/uniques/u080.jpg", .50, .24, .55),
 "alvarez": ("assets/img/equipe-alvarez.png", .55, .30, .62),
 "hamza":   ("assets/img/equipe-hamza.png", .50, .30, .50),
 "imad":    ("assets/img/equipe-imad.png", .50, .30, .50),
 "redwan":  ("assets/img/equipe-redwan.png", .50, .30, .62),
}
for k,(f,cx,cy,s) in C.items():
    im = Image.open(f).convert("RGB"); w,h = im.size; side = s*w
    x0 = max(0,min(w-side, cx*w-side/2)); y0 = max(0,min(h-side, cy*h-side/2))
    im.crop((int(x0),int(y0),int(x0+side),int(y0+side))).resize((600,600), Image.LANCZOS).save(f"assets/img/p-{k}.webp", quality=90)
print("ok")
