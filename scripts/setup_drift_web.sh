#!/bin/bash

echo "⚙️ Membaca versi Drift dan Sqlite3 dari pubspec.lock..."
DRIFT_VERSION=$(awk '/^  drift:$/{flag=1} flag && /^    version:/{print $2; exit}' pubspec.lock | tr -d '"')
SQLITE_VERSION=$(awk '/^  sqlite3:$/{flag=1} flag && /^    version:/{print $2; exit}' pubspec.lock | tr -d '"')

if [ -z "$DRIFT_VERSION" ] || [ -z "$SQLITE_VERSION" ]; then
  echo "❌ Error: Tidak dapat menemukan versi drift atau sqlite3 di pubspec.lock"
  exit 1
fi

echo "🔍 Detected Drift version: $DRIFT_VERSION"
echo "🔍 Detected Sqlite3 version: $SQLITE_VERSION"

SQLITE_URL="https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-${SQLITE_VERSION}/sqlite3.wasm"
WORKER_URL="https://github.com/simolus3/drift/releases/download/drift-${DRIFT_VERSION}/drift_worker.js"

echo "⚙️ Menyiapkan dependensi Drift WebAssembly..."

if [ ! -f "web/sqlite3.wasm" ]; then
  echo "⬇️ Mengunduh sqlite3.wasm dari:"
  echo "   $SQLITE_URL"
  curl -L -o web/sqlite3.wasm $SQLITE_URL
fi

if [ ! -f "web/drift_worker.js" ]; then
  echo "⬇️ Mengunduh drift_worker.js dari:"
  echo "   $WORKER_URL"
  curl -L -o web/drift_worker.js $WORKER_URL
fi
