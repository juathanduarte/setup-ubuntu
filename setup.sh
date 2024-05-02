#!/bin/bash

total_steps=12
current_step=1

clear_step() {
    clear
    echo "Etapa $current_step/$total_steps..."
}

# Atualiza o sistema e os programas
clear_step
echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y
((current_step++))

# Instala wget e curl
clear_step
echo "Instalando wget e curl..."
sudo apt install wget curl -y
((current_step++))

# Instala dependências necessárias
clear_step
echo "Instalando dependências necessárias..."
sudo apt install software-properties-common apt-transport-https -y
((current_step++))

# Instala o Visual Studio Code
clear_step
echo "Instalando o Visual Studio Code..."
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code -y
((current_step++))

# Instala o Slack
clear_step
echo "Instalando o Slack..."
wget -q https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
sudo dpkg -i slack-desktop-*.deb
sudo apt install -f -y
((current_step++))

# Instala o Node.js via NVM
clear_step
echo "Instalando o NVM e o Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node  # Instala a última versão do Node.js
((current_step++))

# Instala o Yarn
clear_step
echo "Instalando o Yarn..."
npm install --global yarn
((current_step++))

# Instala o Discord
clear_step
echo "Instalando o Discord..."
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt install -f -y
((current_step++))

# Instala o Spotify
clear_step
echo "Instalando o Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y
((current_step++))

# Instala o Google Chrome
clear_step
echo "Instalando o Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f -y
((current_step++))

# Instala e configura o Oh My ZSH
clear_step
echo "Instalando e configurando o Oh My Zsh..."
sudo apt-get install zsh
sudo add-apt-repository ppa:git-core/ppa ; sudo apt update ; sudo apt-get install git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
exec zsh
((current_step++))

# Instala o tema Spaceship
clear_step
echo "Instalando o tema Spaceship para o Oh My Zsh..."
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Configura o tema Spaceship no arquivo .zshrc
echo "Configurando o tema Spaceship..."
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="spaceship"/' ~/.zshrc

cat <<EOF >> ~/.zshrc
SPACESHIP_PROMPT_ORDER=(
  user # Username section
  dir # Current directory section
  host # Hostname section
  git # Git section (git_branch + git_status)
  hg # Mercurial section (hg_branch + hg_status)
  exec_time # Execution time
  line_sep # Line break
  jobs # Background jobs indicator
  exit_code # Exit code section
  char # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
EOF
((current_step++))

# Instala plugins
clear_step
echo "Instalando plugins para o Zsh..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Adiciona plugins no arquivo .zshrc
echo "Configurando plugins no .zshrc..."
sed -i 's/^plugins=(.*)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
((current_step++))

# Recarrega as configurações do Zsh
clear_step
echo "Recarregando as configurações do Zsh..."
source ~/.zshrc
((current_step++))

echo "Configuração completa!"

echo "Configuração completa!"
