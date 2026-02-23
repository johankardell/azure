##### VNET

resource "azurerm_virtual_network" "hub" {
  name                = var.vnet_hub.name
  address_space       = [var.vnet_hub.iprange]
  location            = var.location
  resource_group_name = azurerm_resource_group.net-hub.name
}

##### SUBNET

resource "azurerm_subnet" "jumpnet" {
  name                 = var.vnet_hub.subnet_jumpnet_name
  address_prefixes     = [var.vnet_hub.subnet_jumpnet_iprange]
  resource_group_name  = azurerm_resource_group.net-hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

resource "azurerm_subnet_network_security_group_association" "jumpnet" {
  subnet_id                 = azurerm_subnet.jumpnet.id
  network_security_group_id = azurerm_network_security_group.jumpnet.id
}

resource "azurerm_subnet" "hub-servernet" {
  name                 = var.vnet_hub.subnet_servernet_name
  address_prefixes     = [var.vnet_hub.subnet_servernet_iprange]
  resource_group_name  = azurerm_resource_group.net-hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

##### NSG

resource "azurerm_network_security_group" "jumpnet" {
  name                = "nsg-jumpnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.net-hub.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.home_ip
    destination_address_prefix = "*"
  }
}

##### PEERING

resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  name                         = "hub-to-spoke"
  resource_group_name          = azurerm_resource_group.net-hub.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
}
