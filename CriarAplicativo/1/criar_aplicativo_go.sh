#!/bin/bash

APP_NAME="meu_aplicativo.go"
SOURCE_FILE="meu_aplicativo.go"

mkdir 'MeuProjeto_go'
cd MeuProjeto_go/

cat > $SOURCE_FILE <<EOF
package main

import "fmt"

func main() {
fmt.Println("Olá Mundo!")
}
EOF

go run $APP_NAME

if [ $? -eq 0 ]; then
echo "Aplicativo compilado com sucesso: $APP_NAME"
else
echo "Erro ao compilar o aplicativo."
fi
