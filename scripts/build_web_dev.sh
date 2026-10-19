#!/bin/bash

# Panggil konstanta dan logika pengunduhan
source ./scripts/setup_drift_web.sh

echo "🚀 Building Luna POS (DEV)..."
flutter build web \
  --target lib/main_dev.dart \
  --release
  
echo "✅ Build DEV selesai → build/web/"

