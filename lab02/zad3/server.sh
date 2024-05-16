#!/bin/bash

docker network create myNetwork

docker run -d --rm --name mongodb --network myNetwork mongo

cat << EndOfPjson > package.json
{
  "name": "my-express-app",
  "version": "1.0.0",
  "description": "Contenerization exercise with mongoDB",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.17.1",
    "mongoose": "^5.13.2"
  }
}
EndOfPjson

cat << EndOfDockerfile > Dockerfile
From node:16
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 8080
CMD ["node", "app.js"]
EndOfDockerfile

cat << EndOfJS > app.js
const express = require('express');
const mongoose = require('mongoose');

const app = express();

mongoose.connect('mongodb://mongodb:27017/mydatabase', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('Could not connect to MongoDB', err));

const schema = new mongoose.Schema({
	name: String
});

const Model = mongoose.model('Model', schema);

Model.create({ name: 'John' });

app.get('/', async (req, res) => {
  const data = await Model.find();
  res.send(data);
});

const port = 8080;
app.listen(port, () => console.log('Listening on port' + port + '...'));
EndOfJS

docker build -t mynodeapp .
docker run -d --rm --name mongoApp --network myNetwork -p 8080:8080 mynodeapp



sleep 5
echo $(curl -s http://localhost:8080/)
