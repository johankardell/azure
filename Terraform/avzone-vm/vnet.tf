resource "azurerm_resource_group" "vnet" {
  location = var.location
  name     = "RG-Vnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-default"
  address_space       = ["192.168.0.0/24"]
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  address_prefix       = "192.168.0.0/24"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}