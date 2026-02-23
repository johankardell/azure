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
  address_prefixes     = [var.vnet_spoke.subnet_servernet_iprange]
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

##### ROUTING

resource "azurerm_route_table" "udr_spoke_servernet" {
  name                          = "udr-servernet"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.net-spoke.name
  disable_bgp_route_propagation = true

  route {
    name                   = "AzureFirewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.0.4"
  }
}

resource "azurerm_subnet_route_table_association" "udr_subnet_servers" {
  subnet_id      = azurerm_subnet.spoke-servernet.id
  route_table_id = azurerm_route_table.udr_spoke_servernet.id
}
