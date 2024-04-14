#!/bin/bash

echo "Criar Projeto em Ruby on Rails (Ruby) com SQLite e autenticação"

# Instalar o framework Ruby on Rails
gem install rails

# Criar um novo projeto Rails
rails new MeuProjeto_Rails -d sqlite3

# Entrar no diretório do projeto
cd MeuProjeto_Rails

# Instalar dependências do Rails
bundle install

# Criar modelo de usuário
rails generate model User username:string password_digest:string
rails db:migrate

# Criar autenticação de usuário
rails generate controller Sessions new create destroy
rails generate controller Users new create
rails generate controller Welcome index

# Configurar roteamento para autenticação
echo "Rails.application.routes.draw do
  root 'welcome#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end" > config/routes.rb

# Iniciar o servidor de desenvolvimento
rails server

