#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"

echo "Installing shared tools..."

curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

apt-get update
apt-get install -y doppler google-cloud-cli

if id ${REMOTE_USER} &>/dev/null; then
    echo "Installing opencode and claude for user 'node'..."
    su - ${REMOTE_USER} -c "mkdir -p ~/.local/bin"
    
    echo "Installing opencode..."
    if curl -fsSL https://opencode.ai/install 2>/dev/null | HOME=/home/${REMOTE_USER} su - ${REMOTE_USER} -c "bash -s" 2>&1; then
        echo "✓ opencode installed"
    else
        echo "⚠ opencode installation may have failed, trying alternative method..."
        OPENCODE_VERSION=$(curl -sL https://api.github.com/repos/opencode-ai/opencode/releases/latest 2>/dev/null | grep -oP '"tag_name":\s*"\K[^"]+' | sed 's/v//' || echo "latest")
        su - ${REMOTE_USER} -c "cd /tmp && curl -fsSL https://github.com/opencode-ai/opencode/releases/download/v${OPENCODE_VERSION}/opencode-linux-x64.tar.gz -o opencode.tar.gz && tar -xzf opencode.tar.gz && mv opencode /home/${REMOTE_USER}/.local/bin/ && chmod +x /home/${REMOTE_USER}/.local/bin/opencode && rm -rf opencode opencode.tar.gz" 2>&1 || echo "⚠ opencode alternative install failed"
    fi
    
    echo "Installing claude..."
    if curl -fsSL https://claude.ai/install.sh 2>/dev/null | HOME=/home/${REMOTE_USER} su - ${REMOTE_USER} -c "bash -s" 2>&1; then
        echo "✓ claude installed"
    else
        echo "⚠ claude installation may have failed, trying alternative method..."
        CLAUDE_VERSION=$(curl -sL https://api.github.com/repos/anthropics/claude-cli/releases/latest 2>/dev/null | grep -oP '"tag_name":\s*"\K[^"]+' | sed 's/v//' || echo "latest")
        su - ${REMOTE_USER} -c "cd /tmp && curl -fsSL https://github.com/anthropics/claude-cli/releases/download/v${CLAUDE_VERSION}/claude-linux-x86_64.tar.gz -o claude.tar.gz && tar -xzf claude.tar.gz && mv claude /home/${REMOTE_USER}/.local/bin/ && chmod +x /home/${REMOTE_USER}/.local/bin/claude && rm -rf claude claude.tar.gz" 2>&1 || echo "⚠ claude alternative install failed"
    fi
else
    echo "⚠ User 'node' not found, skipping user-specific installations"
fi

echo "Shared tools installation completed"
