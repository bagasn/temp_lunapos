#!/bin/bash

# Panggil konstanta dan logika pengunduhan
source ./scripts/setup_drift_web.sh

echo "🚀 Building Luna POS (PROD)..."
flutter build web \
  --target lib/main_prod.dart \
  --release
  
echo "✅ Build PROD selesai → build/web/"

