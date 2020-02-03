!#/bin/bash

# **************************************************************#
# Scritps to create an Azure Service Principal 
# **************************************************************#

# Set the right subscription account --------------------------------
az account set --subscription <subscription-id>

# Create AD app and get the Id of it ---------------------------------
appName="CICD"
az ad app create --display-name $appName --native-app 

adAppId=$(az ad app list --display-name $appName --query '[].appId' -o tsv)


# Create Self Signed Certificate  --------------------------------------------
# This certificate will be used to create Service Principal
mkdir ~/certs # any directory 
cd ~/certs

# create cert to use it for auth
openssl req -newkey rsa:4096 -nodes -keyout "service-principal.key" -out "service-principal.csr"
# Sign certificte signing request 
openssl x509 -signkey "service-principal.key" -in "service-principal.csr" -req -days 3650 -out "service-principal.crt"
# Generate PFX that will be used to auth with Azure
openssl pkcs12 -export -out "service-principal.pfx" -inkey "service-principal.key" -in "service-principal.crt"
# Generate pulic key that will be used to create sp 
openssl x509 -inform PEM -in "service-principal.crt" > service-principal.public.pem

# Create Service Principal --------------------------------------------
az ad sp create-for-rbac --name $adAppId --cert @~/certs/service-principal.public.pem


# get IDs
servicePrincipalAppId=$(az ad sp list --display-name $adAppId --query "[].appId" -o tsv)
subscriptionId=$(az account show --query id -o tsv)
tenantId=$(az account show --query tenantId -o tsv)
