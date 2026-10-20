#!/usr/bin/env python3
"""Voix off ElevenLabs pour le Studio V2.

  voix     : liste les voix d'une langue, classées de la meilleure à la moins bonne
  generer  : génère la voix off + l'horodatage mot à mot (sous-titres sans Whisper)

Exemples :
  python3 outils/elevenlabs.py voix --langue fr
  python3 outils/elevenlabs.py generer --voix <voice_id> --texte script.txt \\
          --sortie studio-v2/projets/x/voix.mp3 --langue fr

Clé d'API : variable d'environnement ELEVENLABS_API_KEY (secret de l'environnement).
Uniquement la bibliothèque standard Python — aucune dépendance à installer.
"""
import argparse, base64, json, math, os, sys, urllib.error, urllib.parse, urllib.request

API = "https://api.elevenlabs.io"
MODELE_DEFAUT = "eleven_v4"          # le plus expressif, recommandé pour la narration
MODELES_SANS_LANGUE = {"eleven_multilingual_v2"}  # refusent le paramètre language_code


def cle():
    return os.environ.get("ELEVENLABS_API_KEY") or os.environ.get("XI_API_KEY") or ""


def requete(methode, chemin, params=None, corps=None):
    url = API + chemin + ("?" + urllib.parse.urlencode(params, doseq=True) if params else "")
    entetes = {"Accept": "application/json"}
    if cle():
        entetes["xi-api-key"] = cle()
    donnees = None
    if corps is not None:
        donnees = json.dumps(corps).encode()
        entetes["Content-Type"] = "application/json"
    req = urllib.request.Request(url, data=donnees, headers=entetes, method=methode)
    try:
        with urllib.request.urlopen(req, timeout=120) as r:
            return json.loads(r.read().decode())
    except urllib.error.HTTPError as e:
        detail = e.read().decode(errors="replace")[:400]
        raise SystemExit(f"Erreur ElevenLabs {e.code} sur {chemin} : {detail}")


# ---------------------------------------------------------------- classement

def score(v, langue):
    """Score de qualité perçue — plus haut = meilleur.

    1. Voix *vérifiée* dans la langue cible (ElevenLabs a validé sa prononciation).
    2. Usage réel en production sur 12 mois (meilleur indicateur de qualité perçue).
    3. Popularité (nombre de reprises) et mise en avant officielle, en appoint.
    """
    verifiee = any((x.get("language") or "").lower() == langue
                   for x in (v.get("verified_languages") or []))
    usage = v.get("usage_character_count_1y") or 0
    clones = v.get("cloned_by_count") or 0
    return ((1000 if verifiee else 0)
            + 20 * math.log10(usage + 1)
            + 5 * math.log10(clones + 1)
            + (15 if v.get("featured") else 0))


def lister_voix(langue, nombre):
    # sans clé, l'API plafonne à 3 voix : on le signale plutôt que d'échouer
    taille = 100 if cle() else 3
    vues, voix = set(), []
    for tri in ("usage_character_count_1y", "trending"):
        rep = requete("GET", "/v1/shared-voices",
                      {"language": langue, "page_size": taille, "sort": tri})
        for v in rep.get("voices", []):
            if v["voice_id"] not in vues:
                vues.add(v["voice_id"])
                voix.append(v)
    voix.sort(key=lambda v: score(v, langue), reverse=True)
    return voix[:nombre]


def afficher(voix, langue):
    print(f"\nVoix ElevenLabs — langue « {langue} » — de la meilleure à la moins bonne\n")
    for i, v in enumerate(voix, 1):
        verif = any((x.get("language") or "").lower() == langue
                    for x in (v.get("verified_languages") or []))
        profil = " · ".join(x for x in [v.get("gender"), v.get("age"), v.get("accent"),
                                        v.get("use_case")] if x)
        cout = f" · coût ×{v['rate']}" if (v.get("rate") or 1) > 1 else ""
        print(f"{i:>2}. {v['name']}  —  {profil}{' · vérifiée' if verif else ''}{cout}")
        if v.get("description"):
            print(f"    {v['description'][:110]}")
        print(f"    id : {v['voice_id']}")
        if v.get("preview_url"):
            print(f"    écouter : {v['preview_url']}")
    if not cle():
        print("\n⚠ Aucune clé ELEVENLABS_API_KEY : l'API limite la liste à 3 voix.")


# ---------------------------------------------------------------- génération

def mots_depuis_alignement(al):
    """Caractères horodatés → [{text, start, end}] (format de `hyperframes transcribe`)."""
    mots, cour, debut, fin = [], "", None, None
    for c, s, e in zip(al["characters"], al["character_start_times_seconds"],
                       al["character_end_times_seconds"]):
        if c.isspace():
            if cour:
                mots.append({"text": cour, "start": round(debut, 3), "end": round(fin, 3)})
            cour, debut = "", None
            continue
        if debut is None:
            debut = s
        cour += c
        fin = e
    if cour:
        mots.append({"text": cour, "start": round(debut, 3), "end": round(fin, 3)})
    return mots


def ajouter_a_mon_compte(voice_id):
    """Une voix de la bibliothèque doit parfois être ajoutée au compte avant usage."""
    rep = requete("GET", "/v1/shared-voices", {"search": voice_id, "page_size": 1})
    for v in rep.get("voices", []):
        if v["voice_id"] == voice_id:
            requete("POST", f"/v1/voices/add/{v['public_owner_id']}/{voice_id}",
                    corps={"new_name": v["name"]})
            return True
    return False


def generer(voice_id, texte, sortie, modele, langue, stabilite, vitesse):
    if not cle():
        raise SystemExit("ELEVENLABS_API_KEY absente : impossible de générer la voix.")
    if len(texte) > 9500:
        raise SystemExit(f"Texte trop long ({len(texte)} caractères) : le découper en parties.")
    corps = {"text": texte, "model_id": modele,
             "voice_settings": {"stability": stabilite, "similarity_boost": 0.75,
                                "style": 0, "speed": vitesse, "use_speaker_boost": True}}
    if langue and modele not in MODELES_SANS_LANGUE:
        corps["language_code"] = langue
    chemin = f"/v1/text-to-speech/{voice_id}/with-timestamps"
    params = {"output_format": "mp3_44100_192"}
    try:
        rep = requete("POST", chemin, params, corps)
    except SystemExit as err:
        if "voice_not_found" not in str(err) and "404" not in str(err):
            raise
        if not ajouter_a_mon_compte(voice_id):
            raise
        rep = requete("POST", chemin, params, corps)

    os.makedirs(os.path.dirname(os.path.abspath(sortie)), exist_ok=True)
    with open(sortie, "wb") as f:
        f.write(base64.b64decode(rep["audio_base64"]))
    al = rep.get("alignment") or rep.get("normalized_alignment")
    mots = mots_depuis_alignement(al) if al else []
    chemin_mots = os.path.splitext(sortie)[0] + ".transcript.json"
    with open(chemin_mots, "w") as f:
        json.dump(mots, f, ensure_ascii=False, indent=1)
    print(f"Voix off : {sortie}")
    print(f"Horodatage : {chemin_mots} ({len(mots)} mots)")


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sp = p.add_subparsers(dest="cmd", required=True)

    a = sp.add_parser("voix", help="lister les voix d'une langue, classées")
    a.add_argument("--langue", required=True, help="code langue : fr, en, es, de…")
    a.add_argument("--nombre", type=int, default=12)
    a.add_argument("--json", help="enregistrer aussi la liste dans ce fichier")

    g = sp.add_parser("generer", help="générer la voix off")
    g.add_argument("--voix", required=True, help="voice_id")
    g.add_argument("--texte", required=True, help="fichier texte du script")
    g.add_argument("--sortie", required=True, help="fichier .mp3")
    g.add_argument("--modele", default=MODELE_DEFAUT)
    g.add_argument("--langue", default="fr")
    g.add_argument("--stabilite", type=float, default=0.5)
    g.add_argument("--vitesse", type=float, default=1.0)

    args = p.parse_args()
    if args.cmd == "voix":
        voix = lister_voix(args.langue.lower(), args.nombre)
        afficher(voix, args.langue.lower())
        if args.json:
            with open(args.json, "w") as f:
                json.dump(voix, f, ensure_ascii=False, indent=1)
    else:
        texte = open(args.texte, encoding="utf-8").read().strip()
        generer(args.voix, texte, args.sortie, args.modele, args.langue,
                args.stabilite, args.vitesse)


if __name__ == "__main__":
    main()
