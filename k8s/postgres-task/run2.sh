#!/bin/bash

kubectl apply -f postgres-headless-service.yaml

POSTGRES_POD_IP=$(kubectl get pods -l app=postgres -n postgres-namespace -o jsonpath='{.items[0].status.podIP}')

NGINX_POD=$(kubectl get pods -l app=nginx -o jsonpath='{.items[0].metadata.name}')

kubectl exec -it $NGINX_POD -- bash -c "apt-get update && apt-get install -y postgresql-client && psql -h $POSTGRES_POD_IP -U myuser -d mydatabase -W"
