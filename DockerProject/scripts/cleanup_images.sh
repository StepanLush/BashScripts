#!/bin/bash

# Скрипт для принудительного удаления Docker-образов, контейнеры которых не запущены


IMAGES=$(docker images -q)

if [ -z "$IMAGES" ]; then
  echo "No images found"
else
  for IMAGE_ID in $IMAGES; do

    CONTAINERS=$(docker ps -q --filter ancestor=$IMAGE_ID)

    if [ -z "$CONTAINERS" ]; then
      echo "Deletind $IMAGE_ID..."
      docker rmi -f $IMAGE_ID
    fi
  done
  echo "Complited"
fi
