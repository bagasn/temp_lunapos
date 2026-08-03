#!/bin/bash
echo "Generating Drift tables from MiddleBackend..."
node "$(dirname "$0")/generate_drift_tables.js"
echo "Running build_runner..."
cd "$(dirname "$0")/.."
dart run build_runner build --delete-conflicting-outputs
echo "Done!"
