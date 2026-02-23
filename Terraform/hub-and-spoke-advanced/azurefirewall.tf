resource "azurerm_public_ip" "azurefirewall" {
  name                = var.azurefirewall.publicip_name
  location            = var.location
  resource_group_name = var.resourcegroups.net-hub
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "azurefirewall" {
  name                = var.azurefirewall.name
  location            = var.location
  resource_group_name = var.resourcegroups.net-hub
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azurefirewall.id
    public_ip_address_id = azurerm_public_ip.azurefirewall.id
  }
}

resource "azurerm_firewall_network_rule_collection" "fw_network_rule" {
  name                = "network_rules"
  azure_firewall_name = azurerm_firewall.azurefirewall.name
  resource_group_name = var.resourcegroups.net-hub
  priority            = 100
  action              = "Allow"

  rule {
    name = "Allow"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "53",
      "80",
      "443"
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "Any"
    ]
  }
}
