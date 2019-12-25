resource "azurerm_network_interface" "hub-server-2" {
  name                = var.vnet_hub_server_2.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.hub-server-2.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.hub-servernet.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "hub-server-2" {
  name                  = var.vnet_hub_server_2.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.hub-server-2.name
  network_interface_ids = [azurerm_network_interface.hub-server-2.id]
  vm_size               = var.vnet_hub_server_2.vmsize

  storage_os_disk {
    name              = var.vnet_hub_server_2.osdisk_name
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
    computer_name  = var.vnet_hub_server_2.computer_name
    admin_username = var.vnet_hub_server_2.admin_username
    admin_password = var.vnet_hub_server_2.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}