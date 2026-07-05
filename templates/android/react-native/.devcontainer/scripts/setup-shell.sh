#!/bin/bash
set -e
# Este template usa el usuario `node` que ya viene en la imagen base node:<variant>
REMOTE_USER="node"

if [ "${REMOTE_USER}" = "root" ]; then
    USER_HOME="/root"
else
    USER_HOME="/home/${REMOTE_USER}"
fi

echo 'source $NVM_DIR/nvm.sh' >> ${USER_HOME}/.bashrc
echo 'source $NVM_DIR/nvm.sh' >> ${USER_HOME}/.zshrc
echo 'export PATH=$PATH:$HOME/.local/bin' >> ${USER_HOME}/.bashrc
echo 'export PATH=$PATH:$HOME/.local/bin' >> ${USER_HOME}/.zshrc

cat >> ${USER_HOME}/.bashrc << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools
EOF

cat >> ${USER_HOME}/.zshrc << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools
EOF
