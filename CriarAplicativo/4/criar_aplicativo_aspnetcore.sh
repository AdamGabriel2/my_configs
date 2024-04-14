#!/bin/bash

echo "Criar Projeto em ASP.NET Core (C#) com Entity Framework Core e autenticação"

# Instalar o SDK do .NET Core
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS --verbose
export PATH="$PATH:$HOME/.dotnet"

# Criar um novo projeto ASP.NET Core
dotnet new mvc -n MeuProjeto_AspNetCore

# Entrar no diretório do projeto
cd MeuProjeto_AspNetCore

# Instalar pacotes do Entity Framework Core e de autenticação
dotnet add package Microsoft.EntityFrameworkCore.Sqlite
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package Microsoft.AspNetCore.Identity.EntityFrameworkCore

# Criar modelo de usuário
echo "using Microsoft.AspNetCore.Identity;

namespace MeuProjeto_AspNetCore.Models
{
    public class ApplicationUser : IdentityUser
    {
    }
}" > Models/ApplicationUser.cs

# Configurar banco de dados SQLite no arquivo appsettings.json
sed -i 's/"DefaultConnection": "DataSource=app.db"/"DefaultConnection": "DataSource=app.db", "Provider": "Microsoft.EntityFrameworkCore.Sqlite"/' appsettings.json

# Atualizar Startup.cs para configurar autenticação
sed -i '/services.AddControllersWithViews();/a \
services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlite(
        Configuration.GetConnectionString("DefaultConnection")));
services.AddIdentity<ApplicationUser, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();
services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequiredLength = 6;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequireLowercase = false;
});
services.AddControllersWithViews();' Startup.cs

# Adicionar migrações e aplicar migrações ao banco de dados
dotnet ef migrations add InitialCreate
dotnet ef database update

# Iniciar o servidor de desenvolvimento
dotnet run

