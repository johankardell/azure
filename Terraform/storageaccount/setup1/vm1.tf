resource "azurerm_public_ip" "vm1" {
  name                = "pip-vm1"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm1.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vm1" {
  name                = "nic-vm1"
  location            = var.location
  resource_group_name = var.resourcegroup

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1.id
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                            = "vm1"
  location                        = azurerm_resource_group.vm1.location
  resource_group_name             = azurerm_resource_group.vm1.name
  network_interface_ids           = [azurerm_network_interface.vm1.id]
  size                            = "Standard_B2ms"
  computer_name                   = "testvm"
  admin_username                  = local.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = local.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "osdisk-vm1"
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
