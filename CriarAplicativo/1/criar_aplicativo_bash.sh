#!/bin/bash

APP_NAME="meu_script.sh"
SOURCE_FILE="meu_script.sh"

mkdir 'MeuProjeto_bash'
cd MeuProjeto_bash/

cat > $SOURCE_FILE <<EOF
#!/bin/bash

echo "Olá Mundo!"
EOF

chmod +x $SOURCE_FILE
./$SOURCE_FILE

if [ $? -eq 0 ]; then
echo "Script executado com sucesso: $APP_NAME"
else
echo "Erro ao executar o script."
fi
