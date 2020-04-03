resource "azurerm_public_ip" "vm3" {
  name                = "pip-vm3"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm3.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "vm3" {
  name                = "nic-vm3"
  location            = var.location
  resource_group_name = var.resourcegroup

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.vm3.id
  }
}

resource "azurerm_virtual_machine" "vm3" {
  name                  = "vm3"
  location              = azurerm_resource_group.vm3.location
  resource_group_name   = azurerm_resource_group.vm3.name
  network_interface_ids = [azurerm_network_interface.vm3.id]
  vm_size               = "Standard_B2ms"

  storage_os_disk {
    name              = "osdisk-vm3"
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
    computer_name  = "testvm"
    admin_username = local.admin_username
    # custom_data    = file("../scripts/install.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/${local.admin_username}/.ssh/authorized_keys"
    }
  }
}
