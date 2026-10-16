#!/usr/bin/env bash
# ============================================================
# Studio vidéo — préparation de l'environnement de session
#
# À lancer au début de chaque nouvelle session cloud :
#   bash outils/setup.sh
#
# Idempotent : ne réinstalle que ce qui manque.
# ============================================================
set -uo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "== 1/4 ffmpeg (extraction audio, encodage) =="
if ! command -v ffmpeg >/dev/null 2>&1; then
  apt-get update -qq && apt-get install -y -qq ffmpeg
fi
ffmpeg -version 2>/dev/null | head -1

echo "== 2/4 whisper-cli (transcription voix off) =="
if ! command -v whisper-cli >/dev/null 2>&1; then
  install -m 0755 "$DIR/bin/whisper-cli" /usr/local/bin/whisper-cli
fi
whisper-cli --help >/dev/null 2>&1 && echo "whisper-cli : OK"

echo "== 3/4 Navigateur de rendu HyperFrames =="
npx -y hyperframes@latest browser ensure 2>&1 | tail -2

echo "== 4/4 Modèle Whisper multilingue (français) =="
MODELS_DIR="$HOME/.cache/hyperframes/whisper/models"
MODEL="$MODELS_DIR/ggml-small.bin"
mkdir -p "$MODELS_DIR"
if [ -f "$MODEL" ]; then
  echo "Modèle déjà présent : $MODEL"
elif curl -fsSL --connect-timeout 10 -o "$MODEL.part" \
    "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin"; then
  mv "$MODEL.part" "$MODEL"
  echo "Modèle téléchargé : $MODEL"
else
  rm -f "$MODEL.part"
  echo "ATTENTION : huggingface.co inaccessible (politique réseau de l'environnement)."
  echo "La transcription automatique restera indisponible tant que le réseau ne l'autorise pas."
  echo "-> Voir GUIDE-MONTAGE.md, section « Débloquer le réseau »."
fi

echo "== Environnement prêt =="
