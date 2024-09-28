#!/bin/bash

# prash Cleanup Script

set -e
RESOURCE_GROUP="prash-devops-rg"
AKS_CLUSTER_NAME="prash-aks-cluster"
ACR_NAME="prash-container-registry"

az login

echo "Deleting Kubernetes resources..."
kubectl delete deployment prash-backend
kubectl delete deployment prash-frontend
kubectl delete service prash-backend
kubectl delete service prash-frontend

echo "Deleting the AKS cluster..."
az aks delete --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --yes --no-wait

echo "Deleting the Azure Container Registry..."
az acr delete --name $ACR_NAME --resource-group $RESOURCE_GROUP --yes

echo "Cleanup completed successfully!"
