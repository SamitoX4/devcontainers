#!/bin/bash
set -e

echo 'source $NVM_DIR/nvm.sh' >> /home/node/.bashrc
echo 'source $NVM_DIR/nvm.sh' >> /home/node/.zshrc

cat >> /home/node/.bashrc << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools
EOF

cat >> /home/node/.zshrc << 'EOF'
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export ANDROID_SDK_ROOT=/usr/local/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools
EOF
