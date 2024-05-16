#!/bin/bash

R='\033[0;31m' # RED
Y='\033[0;33m' # YELLOW
G='\033[0;32m' # GREEN
NC='\033[0m' # No Color


echo -e "${Y}Test: Check if container exists..."${NC}
docker ps -a | grep node-server

echo -e "${Y}Test: Check if server is on..."${NC}
curl -s http://localhost:8080

response=$(curl -s http://localhost:8080)
if [ "$response" == "Hello World" ]; then
  echo -e "${G}Test passed: Server returned 'Hello World'"
else
  echo -e "${R}Test failed: Server did not return 'Hello World'"
fi

echo -e "${Y}Stopping and removing server, may take a few seconds"${NC}

container_id=$(docker ps -q --filter ancestor=node-server)
docker stop $container_id

