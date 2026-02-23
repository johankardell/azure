resource "azurerm_network_interface" "spokeserver" {
  name                = var.vnet_spoke_server.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.spoke-server.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.spoke-servernet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spokeserver" {
  name                            = var.vnet_spoke_server.vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.spoke-server.name
  network_interface_ids           = [azurerm_network_interface.spokeserver.id]
  size                            = var.vnet_spoke_server.vmsize
  computer_name                   = var.vnet_spoke_server.computer_name
  admin_username                  = var.vnet_spoke_server.admin_username
  admin_password                  = var.vnet_spoke_server.admin_password
  disable_password_authentication = false

  os_disk {
    name                 = var.vnet_spoke_server.osdisk_name
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

