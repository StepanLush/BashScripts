#!/bin/bash

kubectl create namespace task-namespace
echo
kubectl apply -f nginx-pod.yaml
echo
#kubectl exec -it -n task-namespace static-nginx-pod -- /bin/sh
#echo
#echo "curl localhost:80 :"
#echo
#curl localhost:80
#echo
#echo "All variables:"
#env
#echo
#exit

kubectl apply -f nginx-deployment-with-probes-and-strategy.yaml
echo
kubectl apply -f nginx-service.yaml
echo

kubectl create configmap nginx-config --from-file=nginx-custom.conf -n task-namespace
echo
#kubectl apply -f nginx-deployment-with-config.yaml
#echo
echo "URL for service: "
sleep 5
minikube service nginx-service -n task-namespace --url
echo
