#!/bin/bash

echo "Criar Projeto em Laravel (PHP)"

# Instalar o Laravel Installer
composer global require laravel/installer

# Criar um novo projeto Laravel
laravel new MeuProjeto_Laravel

# Entrar no diretório do projeto
cd MeuProjeto_Laravel

# Iniciar o servidor de desenvolvimento
php artisan serve

