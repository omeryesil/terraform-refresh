# Storing Terraform State File in Azure Blob Container

**References**
- <a href="https://docs.microsoft.com/en-us/azure/terraform/terraform-backend" target="_blank">Tutorial: Store Terraform state in Azure Storage</a>

## Steps 

1. SET Environment Variables
    ```bash
    ENVIRONMENT=dev
    ENVIRONMENT_INSTANCE=2
    REGION=eastus
    RESOURCE_GROUP_NAME=devops-$ENVIRONMENT
    STORAGE_ACCOUNT_NAME=devops$ENVIRONMENT
    CONTAINER_NAME=tstate
    ```

2. Run storage and container creating script. 
    ```bash
    ./create-azure-storage.sh -e dev -i 1 -r eastus -g devops-$ENVIRONMENT -s devops$ENVIRONMENT$RANDOM -c "tstate"
    ```

3. Get access key into environment variable
  - Option 1 : Directly set the environment variable
    ```bash
    export ARM_ACCESS_KEY=<storage access key>
    ```
  - Option 2 : Store the access key in Azure KV, and get it from there (Key Vault mut be already created)
     
    ```bash
    export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name myKeyVault --query value -o tsv)
    ```
3.   


  





