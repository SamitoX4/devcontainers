#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    maven \
    wget \
    unzip \
    git \
    curl \
    lsb-release \
    gnupg \
    software-properties-common \
    zsh \
    zsh-common \
    fonts-firacode \
    fonts-powerline \
    python3 \
    python3-pip

rm -rf /var/lib/apt/lists/*
