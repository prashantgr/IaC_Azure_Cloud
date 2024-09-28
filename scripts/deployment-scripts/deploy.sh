#!/bin/bash

# prash Deployment Script

set -e
RESOURCE_GROUP="prash-devops-rg"
AKS_CLUSTER_NAME="prash-aks-cluster"
ACR_NAME="prash-container-registry"

az login

echo "Getting AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME

echo "Deploying Backend..."
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml

echo "Deploying Frontend..."
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
