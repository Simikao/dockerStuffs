#!/bin/bash

rm -rf app
mkdir app

echo '{
  "name": "app",
  "version": "1.0.0",
  "description": "Express app returning date and time",
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

. ./scriptTest.sh
