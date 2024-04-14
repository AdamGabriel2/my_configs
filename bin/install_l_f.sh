#!/bin/bash
#
# install_l_f.sh - Instalar e configura programas no Linux Mint (22.0 ou superior)
#
# ------------------------------------------------------------------------------------------- #
#
# COMO USAR?
#   $ ./install_l_f.sh
#
# ------------------------------------------------------------------------------------------- #

# ---------------------------------------- VARIÁVEIS ---------------------------------------- #
set -e

## CORES ##

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


# ----------------------------------------- FUNÇÕES ----------------------------------------- #

## Atualizando repositório e fazendo atualização do sistema ##

full-att(){
  sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo flatpak update -y
}

# ----------------------------------- TESTES E REQUISITOS ----------------------------------- #

## Internet conectando? ##
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

# ------------------------------------------------------------------------------------------- #


## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}

## Programas e Linguagens para instalar ##

LINGUAGENS_PARA_INSTALAR=(
  bash
  zsh
  php
  python3-all
  python3-pip
  mono-complete
  gcc
  g++
  build-essential
  dotnet8
  clang
  ruby-full
  golang
)

# ------------------------------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_alls(){
## Instalar programas no apt ##
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

for nome_do_programa in ${LINGUAGENS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done
}

## Instalação de outras linguagens de programação e frameworks que eu utilizo ##

install_outros(){
## Ruby on Rails com o rbenv ##
sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
type rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install -l
echo "gem: --no-document" > ~/.gemrc
gem install bundler
gem env home
gem install rails -v 5.2.0
rbenv rehash
rails -v
cd ~/.rbenv
git pull

## Instação/Atualização do Insomnia ##
wget https://github.com/Kong/insomnia/releases/download/core%408.6.1/Insomnia.Core-8.6.1.deb
sudo dpkg -i Imsomnia.Core-8.6.1.deb

## Intalar/Atualizar SDKMAN ##
curl -s "https://get.sdkman.io" | bash

## Instalação do Spring Tool Suite
cd /home/$USER/Downloads
sudo tar zxvf spring-tool-suite-4–4.19.1.RELEASE-e4.28.0-linux.gtk.x86_64.tar.gz
sudo mv sts-4.19.1.RELEASE/ /opt/SpringToolSuite
cd /opt/
sudo ln -s /opt/SpringToolSuite/SpringToolSuite4 /usr/local/bin/sts
sudo cat > /usr/share/applications/stsLauncher.desktop <<EOF
[Desktop Entry]
Name=Spring Tool Suite
Comment=Spring Tool Suite 4.19.1
Exec=/opt/SpringToolSuite/SpringToolSuite4
Icon=/opt/SpringToolSuite/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Categories=Development;IDE;Java;
EOF

## Instalar Laravel ##
sudo apt update sudo apt install apache2
sudo systemctl enable apache2 sudo systemctl start apache2
sudo apt install mariadb-server
sudo mysql_secure_installation
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar
sudo chmod +x /usr/local/bin/composer
php -v mysql --version composer -V
composer create-project --prefer-dist laravel/laravel app-name

## Instalação do Electron ##
npm install electron
npm install electron-packager

## Instalar/Atualizar Rust ##
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Verificar se o Cargo foi instalado ##
cargo -v

## Instalação de dependencias e do Flutter e Dart ##
## Dependencias ##
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa
sudo apt install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

## Instalação do Flutter e Dart ##
cd $DIRETORIO_DOWNLOADS
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.5-stable.tar.xz
tar xf flutter_linux_3.19.5-stable.tar.xz
sudo mv flutter/ /opt
echo 'export PATH="/opt/flutter/bin:$PATH"' >> ~/.bashrc
cd $HOME
source ~/.bashrc

## Verificar se o Flutter e Dart foram instalados ##
flutter -v
dart -v

## Instalar/Atualizar o symfony ##
cd $DIRETORIO_DOWNLOADS
wget https://get.symfony.com/cli/installer -O - | bash
sudo mv .symfony5/bin/symfony /usr/local/bin/symfony

## Instalação do NVM ##
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.x/install.sh | bash
source ~/.bashrc

## Verificar se o nvm foi instalado ##
nvm -v

## Frameworks NPM e PIP ##

## Instalação dos pacotes necessarios ##
## Instalar node ##
nvm install node

## Instalar ultima versão do npm ##
nvm install-latest-npm

## Instalar pip ##
sudo apt install python3-pip

## Verificar se os pacotes foram instalados ##
node -v
npm -v
pip -v

# Atualização do Angular
npm install -g @angular/cli

# Atualização do Express
npm install -g express

# Atualização do React
npm install -g create-react-app

# Atualização do GraphQL
npm install -g graphql-cli

# Atualização do node-sass
npm install -g node-sass

# Atualização do Bootstrap
npm install -g bootstrap

# Atualização do jQuery
npm install -g jquery

# Atualização do Django
pip install django

# Atualização do Flask
pip install flask

# Verificando e corrigindo vulnerabilidades de segurança nos pacotes npm instalados
npm audit fix

# Verificando por vulnerabilidades de segurança nos pacotes npm instalados
npm audit

# Verificando se há pacotes desatualizados e atualizando-os para suas versões mais recentes
npm outdated
npm update

# Atualizar as versões no package.json, dependencies e devdependencies
npm install -g npm-check-updates
ncu -u

# Executar atualizacações e instalar novas versões das dependencias
npm update
npm install

# Atualizando todos os pacotes Python instalados para suas versões mais recentes
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

# Verificando por vulnerabilidades de segurança nos pacotes Python instalados
pip install safety
safety check

## Atualização do sistema e instalação de pacotes necessários ##

sudo apt update -y
sudo apt upgrade -y

## Configuração do sistema ##

sudo dpkg --configure -a

echo "Todos os pacotes e linguagens foram atualizados com sucesso."

}

# ------------------------------------------------------------------------------------------- #
# -------------------------------------- PÓS-INSTALAÇÃO ------------------------------------- #


## Finalização, atualização e limpeza ##

full-lmp(){
  sudo apt update -y && sudo apt autoclean -y && sudo apt autoremove -y && sudo apt autopurge -y && sudo flatpak uninstall --unused -y
}

final(){
  full-att() && full-lmp() && sudo dpkg --configure -a
}

# ------------------------------------------------------------------------------------------- #
# ---------------------------------------- EXECUÇÃO ----------------------------------------- #

testes_internet
full-att
travas_apt
full-att
install_alls
install_outros
full-lmp
final

## Finalização ##

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
