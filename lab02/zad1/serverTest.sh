#!/bin/bash

echo "Test: Uruchamianie kontenera..."
docker ps -a | grep node-server

echo "Test: Dostępność serwera HTTP..."
curl -s http://localhost:8080

response=$(curl -s http://localhost:8080)
if [ "$response" == "Hello World" ]; then
  echo "Test passed: Server returned 'Hello World'"
else
  echo "Test failed: Server did not return 'Hello World'"
fi

echo "Usuwanie servera"

container_id=$(docker ps -q --filter ancestor=node-server)
docker stop $container_id
docker rm $container_id

rm server.js
rm Dockerfile
