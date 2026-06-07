#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
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
    default-mysql-client \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1

rm -rf /var/lib/apt/lists/*
