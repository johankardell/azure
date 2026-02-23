locals {
  nicname        = "nic-${var.vm_name}"
  vmsize         = "Standard_B2ms"
  osdisk_name    = "osdisk-${var.vm_name}"
  admin_username = "johan"
  ssh_key        = file("~/.ssh/id_rsa.pub")
}

data "azurerm_subnet" "web" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.vnet_resource_group_name
}

resource "azurerm_resource_group" "web" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_network_interface" "web" {
  name                = local.nicname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = data.azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.web.id]
  size                            = local.vmsize
  computer_name                   = var.vm_name
  admin_username                  = local.admin_username
  custom_data                     = base64encode(file("scripts/install_apache.sh"))
  disable_password_authentication = true

  admin_ssh_key {
    username   = local.admin_username
    public_key = local.ssh_key
  }

  os_disk {
    name                 = local.osdisk_name
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
