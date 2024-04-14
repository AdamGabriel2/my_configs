#!/bin/bash

echo "Criar Projeto em Flutter (Dart) para aplicativos móveis"

# Instalar o SDK do Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Inicializar um novo projeto Flutter
flutter create MeuAppFlutter

# Entrar no diretório do projeto
cd MeuAppFlutter

# Executar o aplicativo em um emulador Android ou dispositivo conectado
flutter run

