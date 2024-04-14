#!/bin/bash

# Nome do aplicativo e arquivo fonte
APP_NAME="meu_aplicativo"
SOURCE_FILE="meu_aplicativo.c"

# Criar pasta onde ficara o projeto
mkdir 'MeuProjeto_c'
cd MeuProjeto_c/

# Código fonte do aplicativo
cat > $SOURCE_FILE <<EOF
#include <stdio.h>

int main() {
    printf("Olá Mundo!\n");
    return 0;
}
EOF

# Compilar o aplicativo
gcc -o $APP_NAME $SOURCE_FILE

# Verificar se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Aplicativo compilado com sucesso: $APP_NAME"
else
    echo "Erro ao compilar o aplicativo."
fi

