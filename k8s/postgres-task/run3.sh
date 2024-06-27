#!/bin/bash

kubectl apply -f postgres-statefulset.yaml


NGINX_POD=$(kubectl get pods -l app=nginx -o jsonpath='{.items[0].metadata.name}')

kubectl exec -it $NGINX_POD -- bash -c "apt-get update && apt-get install -y postgresql-client && psql -h postgres-0.postgres.postgres-namespace.svc.cluster.local -U myuser -d mydatabase -W"

