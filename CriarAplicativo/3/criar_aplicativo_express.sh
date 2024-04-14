#!/bin/bash

echo "Criar Projeto em Express.js (Node.js)"

# Criar diretório do projeto
mkdir MeuProjeto_Express
cd MeuProjeto_Express

# Inicializar um projeto Node.js
npm init -y

# Instalar o framework Express.js
npm install express

# Criar arquivo de aplicação principal
cat > app.js <<EOF
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

# Iniciar o servidor de desenvolvimento
node app.js

