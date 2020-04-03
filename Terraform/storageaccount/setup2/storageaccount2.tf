resource "azurerm_storage_account" "storage" {
  resource_group_name      = azurerm_resource_group.vm2.name
  location                 = var.location
  access_tier              = "Hot"
  name                     = "stojokaacctest2"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
  }
}
