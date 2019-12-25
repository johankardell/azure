resource "azurerm_network_interface" "hub-server" {
  name                = var.vnet_hub_server.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.hub-server.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.hub-servernet.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "hub-server" {
  name                  = var.vnet_hub_server.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.hub-server.name
  network_interface_ids = [azurerm_network_interface.hub-server.id]
  vm_size               = var.vnet_hub_server.vmsize

  storage_os_disk {
    name              = var.vnet_hub_server.osdisk_name
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
    computer_name  = var.vnet_hub_server.computer_name
    admin_username = var.vnet_hub_server.admin_username
    admin_password = var.vnet_hub_server.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}