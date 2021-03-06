resourcegroups = {
  net-hub           = "Network-Infrastructure-HUB"
  net-spoke         = "Network-Infrastructure-SPOKE"
  hub-server        = "TestServer-HUB"
  hub-server-2      = "TestServer-HUB-2"
  jumphost          = "JumpServer-HUB"
  spoke-server      = "TestServer-SPOKE"
  automationaccount = "Automation"
  loganalytics      = "LogAnalytics"
}

vnet_hub = {
  name    = "vnet-hub"
  iprange = "10.0.0.0/16"

  subnet_jumpnet_name    = "subnet-jumpnet"
  subnet_jumpnet_iprange = "10.0.0.0/24"

  subnet_servernet_name    = "subnet-servernet"
  subnet_servernet_iprange = "10.0.1.0/24"
}

vnet_spoke = {
  name    = "vnet-spoke-1"
  iprange = "10.1.0.0/16"

  subnet_servernet_name    = "subnet-servernet"
  subnet_servernet_iprange = "10.1.0.0/24"
}

vnet_hub_server = {
  nicname = "nic-hub-server"

  vm_name       = "hubserver"
  computer_name = "hubserver"
  vmsize        = "Standard_B2ms"
  osdisk_name   = "osdisk-hub-server"

  admin_username = "azureuser"
  admin_password = "do_no_commit_passwords_to_git1234!"
}

vnet_hub_server_2 = {
  nicname = "nic-hub-server-2"

  vm_name       = "hubserver2"
  computer_name = "hubserver2"
  vmsize        = "Standard_B2ms"
  osdisk_name   = "osdisk-hub-server"

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

automationaccount = {
  name = "automationaccount"
}

loganalytics = {
  name = "log-analytics-workspace90210"
}
