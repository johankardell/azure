resource "azurerm_storage_account" "storage" {
  resource_group_name      = azurerm_resource_group.vm3.name
  location                 = var.location
  access_tier              = "Hot"
  name                     = "stojokaacctest3"
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_private_endpoint" "storage" {
  name                = "storage-endpoint"
  location            = azurerm_resource_group.vm3.location
  resource_group_name = azurerm_resource_group.vm3.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}
