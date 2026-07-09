#!/bin/bash
set -e

apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    gnupg \
    zsh \
    zsh-common \
    fonts-firacode \
    fonts-powerline \
    python3 \
    python3-pip

docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

rm -rf /var/lib/apt/lists/*
