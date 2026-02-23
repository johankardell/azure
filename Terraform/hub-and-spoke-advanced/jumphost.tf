resource "azurerm_public_ip" "jumphost" {
  name                = var.jumphost.publicipname
  location            = var.location
  resource_group_name = azurerm_resource_group.jumphost.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "jumphost" {
  name                = var.jumphost.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.jumphost.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.jumpnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumphost.id
  }
}

resource "azurerm_linux_virtual_machine" "jumphost" {
  name                            = var.jumphost.vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.jumphost.name
  network_interface_ids           = [azurerm_network_interface.jumphost.id]
  size                            = var.jumphost.vmsize
  computer_name                   = var.jumphost.computer_name
  admin_username                  = var.jumphost.admin_username
  admin_password                  = var.jumphost.admin_password
  disable_password_authentication = false

  os_disk {
    name                 = var.jumphost.osdisk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-noble"
    sku       = "24_04-lts-gen2"
    version   = "latest"
  }

  provisioner "remote-exec" {
    connection {
      user     = var.jumphost.admin_username
      password = var.jumphost.admin_password
      host     = azurerm_public_ip.jumphost.ip_address
    }

    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt autoremove -y",
      "sudo apt install python3 screen net-tools -y",
    ]
  }
}

