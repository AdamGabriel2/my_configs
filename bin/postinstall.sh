#!/bin/bash
#
# postinstall.sh - Instalar e configura programas em (quase) qualquer sistema.
#
# ------------------------------------------------------------------------------------------- #
#
# COMO USAR?
#   $ ./postinstall.sh
#
# ------------------------------------------------------------------------------------------- #

# ---------------------------------------- VARIÁVEIS ---------------------------------------- #

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
echo -e "${T_VERDE}[INFO] - Iniciando Atualização! ${C_NORMAL}"

# Verifica qual gerenciador de pacotes está instalado
if command -v apt &> /dev/null; then
    # Atualização para sistemas Debian/Ubuntu
    echo -e "${T_VERDE}[INFO] - Seu Sistema é Baseado no Debian/Ubuntu, Executando APT! ${C_NORMAL}"
    sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y
elif command -v pacman &> /dev/null; then
    # Atualização para sistemas Arch Linux
    echo -e "${T_VERDE}[INFO] - Seu Sistema é Baseado no Arch, Executando PACMAN! ${C_NORMAL}"
    sudo pacman -Syu --noconfirm
elif command -v dnf &> /dev/null; then
    # Atualização para sistemas Fedora/RHEL
    echo -e "${T_VERDE}[INFO] - Seu Sistema é Baseado no Fedora/RHEL, Executando DNF! ${C_NORMAL}"
    sudo dnf upgrade -y
else
    echo "Gerenciador de pacotes não suportado!"
    exit 1
fi

# Atualização para Flatpak (se instalado)
if command -v flatpak &> /dev/null; then
    sudo flatpak update -y
fi
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


## Removendo travas eventuais ##
remover_travas() {
if command -v apt &> /dev/null; then
    # Para APT/DPKG
    sudo rm -f /var/lib/dpkg/lock-frontend
    sudo rm -f /var/cache/apt/archives/lock
elif command -v pacman &> /dev/null; then
    # Para Pacman
    sudo rm -f /var/lib/pacman/db.lck
elif command -v dnf &> /dev/null; then
    # Para DNF
    sudo rm -f /var/run/dnf.pid
    sudo rm -f /var/cache/dnf/metadata_lock
else
    echo -e "${VERDE}Gerenciador de pacotes não suportado!${SEM_COR}"
    exit 1
fi
}

## Programas e Linguagens para instalar ##

PROGRAMAS_PARA_INSTALAR=(
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
  php
  python3-all
  python3-pip
  mono-complete
  cargo
  gcc
  g++
  build-essential
  dotnet8
  clang
  ruby-full
  golang
  rbenv
  lua5.4
)

LINGUAGENS_PARA_INSTALAR_PACMAN=(
  bash
  php
  python-all
  python-pip
  mono-complete
  cargo
  gcc
  g++
  build-essential
  dotnet
  clang
  ruby-full
  golang
  rbenv
  lua
)

# ------------------------------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_alls() {
  echo -e "${VERDE}[INFO] - Iniciando a instalação de pacotes! ${SEM_COR}"

  # Verifica qual gerenciador de pacotes está instalado
  if command -v apt &> /dev/null; then
    # Instalação para sistemas Debian/Ubuntu
    echo -e "${VERDE}[INFO] - Seu Sistema é Baseado no Debian/Ubuntu, Executando APT! ${SEM_COR}"
    install_with_apt
  elif command -v pacman &> /dev/null; then
    # Instalação para sistemas Arch Linux
    echo -e "${VERDE}[INFO] - Seu Sistema é Baseado no Arch, Executando PACMAN! ${SEM_COR}"
    install_with_pacman
  elif command -v dnf &> /dev/null; then
    # Instalação para sistemas Fedora/RHEL
    echo -e "${VERDE}[INFO] - Seu Sistema é Baseado no Fedora/RHEL, Executando DNF! ${SEM_COR}"
    install_with_dnf
  else
    echo "Gerenciador de pacotes não suportado!"
    return 1
  fi
}

install_with_apt() {
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

install_with_pacman() {
  echo -e "${VERDE}[INFO] - Instalando pacotes pacman do repositório${SEM_COR}"
  for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
    if ! pacman -Qi "$nome_do_programa" &> /dev/null; then # Só instala se já não estiver instalado
      sudo pacman -S "$nome_do_programa" --noconfirm
    else
      echo "[INSTALADO] - $nome_do_programa"
    fi
  done

  for nome_do_programa in ${LINGUAGENS_PARA_INSTALAR_PACMAN[@]}; do
    if ! pacman -Qi "$nome_do_programa" &> /dev/null; then # Só instala se já não estiver instalado
      sudo pacman -S "$nome_do_programa" --noconfirm
    else
      echo "[INSTALADO] - $nome_do_programa"
    fi
  done
}

install_with_dnf() {
  echo -e "${VERDE}[INFO] - Instalando pacotes dnf do repositório${SEM_COR}"
  for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
    if ! dnf list installed "$nome_do_programa" &> /dev/null; then # Só instala se já não estiver instalado
      sudo dnf install "$nome_do_programa" -y
    else
      echo "[INSTALADO] - $nome_do_programa"
    fi
  done

  for nome_do_programa in ${LINGUAGENS_PARA_INSTALAR[@]}; do
    if ! dnf list installed "$nome_do_programa" &> /dev/null; then # Só instala se já não estiver instalado
      sudo dnf install "$nome_do_programa" -y
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
flatpak install flathub md.obsidian.Obsidian -y
flatpak install com.visualstudio.code -y
flatpak install com.discordapp.Discord -y
}

# ------------------------------------------------------------------------------------------- #
# -------------------------------------- PÓS-INSTALAÇÃO ------------------------------------- #


## Finalização, atualização e limpeza ##

full-lmp(){
echo -e "${T_VERDE}[INFO] - Iniciando Limpeza! ${C_NORMAL}"

# Limpeza para sistemas Debian/Ubuntu
if command -v apt &> /dev/null; then
    sudo apt autoclean -y && sudo apt autopurge -y && sudo apt autoremove -y
# Limpeza para sistemas Arch Linux
elif command -v pacman &> /dev/null; then
    sudo pacman -Sc --noconfirm
# Limpeza para sistemas Fedora/RHEL
elif command -v dnf &> /dev/null; then
    sudo dnf clean all -y
fi

# Limpeza para Flatpak (se instalado)
if command -v flatpak &> /dev/null; then
    sudo flatpak uninstall --unused -y
fi
}

final(){
  full-att() && full-lmp()
}

# ------------------------------------------------------------------------------------------- #
# -------------------------------------- CONFIGS EXTRAS ------------------------------------- #

## Cria pastas especificas para meus arquivos ##
extra_config(){

all_files="$HOME/ADAM"

mkdir $all_files
cd $all_files
mkdir 'Projetos' 'Estudos' 'Escola' 'Outros' 'Backup' 'tmp' 'Saves'
cd $HOME
mkdir $HOME/tmp
mkdir $HOME/bin

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/files.txt
fi

echo "file:///$HOME/ADAM/'Projetos' 'Estudos' 'Escola' 'Outros' 'Backup' 'tmp' 'Saves'" >> $FILE
echo "file:///$HOME/tmp" >> $FILE
echo "file:///$HOME/bin" >> $FILE

# ------------------------------------------------------------------------------------------- #
# ---------------------------------------- EXECUÇÃO ----------------------------------------- #

testes_internet
full-att
remover_travas
full-att
install_alls
install_flatpaks
extra_config
full-lmp
final

## Finalização ##

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
