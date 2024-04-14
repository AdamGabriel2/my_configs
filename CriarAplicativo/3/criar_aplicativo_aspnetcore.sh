#!/bin/bash

echo "Criar Projeto em ASP.NET Core (C#)"

# Criar diretório do projeto
mkdir MeuProjeto_AspNetCore
cd MeuProjeto_AspNetCore

# Inicializar um novo projeto ASP.NET Core
dotnet new web

# Iniciar o servidor de desenvolvimento
dotnet run

