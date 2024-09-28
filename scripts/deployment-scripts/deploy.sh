#!/bin/bash

# prash Deployment Script

set -e
RESOURCE_GROUP="prash-devops-rg"
AKS_CLUSTER_NAME="prash-aks-cluster"
ACR_NAME="prash-container-registry"

# Log in to Azure
az login

# Get AKS credentials to interact with the Kubernetes cluster
echo "Getting AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME

# Deploy Backend
echo "Deploying Backend..."
kubectl apply -f k8s/backend-deployment.yaml   # Backend Deployment YAML file
kubectl apply -f k8s/backend-service.yaml      # Backend Service YAML file

# Deploy Frontend
echo "Deploying Frontend..."
kubectl apply -f k8s/frontend-deployment.yaml  # Frontend Deployment YAML file
kubectl apply -f k8s/frontend-service.yaml     # Frontend Service YAML file
