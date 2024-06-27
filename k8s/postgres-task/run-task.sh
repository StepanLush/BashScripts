#!/bin/bash
kubectl create namespace postgres-namespace
echo
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
echo

kubectl apply -f postgres-deployment.yaml
echo

kubectl apply -f postgres-service.yaml
echo

kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
echo

