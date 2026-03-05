#!/bin/bash

# Configuración de Git
git config --global user.name 'your_user_git'
git config --global user.email 'yout_email_address@abc.com'

# Instalar oh-my-zsh primero
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Instalar fuente FiraCode
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip'
font_name=${font_url##*/}
wget ${font_url} && unzip ${font_name} -d ~/.fonts && fc-cache -fv

# Clonar powerlevel10k y tu configuración
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/SamitoX4/oh-my-sh-configuration.git ~/.oh-my-zsh-samito

# Copiar tus configuraciones personalizadas
cp ~/.oh-my-zsh-samito/p10k.zsh-template-custom-samito ~/.p10k.zsh
cp ~/.oh-my-zsh-samito/zshrc.zsh-template-custom-samito ~/.zshrc

# Limpiar
rm -r 'FiraCode.zip'

# Recargar zsh
exec zsh