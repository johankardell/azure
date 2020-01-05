# TODO - Add health probe
# TODO - Set backend ips dynamically
# TODO - Change to multi-site configuration

locals {
  backendips = ["192.168.0.4", "192.168.0.5"]
}

data "azurerm_resource_group" "appgw" {
  name = "RG-APPGW"
}

data "azurerm_subnet" "frontend" {
  virtual_network_name = "vnet-appgw"
  resource_group_name  = "RG-APPGW"
  name                 = "frontend"
}

data "azurerm_public_ip" "appgw" {
  name                = "pip-appgw"
  resource_group_name = "RG-APPGW"
}

data "azurerm_virtual_network" "appgw" {
  name                = "vnet-appgw"
  resource_group_name = "RG-APPGW"
}

locals {
  backend_address_pool_name      = "${data.azurerm_virtual_network.appgw.name}-beap"
  frontend_port_name             = "${data.azurerm_virtual_network.appgw.name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_virtual_network.appgw.name}-feip"
  http_setting_name              = "${data.azurerm_virtual_network.appgw.name}-be-htst"
  listener_name                  = "${data.azurerm_virtual_network.appgw.name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_virtual_network.appgw.name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_virtual_network.appgw.name}-rdrcfg"
}

resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-sample"
  resource_group_name = data.azurerm_resource_group.appgw.name
  location            = data.azurerm_resource_group.appgw.location

  sku {
    name = "Standard_V2"
    tier = "Standard_V2"
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name         = local.backend_address_pool_name
    ip_addresses = local.backendips
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
