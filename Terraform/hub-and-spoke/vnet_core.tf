resource "azurerm_virtual_network" "core" {
  name                = "${var.vnet_core.name}"
  address_space       = ["${var.vnet_core.iprange}"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.net-core.name}"
}

resource "azurerm_subnet" "servernet" {
  name                 = "${var.vnet_core.subnet_servernet_name}"
  address_prefix       = "${var.vnet_core.subnet_servernet_iprange}"
  resource_group_name  = "${azurerm_resource_group.net-core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
}