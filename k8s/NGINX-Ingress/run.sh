#!/bin/bash


minikube addons enable ingress

kubectl create secret tls tls-secret --key tls.key --cert tls.crt

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
sleep 5
kubectl apply -f ingress.yaml

echo "$(minikube ip) nginx-local" | sudo tee -a /etc/hosts

