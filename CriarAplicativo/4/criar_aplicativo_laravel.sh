#!/bin/bash

echo "Criar Projeto em Laravel (PHP) com MySQL e autenticação"

# Instalar o Laravel Installer
composer global require laravel/installer

# Criar um novo projeto Laravel
laravel new MeuProjeto_Laravel

# Entrar no diretório do projeto
cd MeuProjeto_Laravel

# Instalar dependências do Composer
composer install

# Configurar banco de dados MySQL no arquivo .env
sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=mysql\nDB_HOST=127.0.0.1\nDB_PORT=3306\nDB_DATABASE=meu_db\nDB_USERNAME=meu_usuario\nDB_PASSWORD=minha_senha/' .env

# Aplicar migrações
php artisan migrate

# Iniciar o servidor de desenvolvimento
php artisan serve

