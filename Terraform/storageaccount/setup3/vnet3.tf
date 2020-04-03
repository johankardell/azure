resource "azurerm_virtual_network" "vnet3" {
  name                = "vnet3-default"
  address_space       = ["192.168.0.0/24"]
  location            = var.location
  resource_group_name = azurerm_resource_group.vm3.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  address_prefix       = "192.168.0.0/24"
  resource_group_name  = azurerm_resource_group.vm3.name
  virtual_network_name = azurerm_virtual_network.vnet3.name

  enforce_private_link_service_network_policies  = false
  enforce_private_link_endpoint_network_policies = true
}
