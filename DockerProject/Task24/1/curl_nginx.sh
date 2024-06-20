#!/bin/bash

docker-compose up -d

POSTGRES_CONTAINER_ID=$(docker-compose ps -q postgres)

docker exec -it $POSTGRES_CONTAINER_ID bash -c "apt-get update && apt-get install -y curl && curl http://nginx"

docker-compose down
