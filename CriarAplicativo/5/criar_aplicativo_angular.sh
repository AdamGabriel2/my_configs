#!/bin/bash

echo "Criar Projeto em Angular (TypeScript) com Firebase para aplicativos web"

# Instalar o Angular CLI
npm install -g @angular/cli

# Criar um novo projeto Angular
ng new MeuAppAngular

# Entrar no diretório do projeto
cd MeuAppAngular

# Instalar o Firebase CLI
npm install -g firebase-tools

# Inicializar o Firebase no projeto
firebase init

# Configurar o Firebase no projeto (adicionar autenticação, banco de dados, etc.)
# (Consulte a documentação do Firebase para obter instruções específicas)

# Iniciar o servidor de desenvolvimento
ng serve

