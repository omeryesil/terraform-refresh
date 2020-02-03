locals {
    resourceGroupName = "${var.prefix}${var.environment}"
    storageAccountName = "${var.prefix}tsstate${var.environment}"
    containerName = "tfstate${var.environment}-${var.environmentInstance}"
}

resource "azurerm_resource_group" "resource_group" {
  name = local.resourceGroupName // "backend_rg"
  location = var.region
}

resource "azurerm_storage_account" "az_backend" {
  name                     = local.storageAccountName
  resource_group_name      = local.resourceGroupName
  location                 = var.region
  account_tier             = "standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "az_state_lock" {
  name                  = local.containerName
  resource_group_name   = local.resourceGroupName
  storage_account_name  = local.storageAccountName
  container_access_type = "private"
  lifecycle {
    prevent_destroy = true
  }
}