#!/bin/bash

rm server.js
rm Dockerfile

echo "const http = require('http');

const hostname = '0.0.0.0';
const port = 8080;

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
});

server.listen(port, hostname, () => {
  console.log('Server running at http://${hostname}:${port}/');
});" > server.js

echo "FROM node:12
WORKDIR /app
COPY server.js /app
CMD [\"node\", \"server.js\"]" > Dockerfile

docker build -t node-server .

docker run --rm -p 8080:8080 -d node-server

. ./serverTest.sh
