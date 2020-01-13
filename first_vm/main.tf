provider "azurerm" {
}

module "core_infra" {
  source = "../core_infra"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${module.core_infra.rg_name}"
  virtual_network_name = "${module.core_infra.vnet_name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "main" {
  count               = "${length(var.vm_count)}"

  name                = "${module.core_infra.prefix}-nic-${count.index+1}"
  location            = "${module.core_infra.region}"
  resource_group_name = "${module.core_infra.rg_name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  count                 = "${length(var.vm_count)}"

  name                  = "${module.core_infra.prefix}-vm-${count.index+1}"
  location            = "${module.core_infra.region}"
  resource_group_name = "${module.core_infra.rg_name}"

  network_interface_ids = ["${element(azurerm_network_interface.main.*.id, count.index)}"]
  vm_size               = "${var.vm_type["dev"]}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${module.core_infra.prefix}-disk-${count.index+1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

output "virtual_machine_name" { value = "${azurerm_virtual_machine.main.*.name }" }
output "virtual_machine_location" { value = "${azurerm_virtual_machine.main.*.location}" }

# join method
output "virtual_machine_ids" {
  value = "${join(",", azurerm_virtual_machine.main.*.id)}"
}