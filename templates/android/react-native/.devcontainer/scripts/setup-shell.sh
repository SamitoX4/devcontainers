#!/bin/bash
set -e
REMOTE_USER="${REMOTE_USER:-developer}"

echo 'source $NVM_DIR/nvm.sh' >> /home/${REMOTE_USER}/.bashrc
echo 'source $NVM_DIR/nvm.sh' >> /home/${REMOTE_USER}/.zshrc
echo 'export PATH=$PATH:$HOME/.local/bin' >> /home/${REMOTE_USER}/.bashrc
echo 'export PATH=$PATH:$HOME/.local/bin' >> /home/${REMOTE_USER}/.zshrc

cat >> /home/${REMOTE_USER}/.bashrc << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools
EOF

cat >> /home/${REMOTE_USER}/.zshrc << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools
EOF
