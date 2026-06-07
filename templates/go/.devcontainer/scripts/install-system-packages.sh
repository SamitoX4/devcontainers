#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    wget \
    unzip \
    git \
    gnupg \
    zsh \
    zsh-common \
    fonts-firacode \
    fonts-powerline \
    python3 \
    python3-pip

rm -rf /var/lib/apt/lists/*
