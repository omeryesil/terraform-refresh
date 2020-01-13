provider "azurerm" {
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "${var.region}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

output "rg_name" { value = "${azurerm_resource_group.main.name}"}
output "vnet_name" { value = "${azurerm_virtual_network.main.name}"}

output "region" { value = "${var.region}" }
output "prefix" { value = "${var.prefix}" }

