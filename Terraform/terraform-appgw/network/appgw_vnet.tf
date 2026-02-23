resource "azurerm_resource_group" "appgw" {
  name     = "RG-APPGW"
  location = "West Europe"
}

resource "azurerm_virtual_network" "appgw" {
  name                = "vnet-appgw"
  resource_group_name = azurerm_resource_group.appgw.name
  location            = azurerm_resource_group.appgw.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.appgw.name
  virtual_network_name = azurerm_virtual_network.appgw.name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.appgw.name
  virtual_network_name = azurerm_virtual_network.appgw.name
  address_prefixes     = ["10.254.2.0/24"]
}

resource "azurerm_public_ip" "appgw" {
  name                = "pip-appgw"
  resource_group_name = azurerm_resource_group.appgw.name
  location            = azurerm_resource_group.appgw.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

##### PEERING

resource "azurerm_virtual_network_peering" "appgw-to-web" {
  name                         = "appgw-to-web"
  resource_group_name          = azurerm_resource_group.appgw.name
  virtual_network_name         = azurerm_virtual_network.appgw.name
  remote_virtual_network_id    = azurerm_virtual_network.web.id
  allow_virtual_network_access = true
}