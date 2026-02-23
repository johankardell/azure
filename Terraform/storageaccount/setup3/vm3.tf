resource "azurerm_public_ip" "vm3" {
  name                = "pip-vm3"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm3.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vm3" {
  name                = "nic-vm3"
  location            = var.location
  resource_group_name = var.resourcegroup

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm3.id
  }
}

resource "azurerm_linux_virtual_machine" "vm3" {
  name                            = "vm3"
  location                        = azurerm_resource_group.vm3.location
  resource_group_name             = azurerm_resource_group.vm3.name
  network_interface_ids           = [azurerm_network_interface.vm3.id]
  size                            = "Standard_B2ms"
  computer_name                   = "testvm"
  admin_username                  = local.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = local.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "osdisk-vm3"
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
