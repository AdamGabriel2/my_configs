#!/bin/bash

# Nome do aplicativo e arquivo fonte
APP_NAME="meu_aplicativo.rb"
SOURCE_FILE="meu_aplicativo.rb"

# Criar pasta onde ficara o projeto
mkdir 'MeuProjeto_ruby'
cd MeuProjeto_ruby/

# Código fonte do aplicativo
cat > $SOURCE_FILE <<EOF
puts "Olá Mundo!"
EOF

# Verificar se o script está sintaticamente correto
ruby $APP_NAME $SOURCE_FILE

# Verificar se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Aplicativo compilado com sucesso: $APP_NAME"
else
    echo "Erro ao compilar o aplicativo."
fi

