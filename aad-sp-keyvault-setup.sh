#!/bin/bash

# This script automates the creation of an Azure AD Application, Service Principal, and Key Vault.

# Set your variables
RESOURCE_GROUP="prash-devops-rg"
LOCATION="eastus"
KV_NAME="prashKeyVault"
SP_NAME="prash-DevOps-ServicePrincipal"

# Create Azure AD Application and Service Principal
echo "Creating Azure AD Application and Service Principal..."
SP_OUTPUT=$(az ad sp create-for-rbac --name $SP_NAME --role contributor --scopes /subscriptions/{your-subscription-id} --output json)

# Extract values
CLIENT_ID=$(echo $SP_OUTPUT | jq -r '.appId')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.password')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenant')

# Get Object ID of the Service Principal
OBJECT_ID=$(az ad sp show --id $CLIENT_ID --query objectId --output tsv)

# Create Key Vault
echo "Creating Azure Key Vault: $KV_NAME"
az keyvault create --name $KV_NAME --resource-group $RESOURCE_GROUP --location $LOCATION

# Store secrets in Key Vault
echo "Storing Service Principal secrets in Key Vault..."
az keyvault secret set --vault-name $KV_NAME --name "ClientId" --value $CLIENT_ID
az keyvault secret set --vault-name $KV_NAME --name "ClientSecret" --value $CLIENT_SECRET
az keyvault secret set --vault-name $KV_NAME --name "ObjectId" --value $OBJECT_ID
az keyvault secret set --vault-name $KV_NAME --name "TenantId" --value $TENANT_ID

# Optional: Store database credentials in Key Vault
DB_ADMIN="dbadmin"
DB_ADMIN_PASSWORD="dbadminpassword123"
echo "Storing Database credentials in Key Vault..."
az keyvault secret set --vault-name $KV_NAME --name "DBAdmin" --value $DB_ADMIN
az keyvault secret set --vault-name $KV_NAME --name "DBAdminPassword" --value $DB_ADMIN_PASSWORD

# Output results
echo "Azure AD Service Principal and Key Vault setup complete."
echo "Client ID: $CLIENT_ID"
echo "Client Secret: [Hidden]"
echo "Object ID: $OBJECT_ID"
echo "Key Vault Name: $KV_NAME"
