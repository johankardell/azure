resourcegroups = {
  net-core    = "Network-Infrastructure-CORE"
  core-server = "TestServer-CORE"
}

vnet_core = {
  name    = "vnet-core"
  iprange = "10.0.0.0/20"

  subnet_servernet_name    = "subnet-servernet"
  subnet_servernet_iprange = "10.0.0.0/24"
}

vnet_core_server = {
  nicname      = "nic-core-server"
  publicipname = "ip-core-server"

  vm_name       = "coreserver"
  computer_name = "coreserver"
  vmsize        = "Standard_B1ms"
  osdisk_name   = "osdisk-core-server"

  admin_username = "azureuser"
  admin_password = "do_no_commit_passwords_to_git1234!"
}
