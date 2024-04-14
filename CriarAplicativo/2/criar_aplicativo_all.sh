#!/bin/bash

echo "Criar Projeto em:"
echo "1. Flask (Python)"
echo "2. Express.js (Node.js)"
echo "3. Ruby on Rails (Ruby)"
echo "4. Spring Boot (Java)"
read -p "Por favor, insira em qual linguagem você quer criar o projeto: " linguagem

case "$linguagem" in
    1 | Flask | Python)
        mkdir MeuProjeto_Flask
        cd MeuProjeto_Flask
        
        python3 -m venv venv
        source venv/bin/activate
        
        pip install Flask
        
        mkdir -p meuapp/templates meuapp/static
        
        cat > meuapp/__init__.py <<EOF
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Olá Mundo!'

if __name__ == '__main__':
    app.run(debug=True)
EOF

        cat > meuapp/templates/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Meu App Flask</title>
</head>
<body>
    <h1>Olá Mundo!</h1>
</body>
</html>
EOF

        FLASK_APP=meuapp FLASK_ENV=development flask run
    ;;

    2 | Express.js | Node.js)
        mkdir MeuProjeto_Express
        cd MeuProjeto_Express
        
        npm init -y
        
        npm install express
        
        cat > index.js <<EOF
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Olá Mundo!');
});

app.listen(port, () => {
  console.log(\`Servidor rodando em http://localhost:\${port}\`);
});
EOF

        node index.js
    ;;
   
    3 | Ruby on Rails | Ruby)
        gem install rails
        
        rails new MeuProjeto_Rails
        
        cd MeuProjeto_Rails
        
        bin/rails server
    ;;

    4 | Spring Boot | Java)
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

