resource "azurerm_app_service_plan" "webapp" {
  name                = "vnet-demo-app-service-plan"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "vnet-app-service"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  app_service_plan_id = azurerm_app_service_plan.webapp.id

  app_settings = {
    "WEBSITE_VNET_ROUTE_ALL" = "1"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet" {
  app_service_id = azurerm_app_service.appservice.id
  subnet_id      = azurerm_subnet.webapp.id
}
