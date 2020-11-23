locals {
  location = "westeurope"
}

resource "azurerm_resource_group" "group" {
  name     = "RG-Webapp-Vnet"
  location = local.location
}
