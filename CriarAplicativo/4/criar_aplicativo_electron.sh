#!/bin/bash

echo "Criar Projeto em Electron (JavaScript) para aplicativos de desktop"

# Criar diretório do projeto
mkdir MeuAppElectron
cd MeuAppElectron

# Inicializar um novo projeto Node.js
npm init -y

# Instalar o framework Electron
npm install electron

# Criar arquivos principais do aplicativo
cat > main.js <<EOF
const { app, BrowserWindow } = require('electron')

function createWindow () {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true
    }
  })

  win.loadFile('index.html')
}

app.whenReady().then(createWindow)

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow()
  }
})
EOF

cat > index.html <<EOF
<!DOCTYPE html>
<html>
  <head>
    <title>Meu Aplicativo Electron</title>
  </head>
  <body>
    <h1>Olá Mundo!</h1>
  </body>
</html>
EOF

# Executar o aplicativo Electron
npx electron .

