#!/bin/bash

APP_NAME="meu_aplicativo.js"
SOURCE_FILE="meu_aplicativo.js"

mkdir 'MeuProjeto_nodejs'
cd MeuProjeto_nodejs/

cat > $SOURCE_FILE <<EOF
console.log("Olá Mundo!");
EOF

node $APP_NAME

if [ $? -eq 0 ]; then
echo "Aplicativo executado com sucesso: $APP_NAME"
else
echo "Erro ao executar o aplicativo."
fi
