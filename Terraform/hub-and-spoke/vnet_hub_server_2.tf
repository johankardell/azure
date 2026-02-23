resource "azurerm_network_interface" "hub-server-2" {
  name                = var.vnet_hub_server_2.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.hub-server-2.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.hub-servernet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "hub-server-2" {
  name                            = var.vnet_hub_server_2.vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.hub-server-2.name
  network_interface_ids           = [azurerm_network_interface.hub-server-2.id]
  size                            = var.vnet_hub_server_2.vmsize
  computer_name                   = var.vnet_hub_server_2.computer_name
  admin_username                  = var.vnet_hub_server_2.admin_username
  admin_password                  = var.vnet_hub_server_2.admin_password
  disable_password_authentication = false

  os_disk {
    name                 = var.vnet_hub_server_2.osdisk_name
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