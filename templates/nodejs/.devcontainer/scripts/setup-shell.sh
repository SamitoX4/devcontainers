#!/bin/bash
set -e

# Add local bin to PATH if not already present
if ! grep -q "\.local/bin" /home/node/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/node/.bashrc
fi

if ! grep -q "\.local/bin" /home/node/.zshrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/node/.zshrc
fi

echo 'source $NVM_DIR/nvm.sh' >> /home/node/.bashrc
echo 'source $NVM_DIR/nvm.sh' >> /home/node/.zshrc
