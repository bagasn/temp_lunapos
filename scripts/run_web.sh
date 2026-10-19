#!/bin/bash

# 1. Cek argumen flavor
if [ "$1" != "dev" ] && [ "$1" != "prod" ]; then
  echo "❌ Error: Argumen flavor tidak valid atau kosong."
  echo "Gunakan: ./scripts/run_web.sh [dev|prod]"
  exit 1
fi

FLAVOR=$1
TARGET="lib/main_${FLAVOR}.dart"

# 2. Persiapan file WASM melalui source
source ./scripts/setup_drift_web.sh

# 3. Menjalankan flutter ke target browser
echo "🚀 Running Luna POS ($FLAVOR) di browser..."
flutter run -d chrome \
  --web-browser-flag "--disable-web-security" \
  --target "$TARGET" \
  --web-header="Cross-Origin-Opener-Policy=same-origin" \
  --web-header="Cross-Origin-Embedder-Policy=require-corp"
