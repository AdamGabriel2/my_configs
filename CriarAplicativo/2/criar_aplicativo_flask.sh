#!/bin/bash

echo "Criar Projeto em:"
echo "1. Flask (Python)"
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
 
    *?)
        echo "A linguagem '$linguagem' não é suportada para a criação de Projetos."
    
esac

