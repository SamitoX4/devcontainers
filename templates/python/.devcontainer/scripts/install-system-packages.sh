#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    unzip \
    zsh \
    zsh-common \
    fonts-firacode \
    fonts-powerline \
    python3-venv \
    python3-pip \
    python3-venv \
    libpq-dev

pip3 install --upgrade pip
pip3 install virtualenv

rm -rf /var/lib/apt/lists/*
