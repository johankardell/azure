resource "azurerm_public_ip" "jumphost" {
  name                = var.jumphost.publicipname
  location            = var.location
  resource_group_name = azurerm_resource_group.jumphost.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "jumphost" {
  name                = var.jumphost.nicname
  location            = var.location
  resource_group_name = azurerm_resource_group.jumphost.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.jumpnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.jumphost.id
  }
}

resource "azurerm_virtual_machine" "jumphost" {
  name                  = var.jumphost.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.jumphost.name
  network_interface_ids = [azurerm_network_interface.jumphost.id]
  vm_size               = var.jumphost.vmsize

  storage_os_disk {
    name              = var.jumphost.osdisk_name
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
    computer_name  = var.jumphost.computer_name
    admin_username = var.jumphost.admin_username
    admin_password = var.jumphost.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
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
      "sudo apt install python screen net-tools -y",
    ]
  }
}

