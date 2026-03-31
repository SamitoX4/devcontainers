#!/bin/bash
set -e

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

npm install -g typescript ts-node pnpm @nestjs/cli @react-native-community/cli

echo "Paquetes globales instalados correctamente"
