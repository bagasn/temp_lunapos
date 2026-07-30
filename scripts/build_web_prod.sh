#!/bin/bash
echo "🚀 Building Luna POS (PROD)..."
flutter build web \
  --target lib/main_prod.dart \
  --release \
  --web-renderer canvaskit
echo "✅ Build PROD selesai → build/web/"
