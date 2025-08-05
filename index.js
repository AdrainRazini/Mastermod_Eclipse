// server.js
const express = require('express');
const http = require('http');
const app = express();
const server = http.createServer(app);

// Configura a pasta pública para servir os arquivos HTML, CSS e JS
app.use(express.static('public'));

// Rota principal
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

// Inicia o servidor
server.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});
/* FEITO POR ADRIAN RAZINI */