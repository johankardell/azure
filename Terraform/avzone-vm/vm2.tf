resource "azurerm_resource_group" "vm2" {
  name     = "RG-VM2"
  location = var.location
}

resource "azurerm_public_ip" "vm2" {
  name                = "pip-vm2"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm2.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["2"]
}

resource "azurerm_network_interface" "vm2" {
  name                = "nic-vm2"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm2.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm2.id
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                            = "vm2"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.vm2.name
  network_interface_ids           = [azurerm_network_interface.vm2.id]
  size                            = "Standard_D4s_v3"
  computer_name                   = "vm2"
  admin_username                  = local.admin_username
  disable_password_authentication = true
  zone                            = "2"

  admin_ssh_key {
    username   = local.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "osdisk-vm2"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-noble"
    sku       = "24_04-lts-gen2"
    version   = "latest"
  }
}
