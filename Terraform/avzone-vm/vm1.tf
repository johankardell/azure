resource "azurerm_resource_group" "vm1" {
  name     = "RG-VM1"
  location = var.location
}

resource "azurerm_public_ip" "vm1" {
  name                = "pip-vm1"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm1.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vm1" {
  name                = "nic-vm1"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm1.name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1.id
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm1"
  location              = var.location
  resource_group_name   = azurerm_resource_group.vm1.name
  network_interface_ids = [azurerm_network_interface.vm1.id]
  vm_size               = "Standard_D4s_v3"

  storage_os_disk {
    name              = "osdisk-vm1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.10-DAILY"
    version   = "latest"
  }

  os_profile {
    computer_name  = "vm1"
    admin_username = local.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/${local.admin_username}/.ssh/authorized_keys"
    }
  }
}
