#!/bin/bash

echo "Criar Projeto em Express.js (Node.js) com MongoDB e autenticação"

# Criar diretório do projeto
mkdir MeuProjeto_Express
cd MeuProjeto_Express

# Inicializar um projeto Node.js
npm init -y

# Instalar o framework Express.js e o driver do MongoDB
npm install express mongoose passport passport-local bcryptjs express-session

# Criar diretório para modelos de dados
mkdir models

# Criar arquivo de modelo de usuário
cat > models/User.js <<EOF
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new Schema({
  username: { type: String, required: true },
  password: { type: String, required: true }
});

module.exports = mongoose.model('User', UserSchema);
EOF

# Criar arquivo de configuração do banco de dados
cat > config/database.js <<EOF
module.exports = {
  dbURI: 'mongodb://localhost/meu_db'
}
EOF

# Criar arquivo de configuração de autenticação
cat > config/passport.js <<EOF
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const User = require('../models/User');

passport.use(new LocalStrategy(
  function(username, password, done) {
    User.findOne({ username: username }, function(err, user) {
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Nome de usuário incorreto.' });
      }
      if (!user.validPassword(password)) {
        return done(null, false, { message: 'Senha incorreta.' });
      }
      return done(null, user);
    });
  }
));

passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done) {
  User.findById(id, function(err, user) {
    done(err, user);
  });
});
EOF

# Iniciar o servidor de desenvolvimento
node index.js

