provider "azurerm" {
  version = "=1.35.0"
}

resource "azurerm_resource_group" "net-core" {
  name     = "${var.resourcegroups.net-core}"
  location = "${var.location}"
}

resource "azurerm_resource_group" "core-server" {
  name     = "${var.resourcegroups.core-server}"
  location = "${var.location}"
}
