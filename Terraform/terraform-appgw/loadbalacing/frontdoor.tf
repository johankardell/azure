locals {
  resource_group_name = "RG-FrontDoor"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_frontdoor" "frontdoor" {
  name                                         = "fd-appgw-sample"
  location                                     = var.location
  resource_group_name                          = azurerm_resource_group.rg.name
  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["exampleFrontendEndpoint1"]

    forwarding_configuration {
      forwarding_protocol           = "HttpOnly"
      backend_pool_name             = "appgw"
      cache_use_dynamic_compression = false
    }
  }

  backend_pool_load_balancing {
    name = "exampleLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "exampleHealthProbeSetting1"
  }

  backend_pool {
    name = "appgw"
    backend {
      host_header = "www.frontdoor.com"
      address     = data.azurerm_public_ip.appgw.ip_address
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
  }

  frontend_endpoint {
    name                              = "exampleFrontendEndpoint1"
    host_name                         = "fd-appgw-sample.azurefd.net"
    custom_https_provisioning_enabled = false
  }
}