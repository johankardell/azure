resourcegroups = {
  net-core     = "Network-Infrastructure-CORE"
  net-spoke    = "Network-Infrastructure-SPOKE"
  core-server  = "TestServer-CORE"
  jumphost     = "JumpServer-CORE"
  spoke-server = "TestServer-SPOKE"
}

vnet_core = {
  name    = "vnet-core"
  iprange = "10.0.0.0/16"

  subnet_jumpnet_name    = "subnet-jumpnet"
  subnet_jumpnet_iprange = "10.0.0.0/24"

  subnet_servernet_name    = "subnet-servernet"
  subnet_servernet_iprange = "10.0.1.0/24"
}

vnet_spoke = {
  name    = "vnet-core"
  iprange = "10.1.0.0/16"

  subnet_servernet_name    = "subnet-servernet"
  subnet_servernet_iprange = "10.1.0.0/24"
}

vnet_core_server = {
  nicname = "nic-core-server"

  vm_name       = "coreserver"
  computer_name = "coreserver"
  vmsize        = "Standard_B2ms"
  osdisk_name   = "osdisk-core-server"

  admin_username = "azureuser"
  admin_password = "do_no_commit_passwords_to_git1234!"
}

vnet_spoke_server = {
  nicname = "nic-spoke-server"

  vm_name       = "spokeerver"
  computer_name = "spokeserver"
  vmsize        = "Standard_B2ms"
  osdisk_name   = "osdisk-spoke-server"

  admin_username = "azureuser"
  admin_password = "do_no_commit_passwords_to_git1234!"
}

jumphost = {
  nicname      = "nic-jumphost"
  publicipname = "ip-jumphost"

  vm_name       = "jumphost"
  computer_name = "jumphost"
  vmsize        = "Standard_B2ms"
  osdisk_name   = "osdisk-jumphost"

  admin_username = "azureuser"
  admin_password = "do_no_commit_passwords_to_git1234!"
}
