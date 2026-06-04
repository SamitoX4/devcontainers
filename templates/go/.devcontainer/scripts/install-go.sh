#!/bin/bash
set -e

GO_VERSION="${GO_VERSION:-1.22.0}"
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

echo "Descargando Go..."
wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

echo "Instalando Go..."
rm -rf /usr/local/go
tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

rm -rf ${TMP_DIR}

echo "Go instalado correctamente"
