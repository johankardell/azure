resourcegroups = {
  net-core = "Network-Infrastructure-CORE"
}

vnet_core = {
  name = "vnet-core"
  iprange = "10.0.0.0/20"

  subnet_servernet_name = "subnet-servernet"
  subnet_servernet_iprange = "10.0.0.0/24"
}
