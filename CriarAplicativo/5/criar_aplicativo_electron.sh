#!/bin/bash

echo "Criar Projeto em Electron (JavaScript) com Vue.js para aplicativos de desktop"

# Criar diretório do projeto
mkdir MeuAppElectronVue
cd MeuAppElectronVue

# Inicializar um novo projeto Node.js
npm init -y

# Instalar o framework Electron
npm install electron --save-dev

# Instalar o Vue CLI
npm install -g @vue/cli

# Criar um novo projeto Vue.js dentro do diretório do Electron
vue create meu-app-vue

# Entrar no diretório do projeto Vue.js
cd meu-app-vue

# Adicionar suporte ao Electron ao projeto Vue.js
vue add electron-builder

# Iniciar o aplicativo Vue.js com Electron
npm run electron:serve

