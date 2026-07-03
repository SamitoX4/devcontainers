#!/bin/bash

set -e

echo "Configurando entorno DevContainer..."

if [ -n "$GIT_USER_NAME" ] && [ -n "$GIT_USER_EMAIL" ]; then
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
else
    echo "Advertencia: GIT_USER_NAME o GIT_USER_EMAIL no están configurados"
fi

echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Instalando FiraCode Nerd Font..."
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip'
font_name=${font_url##*/}

wget -q ${font_url}
unzip -q ${font_name} -d ~/.fonts
fc-cache -fv

echo "Instalando Powerlevel10k..."
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo "Instalando plugins de oh-my-zsh..."
[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "Aplicando configuración local de zsh (.devcontainer/zsh-config)..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSH_CONFIG_DIR="$(dirname "$SCRIPT_DIR")/zsh-config"

if [ -f "$ZSH_CONFIG_DIR/zshrc" ]; then
    cp "$ZSH_CONFIG_DIR/zshrc" ~/.zshrc
fi
if [ -f "$ZSH_CONFIG_DIR/p10k.zsh" ]; then
    cp "$ZSH_CONFIG_DIR/p10k.zsh" ~/.p10k.zsh
fi

rm -f ${font_name}

echo "DevContainer configurado correctamente"

exec zsh
