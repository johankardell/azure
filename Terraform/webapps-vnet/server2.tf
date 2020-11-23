resource "azurerm_network_interface" "server2" {
  name                = "server-nic2"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.server2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "server2" {
  name                = "linux-server2"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  custom_data         = base64encode(file("install.sh"))

  zone = "1"
  network_interface_ids = [
    azurerm_network_interface.server2.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
