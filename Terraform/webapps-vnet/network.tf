resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-webapp"
  address_space       = ["10.17.0.0/16"]
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_subnet" "server" {
  name                 = "subnet-server"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.17.0.0/24"]
}

resource "azurerm_subnet" "webapp" {
  name                 = "subnet-webapp"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.17.1.0/24"]

  delegation {
    name = "webapp-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_public_ip" "bastion" {
  name                = "bastion-publicip"
  sku                 = "Standard"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  allocation_method   = "Static"
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.17.254.0/24"]
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}

resource "azurerm_public_ip" "natgw" {
  name                = "nat-gateway-publicIP"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = "nat-gw1"
  location                = azurerm_resource_group.group.location
  resource_group_name     = azurerm_resource_group.group.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "natgw-pip" {
  public_ip_address_id = azurerm_public_ip.natgw.id
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
}

resource "azurerm_subnet_nat_gateway_association" "server" {
  subnet_id      = azurerm_subnet.server.id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}

resource "azurerm_subnet_nat_gateway_association" "webapp" {
  subnet_id      = azurerm_subnet.webapp.id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}

# NAT GW can only be associated with 1 VNet, but multiple subnets in that VNet
# resource "azurerm_subnet_nat_gateway_association" "server2" {
#   subnet_id      = azurerm_subnet.server2.id
#   nat_gateway_id = azurerm_nat_gateway.natgw.id
# }

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet-webapp2"
  address_space       = ["10.27.0.0/16"]
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_subnet" "server2" {
  name                 = "subnet-server"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.27.0.0/24"]
}

resource "azurerm_virtual_network_peering" "vnet-vnet2" {
  name                      = "vnet-vnet2"
  resource_group_name       = azurerm_resource_group.group.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

resource "azurerm_virtual_network_peering" "vnet2-vnet" {
  name                      = "vnet2-vet"
  resource_group_name       = azurerm_resource_group.group.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}
