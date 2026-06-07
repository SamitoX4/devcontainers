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

echo "Clonando configuraciones personalizadas..."
git clone https://github.com/SamitoX4/oh-my-sh-configuration.git ~/.oh-my-zsh-samito

cp ~/.oh-my-zsh-samito/p10k.zsh-template-custom-samito ~/.p10k.zsh
cp ~/.oh-my-zsh-samito/zshrc.zsh-template-custom-samito ~/.zshrc

rm -f ${font_name}

echo "DevContainer configurado correctamente"


# Clean up NVM references in .zshrc for non-Node.js templates
if [ ! -f "$HOME/.nvm/nvm.sh" ]; then
    awk '/# NVM Configuration/{skip=1; next} skip && /source [$]NVM_DIR\/nvm.sh/{skip=0; next} skip{next} 1' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc
fi

exec zsh
