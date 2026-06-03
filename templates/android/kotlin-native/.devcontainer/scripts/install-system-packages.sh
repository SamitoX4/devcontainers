#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    wget \
    unzip \
    git \
    adb \
    curl \
    lsb-release \
    gnupg \
    software-properties-common \
    zsh \
    zsh-common \
    fonts-firacode \
    fonts-powerline \
    python3 \
    python3-pip \
    ca-certificates \
    libc6 \
    libstdc++6

rm -rf /var/lib/apt/lists/*

# Install Kotlin compiler standalone
KOTLIN_VERSION="${KOTLIN_VERSION:-2.0.21}"
echo "Installing Kotlin compiler ${KOTLIN_VERSION}..."
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
wget -q "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" -O kotlin-compiler.zip
unzip -q kotlin-compiler.zip -d /opt/
rm -f kotlin-compiler.zip
cd /
rm -rf "$TMP_DIR"

ln -sf /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc
ln -sf /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin
echo "Kotlin compiler installed"
