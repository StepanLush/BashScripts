#!/bin/bash

DOCKER_USERNAME="stepanlushch"
IMAGE_NAME="nginx-counter"
NAMESPACE="default"
DEPLOYMENT_NAME="myapp-deployment"
COUNTER_FILE="index.html"
INGRESS_NAME="myapp-ingress"
NEW_COUNTER_VALUE=$1

if [ -z "$NEW_COUNTER_VALUE" ]; then
  echo "Необходимо передать новое значение {counter} в качестве аргумента"
  exit 1
fi

# Внесение изменений в {counter}
echo "Обновление значения {counter} в $COUNTER_FILE"
sed -i "s/Counter: [0-9]\+/Counter: $NEW_COUNTER_VALUE/" $COUNTER_FILE

# Создание нового Docker-образа
TAG="v$(date +%s)"
IMAGE="$DOCKER_USERNAME/$IMAGE_NAME:$TAG"

echo "Сборка Docker-образа $IMAGE"
docker build -t $IMAGE .

if [ $? -ne 0 ]; then
  echo "Ошибка сборки Docker-образа"
  exit 1
fi

# Пуш Docker-образа в Docker Hub
echo "Пуш Docker-образа $IMAGE в Docker Hub"
docker push $IMAGE

if [ $? -ne 0 ]; then
  echo "Ошибка пуша Docker-образа"
  exit 1
fi

# Обновление Deployment в Kubernetes
echo "Обновление Deployment $DEPLOYMENT_NAME в Kubernetes"
kubectl set image deployment/$DEPLOYMENT_NAME myapp=$IMAGE --namespace $NAMESPACE

if [ $? -ne 0 ]; then
  echo "Ошибка обновления Deployment"
  exit 1
fi

# Ожидание обновления подов
echo "Ожидание обновления подов"
kubectl rollout status deployment/$DEPLOYMENT_NAME --namespace $NAMESPACE

if [ $? -ne 0 ]; then
  echo "Ошибка обновления подов, откат на предыдущую ревизию"
  kubectl rollout undo deployment/$DEPLOYMENT_NAME --namespace $NAMESPACE
  exit 1
fi


