#!/bin/bash

docker build -t python_web .
docker run --rm -d -p 5000:5000 python_web
