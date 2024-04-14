#!/bin/bash

echo "Criar Projeto em Django (Python) com REST API, PostgreSQL e autenticação JWT"

# Criar diretório do projeto
mkdir MeuProjeto_Django_REST
cd MeuProjeto_Django_REST

# Criar e ativar um ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar Django, Django REST Framework e dependências
pip install django djangorestframework django-rest-framework-jwt psycopg2

# Iniciar um novo projeto Django
django-admin startproject meu_projeto .

# Criar um aplicativo dentro do projeto
python manage.py startapp meu_app

# Configurar banco de dados PostgreSQL no settings.py do Django
sed -i '/DATABASES = {/a \
    \x27default\x27: {\
        \x27ENGINE\x27: \x27django.db.backends.postgresql\x27,\
        \x27NAME\x27: \x27meu_db\x27,\
        \x27USER\x27: \x27meu_usuario\x27,\
        \x27PASSWORD\x27: \x27minha_senha\x27,\
        \x27HOST\x27: \x27localhost\x27,\
        \x27PORT\x27: \x275432\x27,\
    \x27},\x27' meu_projeto/settings.py

# Criar modelos e migrações
python manage.py makemigrations
python manage.py migrate

# Criar arquivos de serialização e views para a REST API
cat > meu_app/serializers.py <<EOF
from rest_framework import serializers
from .models import *

class MeuModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = MeuModel
        fields = '__all__'
EOF

cat > meu_app/views.py <<EOF
from rest_framework import viewsets
from .models import *
from .serializers import *

class MeuModelViewSet(viewsets.ModelViewSet):
    queryset = MeuModel.objects.all()
    serializer_class = MeuModelSerializer
EOF

# Configurar URLs para a REST API
sed -i '/urlpatterns = \[/a \
from django.urls import path, include\
from rest_framework import routers\
from meu_app.views import MeuModelViewSet\
\
router = routers.DefaultRouter()\
router.register(r\x27meu-model\x27, MeuModelViewSet)\
\
urlpatterns += [\
    path(\x27api/\x27, include(router.urls)),\
]' meu_projeto/urls.py

# Configurar autenticação JWT no settings.py do Django
sed -i '/INSTALLED_APPS = \[/a \
    \x27rest_framework.authtoken\x27,\
    \x27rest_framework_jwt\x27,\
' meu_projeto/settings.py

sed -i '/REST_FRAMEWORK = {/a \
    \x27DEFAULT_AUTHENTICATION_CLASSES\x27: [\
        \x27rest_framework.authentication.SessionAuthentication\x27,\
        \x27rest_framework.authentication.TokenAuthentication\x27,\
        \x27rest_framework_jwt.authentication.JSONWebTokenAuthentication\x27,\
    ],\
' meu_projeto/settings.py

# Criar token de autenticação JWT
cat > meu_app/views.py <<EOF
from rest_framework_jwt.views import obtain_jwt_token, refresh_jwt_token

urlpatterns += [
    path('api-token-auth/', obtain_jwt_token),
    path('api-token-refresh/', refresh_jwt_token),
]
EOF

# Iniciar o servidor de desenvolvimento
python manage.py runserver

