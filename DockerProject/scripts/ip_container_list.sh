#!/bin/bash

# Скрипт для вывода текущих IP-адресов запущенных Docker-контейнеров

CONTAINERS=$(docker ps -q)

if [ -z "$CONTAINERS" ]; then
  echo "No running containers"
else
  echo "IP-address list of running containers"
  for CONTAINER in $CONTAINERS; do

    IP_ADDRESS=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER)

    CONTAINER_NAME=$(docker inspect -f '{{.Name}}' $CONTAINER | sed 's/\///')
    echo "$CONAINER_NAME: $IP_ADDRESS"
  done
fi

