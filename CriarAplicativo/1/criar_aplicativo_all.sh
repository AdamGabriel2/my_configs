#!/bin/bash

echo "Criar Projeto em:"
echo "1. C"
echo "2. Java"
echo "3. Python"
echo "4. Ruby"
echo "5. Go"
echo "6. JavaScript (Node.js)"
echo "7. Bash"
read -p "Por favor, insira em qual linguagem você quer criar o projeto: " linguagem

case "$linguagem" in
    1 | C)
        APP_NAME="meu_aplicativo"
        SOURCE_FILE="meu_aplicativo.c"
            
        mkdir 'MeuProjeto_c'
        cd MeuProjeto_c/
            
        cat > $SOURCE_FILE <<EOF
#include <stdio.h>

int main() {
    printf("Olá Mundo!\n");
    return 0;
}
EOF
    
        gcc -o $APP_NAME $SOURCE_FILE && ./$APP_NAME
            
        if [ $? -eq 0 ]; then
            echo "Aplicativo compilado com sucesso: $APP_NAME"
        else
        echo "Erro ao compilar o aplicativo."
        fi
    ;;
    
    2 | Java)
        APP_NAME="MeuApp"
        SOURCE_FILE="MeuApp.java"
        
        mkdir 'MeuProjeto_java'
        cd MeuProjeto_java/
        
        cat > $SOURCE_FILE <<EOF
public class MeuApp {
    public static void main(String[] args) {
        System.out.println("Olá Mundo!");
    }
}
EOF

        javac $SOURCE_FILE && java $APP_NAME
    
        if [ $? -eq 0 ]; then
            echo "Aplicativo compilado com sucesso: $APP_NAME"
        else
        echo "Erro ao compilar o aplicativo."
        fi
    ;;
    
    3 | Python)
        APP_NAME="meu_aplicativo.py"
        SOURCE_FILE="meu_aplicativo.py"
        
        mkdir 'MeuProjeto_python'
        cd MeuProjeto_python/
            
        cat > $SOURCE_FILE <<EOF
print("Olá Mundo!")
EOF
            
        python3 $APP_NAME
            
        if [ $? -eq 0 ]; then
            echo "Aplicativo compilado com sucesso: $APP_NAME"
        else
            echo "Erro ao compilar o aplicativo."
        fi
    ;;
    
    4 | Ruby)
        APP_NAME="meu_aplicativo.rb"
        SOURCE_FILE="meu_aplicativo.rb"
            
        mkdir 'MeuProjeto_ruby'
        cd MeuProjeto_ruby/
            
        cat > $SOURCE_FILE <<EOF
puts "Olá Mundo!"
EOF
            
        ruby $APP_NAME
            
        if [ $? -eq 0 ]; then
            echo "Aplicativo compilado com sucesso: $APP_NAME"
        else
            echo "Erro ao compilar o aplicativo."
        fi
    ;;

    5 | Go)
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
    ;;

    6 | JavaScript | Node.js)
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
    ;;
   
    7 | Bash)
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
    ;;
        
    *?)
        echo "A linguagem '$linguagem' não é suportada para a criação de Projetos."
    
esac

