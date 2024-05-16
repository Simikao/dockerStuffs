#!/bin/bash

docker stop mongodb
docker stop mongoApp

docker network rm myNetwork

rm ./Dockerfile
rm ./app.js
rm ./package.json


