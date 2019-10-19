provider "azurerm" {
  version = "=1.35.0"
}

resource "azurerm_resource_group" "net-core" {
  name     = "${var.resourcegroups.net-core}"
  location = "${var.location}"
}

resource "azurerm_resource_group" "net-spoke" {
  name     = "${var.resourcegroups.net-spoke}"
  location = "${var.location}"
}

resource "azurerm_resource_group" "jumphost" {
  name     = "${var.resourcegroups.jumphost}"
  location = "${var.location}"
}

resource "azurerm_resource_group" "core-server" {
  name     = "${var.resourcegroups.core-server}"
  location = "${var.location}"
}

resource "azurerm_resource_group" "spoke-server" {
  name     = "${var.resourcegroups.spoke-server}"
  location = "${var.location}"
}