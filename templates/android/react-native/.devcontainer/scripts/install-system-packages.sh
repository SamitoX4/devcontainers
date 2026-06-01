#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    openjdk-17-jdk \
    gradle \
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
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    ca-certificates

rm -rf /var/lib/apt/lists/*
