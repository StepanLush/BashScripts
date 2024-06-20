#!/bin/bash

docker-compose up -d

NGINX_CONTAINER_ID=$(docker-compose ps -q nginx)
POSTGRES_CONTAINER_ID=$(docker-compose ps -q postgres)


NGINX_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $NGINX_CONTAINER_ID)



docker exec -it $POSTGRES_CONTAINER_ID bash -c "apt-get update && apt-get install -y curl && curl http://NGINX_IP"

docker-compose down
