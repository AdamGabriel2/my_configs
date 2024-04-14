#!/bin/bash

# Nome do aplicativo e arquivo fonte
APP_NAME="MeuApp"
SOURCE_FILE="MeuApp.java"

# Criar pasta onde ficara o projeto
mkdir 'MeuProjeto_j'
cd MeuProjeto_j/

# Código fonte do aplicativo
cat > $SOURCE_FILE <<EOF
public class MeuApp {
    public static void main(String[] args) {
        System.out.println("Olá Mundo!");
    }
}
EOF

# Compilar o aplicativo
javac $SOURCE_FILE

# Verificar se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Aplicativo compilado com sucesso: $APP_NAME"
else
    echo "Erro ao compilar o aplicativo."
fi

