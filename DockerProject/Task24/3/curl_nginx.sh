#!/bin/bash


docker-compose up -d

docker-compose exec postgres apt-get update

docker-compose exec postgres apt-get install -y curl

docker-compose exec postgres curl web

