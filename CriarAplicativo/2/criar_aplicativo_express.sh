#!/bin/bash

echo "Criar Projeto em:"
echo "1. Express.js (Node.js)"
read -p "Por favor, insira em qual linguagem você quer criar o projeto: " linguagem

case "$linguagem" in
    1 | Express.js | Node.js)
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
 
    *?)
        echo "A linguagem '$linguagem' não é suportada para a criação de Projetos."
    
esac

