#!/bin/bash

sudo apt autoclean -y && sudo apt autopurge -y && sudo apt autoremove -y
sudo flatpak uninstall --unused -y

