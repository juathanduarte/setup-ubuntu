#!/bin/bash

# Atualiza o sistema e os programas
echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

# Instala wget e curl
echo "Instalando wget e curl..."
sudo apt install wget curl -y

# Instala dependências necessárias
echo "Instalando dependências necessárias..."
sudo apt install software-properties-common apt-transport-https -y

# Instala o Visual Studio Code
echo "Instalando o Visual Studio Code..."
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code -y

# Instala o Slack
echo "Instalando o Slack..."
wget -q https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
sudo dpkg -i slack-desktop-*.deb
sudo apt install -f -y

# Instala o Node.js via NVM
echo "Instalando o NVM e o Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node  # Instala a última versão do Node.js

# Instala o Yarn
echo "Instalando o Yarn..."
npm install --global yarn

# Instala o Discord
echo "Instalando o Discord..."
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt install -f -y

# Instala o Spotify
echo "Instalando o Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

# Instala o Google Chrome
echo "Instalando o Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y

echo "Configuração completa!"
