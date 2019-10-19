resource "azurerm_network_interface" "coreserver" {
  name                = "${var.vnet_core_server.nicname}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.core-server.name}"

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = "${azurerm_subnet.servernet.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "coreserver" {
  name                  = "${var.vnet_core_server.vm_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.core-server.name}"
  network_interface_ids = ["${azurerm_network_interface.coreserver.id}"]
  vm_size               = "${var.vnet_core_server.vmsize}"

  storage_os_disk {
    name              = "${var.vnet_core_server.osdisk_name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.10-DAILY"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.vnet_core_server.computer_name}"
    admin_username = "${var.vnet_core_server.admin_username}"
    admin_password = "${var.vnet_core_server.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

