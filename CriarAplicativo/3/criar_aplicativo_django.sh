#!/bin/bash

echo "Criar Projeto em Django (Python)"

# Criar diretório do projeto
mkdir MeuProjeto_Django
cd MeuProjeto_Django

# Criar e ativar um ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar Django
pip install django

# Iniciar um novo projeto Django
django-admin startproject meu_projeto .

# Criar um aplicativo dentro do projeto
python manage.py startapp meu_app

# Criar um superusuário
python manage.py createsuperuser

# Aplicar migrações
python manage.py migrate

# Iniciar o servidor de desenvolvimento
python manage.py runserver

