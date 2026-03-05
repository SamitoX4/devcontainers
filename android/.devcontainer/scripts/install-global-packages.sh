#!/bin/bash
# install-global-packages.sh – Instala paquetes globales con npm

set -e

# Cargar nvm (se espera que NVM_DIR esté definido)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Instalar paquetes
npm install -g @nestjs/cli@latest typescript@latest pnpm

echo "Paquetes globales instalados correctamente"