#!/bin/bash

echo "Criar Projeto em Django (Python) com PostgreSQL e autenticação"

# Criar diretório do projeto
mkdir MeuProjeto_Django
cd MeuProjeto_Django

# Criar e ativar um ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar Django e psycopg2 (driver PostgreSQL)
pip install django psycopg2

# Iniciar um novo projeto Django
django-admin startproject meu_projeto .

# Criar um aplicativo dentro do projeto
python manage.py startapp meu_app

# Configurar banco de dados PostgreSQL no settings.py do Django
cat >> meu_projeto/settings.py <<EOF

# Configurações do banco de dados PostgreSQL
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'meu_db',
        'USER': 'meu_usuario',
        'PASSWORD': 'minha_senha',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
EOF

# Aplicar migrações
python manage.py makemigrations
python manage.py migrate

# Criar um superusuário
python manage.py createsuperuser

# Iniciar o servidor de desenvolvimento
python manage.py runserver

