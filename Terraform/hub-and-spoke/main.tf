provider "azurerm" {
  version = "=1.43.0"
}

resource "azurerm_resource_group" "loganalytics" {
  name     = var.resourcegroups.loganalytics
  location = var.location
}

resource "azurerm_resource_group" "automationaccount" {
  name     = var.resourcegroups.automationaccount
  location = var.location
}

resource "azurerm_resource_group" "net-hub" {
  name     = var.resourcegroups.net-hub
  location = var.location
}

resource "azurerm_resource_group" "net-spoke" {
  name     = var.resourcegroups.net-spoke
  location = var.location
}

resource "azurerm_resource_group" "jumphost" {
  name     = var.resourcegroups.jumphost
  location = var.location
}

resource "azurerm_resource_group" "hub-server" {
  name     = var.resourcegroups.hub-server
  location = var.location
}

resource "azurerm_resource_group" "hub-server-2" {
  name     = var.resourcegroups.hub-server-2
  location = var.location
}

resource "azurerm_resource_group" "spoke-server" {
  name     = var.resourcegroups.spoke-server
  location = var.location
}