#!/bin/bash

# Nome do aplicativo e arquivo fonte
APP_NAME="meu_aplicativo.py"
SOURCE_FILE="meu_aplicativo.py"

# Criar pasta onde ficara o projeto
mkdir 'MeuProjeto_p'
cd MeuProjeto_p/

# Código fonte do aplicativo
cat > $SOURCE_FILE <<EOF
print("Olá Mundo!")
EOF

# Verificar se o script está sintaticamente correto
python3 -m py_compile $SOURCE_FILE

# Verificar se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Aplicativo compilado com sucesso: $APP_NAME"
else
    echo "Erro ao compilar o aplicativo."
fi

