resource "azurerm_storage_account" "storage1" {
  resource_group_name      = azurerm_resource_group.vm1.name
  location                 = var.location
  access_tier              = "Hot"
  name                     = "stojokaacctest1"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  network_rules {
    default_action = "Deny"
    ip_rules       = [azurerm_public_ip.vm1.ip_address]
  }
}