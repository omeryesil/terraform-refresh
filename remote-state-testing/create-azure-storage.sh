#!/bin/bash

# THIS SCRIPT CREATE STORAGE ACCOUNT and CONTAINER FOR TERRAFORM REMOTE STATES - should be automatically triggers

# TODO: 
#  . get variable names as argument or environment variable. 

#ENVIRONMENT=dev
#ENVIRONMENT_INSTANCE=2
#REGION=eastus
#RESOURCE_GROUP_NAME=devops-$ENVIRONMENT
#STORAGE_ACCOUNT_NAME=devops$ENVIRONMENT
#CONTAINER_NAME=tstate

ENVIRONMENT=""
ENVIRONMENT_INSTANCE=""
REGION=""

RESOURCE_GROUP_NAME=""
STORAGE_ACCOUNT_NAME=""
CONTAINER_NAME=""

#sample call
# ./create-azure-storage.sh -e dev -i 1 -r eastus -g devops-$ENVIRONMENT -s devops$ENVIRONMENT -c "tstate"   

while getopts 'e:i:r:g:s:c:' option
    do
    case "${option}"
    in
        e) ENVIRONMENT=${OPTARG};;
        i) ENVIRONMENT_INSTANCE=${OPTARG};;
        r) REGION=${OPTARG};;
        g) RESOURCE_GROUP_NAME=${OPTARG};;
        s) STORAGE_ACCOUNT_NAME=${OPTARG};;
        c) CONTAINER_NAME=${OPTARG};;
    esac
done

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $REGION

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_ZRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY


#echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
#echo "container_name: $CONTAINER_NAME"
#echo "access_key: $ACCOUNT_KEY"

echo "{ 
  'environment' : '$ENVIRONMENT',
  'environmentInstnce' : '$ENVIRONMENT_INSTANCE',
  'storageAccount' : '$STORAGE_ACCOUNT_NAME',
  'containerName' : '$CONTAINER_NAME',
  'storageAccountName' : '$STORAGE_ACCOUNT_NAME', 
  'containerName' : '$CONTAINER_NAME', 
  'accessKey' : '$ACCOUNT_KEY',  
}"

