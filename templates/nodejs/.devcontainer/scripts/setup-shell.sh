#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"

# Add local bin to PATH if not already present
if ! grep -q "\.local/bin" /home/${REMOTE_USER}/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/${REMOTE_USER}/.bashrc
fi

if ! grep -q "\.local/bin" /home/${REMOTE_USER}/.zshrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/${REMOTE_USER}/.zshrc
fi

echo 'source $NVM_DIR/nvm.sh' >> /home/${REMOTE_USER}/.bashrc
echo 'source $NVM_DIR/nvm.sh' >> /home/${REMOTE_USER}/.zshrc
