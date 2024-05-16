#!/bin/bash

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

echo -e "${YELLOW}Stopping and removing server, may take a few seconds"${NC}
docker stop node-express-container
