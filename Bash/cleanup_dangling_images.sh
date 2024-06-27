#!/bin/bash

# Скрипт для удаления Docker-образов с тегом "<none>"

DANGLING_IMAGES=$(docker images -f "dangling=true" -q)

if [ -z "$DANGLING_IMAGES" ]; then
  echo "No images found"
else
  echo "Deleting..."
  docker rmi $DANGLING_IMAGES
  echo "Complited"
fi
