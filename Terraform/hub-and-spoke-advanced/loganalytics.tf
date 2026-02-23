resource "azurerm_log_analytics_workspace" "workspace" {
  name                = var.loganalytics.name
  location            = var.location
  resource_group_name = azurerm_resource_group.loganalytics.name
  retention_in_days   = 30
}