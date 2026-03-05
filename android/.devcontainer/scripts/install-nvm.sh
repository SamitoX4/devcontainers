#!/bin/bash
# install-nvm.sh – Instala nvm, múltiples versiones de Node y paquetes globales

set -e  # Detiene la ejecución si ocurre un error

# Variables que se reciben desde el Dockerfile (o se definen por defecto)
NODE_MAJOR_VERSION=${NODE_MAJOR_VERSION:-22}
EXTRA_NODE_VERSION1=${EXTRA_NODE_VERSION1:-20}
EXTRA_NODE_VERSION2=${EXTRA_NODE_VERSION2:-18}

# Instalar nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Configurar nvm en los archivos de perfil (bash y zsh)
export NVM_DIR="$HOME/.nvm"
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bashrc

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.zshrc

# Cargar nvm en la sesión actual
source $NVM_DIR/nvm.sh

# Instalar versiones de Node.js
nvm install "$NODE_MAJOR_VERSION"
nvm install "$EXTRA_NODE_VERSION1"
nvm install "$EXTRA_NODE_VERSION2"

# Establecer la versión por defecto y usarla
nvm alias default "$NODE_MAJOR_VERSION"
nvm use default

# Limpiar posibles configuraciones conflictivas de npm
npm config delete prefix
npm config delete globalconfig

# Opcional: dejar evidencia de que el script se ejecutó correctamente
echo "nvm y Node.js configurados correctamente"