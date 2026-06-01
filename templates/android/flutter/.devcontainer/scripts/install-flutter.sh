#!/bin/bash
set -e

FLUTTER_DIR="/opt/flutter"

echo "Clonando Flutter stable..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"

export PATH="$PATH:${FLUTTER_DIR}/bin"

echo "Ejecutando flutter doctor..."
flutter doctor

echo "Aceptando licencias Android..."
flutter doctor --android-licenses || true

echo "Flutter instalado en ${FLUTTER_DIR}"
