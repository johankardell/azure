locals {
  vm_name             = "vm-web1"
  resource_group_name = "RG-WEB"
}

module "webserver" {
  source = "./modules/webserver/"

  vm_name             = local.vm_name
  location            = var.location
  resource_group_name = local.resource_group_name


  subnet_name              = "subnet-web"
  virtual_network_name     = "vnet-web"
  vnet_resource_group_name = "RG-VNET"

}