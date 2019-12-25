##### VNET

resource "azurerm_virtual_network" "spoke" {
  name                = var.vnet_spoke.name
  address_space       = [var.vnet_spoke.iprange]
  location            = var.location
  resource_group_name = azurerm_resource_group.net-spoke.name
}

##### SUBNET

resource "azurerm_subnet" "spoke-servernet" {
  name                 = var.vnet_spoke.subnet_servernet_name
  address_prefix       = var.vnet_spoke.subnet_servernet_iprange
  resource_group_name  = azurerm_resource_group.net-spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
}

##### PEERING

resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  name                         = "spoke-to-hub"
  resource_group_name          = azurerm_resource_group.net-spoke.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
}
