resource "azurerm_network_interface" "hub-server" {
  name                = var.vnet_hub_server.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.hub-server.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.hub-servernet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "hub-server" {
  name                            = var.vnet_hub_server.vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.hub-server.name
  network_interface_ids           = [azurerm_network_interface.hub-server.id]
  size                            = var.vnet_hub_server.vmsize
  computer_name                   = var.vnet_hub_server.computer_name
  admin_username                  = var.vnet_hub_server.admin_username
  admin_password                  = var.vnet_hub_server.admin_password
  disable_password_authentication = false

  os_disk {
    name                 = var.vnet_hub_server.osdisk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-noble"
    sku       = "24_04-lts-gen2"
    version   = "latest"
  }
}