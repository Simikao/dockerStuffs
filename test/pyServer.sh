#!/bin/bash

docker build -t python_web .
# docker network create myNetwork
docker run --rm -d -p 8080:80 --network myNetwork --name pWeb python_web
