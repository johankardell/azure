locals {
  resource_grup = "RG-WEBSERVERS"
}

module "webserver1" {
  source = "./modules/webserver/"

  vm_name             = "vm-web1"
  location            = var.location
  resource_group_name = local.resource_grup

  subnet_name              = "subnet-web"
  virtual_network_name     = "vnet-web"
  vnet_resource_group_name = "RG-VNET"
}

module "webserver2" {
  source = "./modules/webserver/"

  vm_name             = "vm-web2"
  location            = var.location
  resource_group_name = local.resource_grup

  subnet_name              = "subnet-web"
  virtual_network_name     = "vnet-web"
  vnet_resource_group_name = "RG-VNET"
}