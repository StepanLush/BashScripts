#!/bin/bash

SERVICE_URL=$(minikube service nginx-service -n task-namespace --url)

while true; do
  curl -o /dev/null -s -w "%{http_code}\n" $SERVICE_URL
  sleep 0.1
done
