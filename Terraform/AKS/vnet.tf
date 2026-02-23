resource "azurerm_resource_group" "aks-vnet" {
  name     = "Group-Terraform-AKS-VNET"
  location = var.location
}

resource "azurerm_virtual_network" "aks-vnet" {
  name                = "vnet-aks"
  address_space       = ["10.0.0.0/8"]
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-vnet.name
}

resource "azurerm_subnet" "aks-01" {
  name                 = "subnet-aks-01"
  address_prefixes     = ["10.10.0.0/16"]
  resource_group_name  = azurerm_resource_group.aks-vnet.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
}

resource "azurerm_subnet" "aks-02" {
  name                 = "subnet-aks-02"
  address_prefixes     = ["10.20.0.0/16"]
  resource_group_name  = azurerm_resource_group.aks-vnet.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
}