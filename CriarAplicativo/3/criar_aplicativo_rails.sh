#!/bin/bash

echo "Criar Projeto em Ruby on Rails (Ruby)"

# Instalar o framework Ruby on Rails
gem install rails

# Criar um novo projeto Rails
rails new MeuProjeto_Rails

# Entrar no diretório do projeto
cd MeuProjeto_Rails

# Iniciar o servidor de desenvolvimento
rails server

