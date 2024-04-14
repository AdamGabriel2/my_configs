#!/bin/bash

echo "Criar Projeto em Flask (Python)"

# Criar diretório do projeto
mkdir MeuProjeto_Flask
cd MeuProjeto_Flask

# Criar e ativar um ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar Flask
pip install flask

# Criar arquivo de aplicação principal
cat > app.py <<EOF
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Olá Mundo!'

if __name__ == '__main__':
    app.run(debug=True)
EOF

# Iniciar o servidor de desenvolvimento
python app.py

