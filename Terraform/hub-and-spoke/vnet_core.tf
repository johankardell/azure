##### VNET

resource "azurerm_virtual_network" "core" {
  name                = "${var.vnet_core.name}"
  address_space       = ["${var.vnet_core.iprange}"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.net-core.name}"
}

##### SUBNET

resource "azurerm_subnet" "jumpnet" {
  name                      = "${var.vnet_core.subnet_jumpnet_name}"
  address_prefix            = "${var.vnet_core.subnet_jumpnet_iprange}"
  resource_group_name       = "${azurerm_resource_group.net-core.name}"
  virtual_network_name      = "${azurerm_virtual_network.core.name}"
  network_security_group_id = "${azurerm_network_security_group.jumpnet.id}"
}

resource "azurerm_subnet" "coreservernet" {
  name                 = "${var.vnet_core.subnet_servernet_name}"
  address_prefix       = "${var.vnet_core.subnet_servernet_iprange}"
  resource_group_name  = "${azurerm_resource_group.net-core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
}

##### NSG

resource "azurerm_network_security_group" "jumpnet" {
  name                = "nsg-jumpnet"
  location            = "westeurope"
  resource_group_name = "${azurerm_resource_group.net-core.name}"

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.home_ip}"
    destination_address_prefix = "*"
  }
}

##### PEERING

resource "azurerm_virtual_network_peering" "core-to-spoke" {
  name                         = "core-to-spoke"
  resource_group_name          = "${azurerm_resource_group.net-core.name}"
  virtual_network_name         = "${azurerm_virtual_network.core.name}"
  remote_virtual_network_id    = "${azurerm_virtual_network.spoke.id}"
  allow_virtual_network_access = true
}
