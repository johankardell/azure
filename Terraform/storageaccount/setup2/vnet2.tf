resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2-default"
  address_space       = ["192.168.0.0/24"]
  location            = var.location
  resource_group_name = azurerm_resource_group.vm2.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  address_prefixes     = ["192.168.0.0/24"]
  resource_group_name  = azurerm_resource_group.vm2.name
  virtual_network_name = azurerm_virtual_network.vnet2.name

  service_endpoints = ["Microsoft.Storage"]
}