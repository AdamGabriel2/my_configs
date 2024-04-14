#!/bin/bash

echo "Criar Projeto em React Native (JavaScript) com Redux e autenticação OAuth"

# Instalar o ambiente de desenvolvimento do React Native
npm install -g react-native-cli
brew install cocoapods # Apenas para usuários macOS

# Criar um novo projeto React Native
react-native init MeuAppReactNative

# Entrar no diretório do projeto
cd MeuAppReactNative

# Instalar dependências do Redux e Firebase
npm install redux react-redux redux-thunk
npm install @react-native-firebase/app @react-native-firebase/auth

# Configurar o Firebase Authentication no aplicativo
# (Consulte a documentação do Firebase para obter instruções específicas)

# Configurar Redux no aplicativo
# (Crie os diretórios e arquivos necessários e configure as ações, redutores e a loja Redux)

# Iniciar o aplicativo React Native
react-native run-android # ou react-native run-ios

