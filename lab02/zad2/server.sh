#!/bin/bash

rm -rf app
mkdir app

echo '{
  "name": "app",
  "version": "1.0.0",
  "description": "Aplikacja Express.js zwracająca datę i godzinę",
  "main": "index.js",
  "dependencies": {
    "express": "^4.17.1"
  }
}
' > app/package.json

echo 'const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.json({
    date: new Date().toUTCString(),
  });
});

const port = 8080;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
' > app/index.js

echo "FROM node:14
WORKDIR /usr/src/app
COPY app/package*.json ./
RUN npm install
COPY ./app .
EXPOSE 8080

CMD [ \"node\", \"index.js\" ]" > Dockerfile

docker build -t node-server .

docker run --rm -d -p 8080:8080 --name node-express-container node-server


RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Test: Container exists..."${NC}
docker ps -a | grep node-express-container
echo
sleep 2
echo -e ${GREEN}$(curl -s http://localhost:8080)
echo
echo -e ${YELLOW}"Test: Check node version..."
echo -e ${GREEN}$(docker exec node-express-container node --version)${NC}

docker stop node-express-container

