#!/bin/bash

T_VERDE='\e[0;32m'
C_NORMAL='\e[0m'

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

# Atualização para Snap (se instalado)
if command -v snap &> /dev/null; then
    sudo snap refresh
fi

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

# Limpeza para Snap (se instalado)
if command -v snap &> /dev/null; then
    sudo snap refresh --list | awk '/disabled/{print $1, $2}' | xargs sudo snap remove
fi

echo -e "${T_VERDE}[INFO] - Atualização e Limpeza Concluidas! :)${C_NORMAL}"

