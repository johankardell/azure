resource "azurerm_service_plan" "webapp" {
  name                = "vnet-demo-app-service-plan"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "appservice" {
  name                      = "vnet-app-service"
  location                  = azurerm_resource_group.group.location
  resource_group_name       = azurerm_resource_group.group.name
  service_plan_id           = azurerm_service_plan.webapp.id
  virtual_network_subnet_id = azurerm_subnet.webapp.id

  site_config {}

  app_settings = {
    "WEBSITE_VNET_ROUTE_ALL" = "1"
  }
}
