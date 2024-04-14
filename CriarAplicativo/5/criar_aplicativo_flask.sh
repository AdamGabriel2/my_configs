#!/bin/bash

echo "Criar Projeto em Flask (Python) com SQLAlchemy e autenticação JWT"

# Criar diretório do projeto
mkdir MeuProjeto_Flask
cd MeuProjeto_Flask

# Criar e ativar um ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar Flask, Flask SQLAlchemy e dependências
pip install Flask Flask-SQLAlchemy Flask-JWT

# Criar um arquivo de aplicação principal
cat > app.py <<EOF
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt import JWT

app = Flask(__name__)
app.config['SECRET_KEY'] = 'chave_secreta'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
db = SQLAlchemy(app)

# Models
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(80), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'

# JWT
def authenticate(username, password):
    user = User.query.filter_by(username=username).first()
    if user and user.password == password:
        return user

def identity(payload):
    user_id = payload['identity']
    return User.query.get(user_id)

jwt = JWT(app, authenticate, identity)

if __name__ == '__main__':
    app.run(debug=True)
EOF

# Criar banco de dados
python -c "from app import db; db.create_all()"

# Iniciar o servidor de desenvolvimento
python app.py

