#!/bin/bash

echo "Criar Projeto em:"
echo "1. Spring Boot (Java)"
read -p "Por favor, insira em qual linguagem você quer criar o projeto: " linguagem

case "$linguagem" in
    1 | Spring Boot | Java)
        mkdir MeuProjeto_SpringBoot
        cd MeuProjeto_SpringBoot
        
        curl https://start.spring.io/starter.zip -d dependencies=web -d baseDir=. -o projeto.zip
        unzip projeto.zip
        rm projeto.zip
        
        ./mvnw spring-boot:run
    ;;

    *?)
        echo "A linguagem '$linguagem' não é suportada para a criação de Projetos."
    
esac

