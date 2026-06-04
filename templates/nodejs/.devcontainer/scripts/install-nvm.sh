#!/bin/bash
set -e

NODE_MAJOR_VERSION="${NODE_MAJOR_VERSION:-22}"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

export NVM_DIR="$HOME/.nvm"
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc

source $NVM_DIR/nvm.sh

# Support comma-separated list of versions (e.g. "20,22")
IFS=',' read -ra VERSIONS <<< "$NODE_MAJOR_VERSION"

for v in "${VERSIONS[@]}"; do
    v=$(echo "$v" | xargs) # trim whitespace
    nvm install "$v"
done

nvm install lts/*

# Use the last selected version as default
DEFAULT_VERSION="${VERSIONS[-1]}"
DEFAULT_VERSION=$(echo "$DEFAULT_VERSION" | xargs) # trim whitespace

nvm alias default "$DEFAULT_VERSION"
nvm use default

npm config delete prefix
npm config delete globalconfig

echo "nvm y Node.js configurados correctamente"
