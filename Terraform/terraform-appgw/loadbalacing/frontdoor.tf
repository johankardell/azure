locals {
  resource_group_name = "RG-FrontDoor"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                = "fd-appgw-sample"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = "fd-appgw-sample-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
}

resource "azurerm_cdn_frontdoor_origin_group" "appgw" {
  name                     = "appgw"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id

  load_balancing {}

  health_probe {
    protocol            = "Http"
    interval_in_seconds = 30
    path                = "/"
  }
}

resource "azurerm_cdn_frontdoor_origin" "appgw" {
  name                          = "appgw-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.appgw.id
  host_name                     = data.azurerm_public_ip.appgw.ip_address
  http_port                     = 80
  https_port                    = 443
  enabled                       = true
}

resource "azurerm_cdn_frontdoor_route" "route" {
  name                          = "exampleRoutingRule1"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.appgw.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.appgw.id]
  supported_protocols           = ["Http"]
  patterns_to_match             = ["/*"]
  forwarding_protocol           = "HttpOnly"
}