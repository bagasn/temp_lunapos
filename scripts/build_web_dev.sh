#!/bin/bash
echo "🚀 Building Luna POS (DEV)..."
flutter build web \
  --target lib/main_dev.dart \
  --release \
  --web-renderer canvaskit
echo "✅ Build DEV selesai → build/web/"
