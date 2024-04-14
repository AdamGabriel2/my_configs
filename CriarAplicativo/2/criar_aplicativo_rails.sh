#!/bin/bash

echo "Criar Projeto em:"
echo "1. Ruby on Rails (Ruby)"
read -p "Por favor, insira em qual linguagem você quer criar o projeto: " linguagem

case "$linguagem" in
    1 | Ruby on Rails | Ruby)
        gem install rails
        
        rails new MeuProjeto_Rails
        
        cd MeuProjeto_Rails
        
        bin/rails server
    ;;

    *?)
        echo "A linguagem '$linguagem' não é suportada para a criação de Projetos."
    
esac

