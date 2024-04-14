#!/bin/bash
#
# lm-postinstall.sh - Instalar e configura programas no Linux Mint (22.0 ou superior)
#
# ------------------------------------------------------------------------------------------- #
#
# COMO USAR?
#   $ ./ls-postinstall.sh
#
# ------------------------------------------------------------------------------------------- #

# ---------------------------------------- VARIÁVEIS ---------------------------------------- #
set -e

## URLS ##

URL_VIVALDI="https://downloads.vivaldi.com/stable/vivaldi-stable_6.6.3271.57-1_amd64.deb"

## DIRETÓRIOS E ARQUIVOS ##

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
FILE="$HOME/files.txt"

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

PROGRAMAS_PARA_INSTALAR=(
  cargo
  virtualbox
  gparted
  gufw
  synaptic
  git
  wget
  software-properties-common
  curl
  vim
  sublime-text
  xed
  gedit
)

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
)

# ------------------------------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_alls(){

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

if [ -f $DIRETORIO_DOWNLOADS ]; then
  mkdir "$DIRETORIO_DOWNLOADS"
fi

wget -c "$URL_VIVALDI"             -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

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

## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.telegram.desktop -y
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
# -------------------------------------- CONFIGS EXTRAS ------------------------------------- #

## Cria pastas especificas para meus arquivos ##
extra_config(){

all_files="/home/$USER/$USER"

mkdir /home/$USER/$USER
cd $all_files
mkdir 'Projetos' 'Estudos' 'Escola' 'Outros' 'Backup' 'TEMP' 'Saves' 'Etc'
cd $HOME
mkdir /home/$USER/TEMP
mkdir /home/$USER/bin

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/files.txt
fi

echo "file:///home/$USER/$USER/'Projetos' 'Estudos' 'Escola' 'Outros' 'Backup' 'TEMP' 'Saves' 'Etc'" >> $FILE
echo "file:///home/$USER/TEMP" >> $FILE
echo "file:///home/$USER/bin" >> $FILE
}

# ------------------------------------------------------------------------------------------- #
# ---------------------------------------- EXECUÇÃO ----------------------------------------- #

testes_internet
full-att
travas_apt
full-att
install_alls
install_flatpaks
extra_config
full-lmp
final

## Finalização ##

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
