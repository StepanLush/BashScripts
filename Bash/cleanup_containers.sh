#!/bin/bash

# Скрипт для принудительной остановки и удаления всех запущенных Docker-контейнеров


CONTAINERS=$(docker ps -q)

if [ -z "$CONTAINERS" ]; then
  echo "No running containers"
else
  echo "Stopping containers..."
  docker stop $CONTAINERS

  echo "Deleting containers..."
  docker rm $CONTAINERS

  echo "Complited"
fi
