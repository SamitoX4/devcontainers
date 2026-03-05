#!/bin/bash
set -e
apt-get update
apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    yarn \
    neofetch \
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
    fonts-powerline
rm -rf /var/lib/apt/lists/*