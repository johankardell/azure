locals {
  vnet-resource-group = "RG-Vnet"

  web-vnet-name          = "vnet-web"
  web-vnet-address-space = "192.168.0.0/20"

  web-subnet-name           = "subnet-web"
  web-subnet-address-prefix = "192.168.0.0/24"
}

resource "azurerm_resource_group" "vnet" {
  name     = local.vnet-resource-group
  location = var.location
}

##### VNET

resource "azurerm_virtual_network" "web" {
  name                = local.web-vnet-name
  address_space       = [local.web-vnet-address-space]
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet.name
}

##### SUBNET

resource "azurerm_subnet" "web" {
  name                 = local.web-subnet-name
  address_prefix       = local.web-subnet-address-prefix
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.web.name
}

##### PEERING

resource "azurerm_virtual_network_peering" "web-to-appgw" {
  name                         = "web-to-appgw"
  resource_group_name          = azurerm_resource_group.vnet.name
  virtual_network_name         = azurerm_virtual_network.web.name
  remote_virtual_network_id    = azurerm_virtual_network.appgw.id
  allow_virtual_network_access = true
}
