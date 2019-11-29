resource "azurerm_resource_group" "cluster" {
  name     = "Group-Terraform-AKS"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "terraform-aks"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "terraform-aks"
  kubernetes_version  = "1.14.8"

  agent_pool_profile {
    name                = "lnx"
    count               = 3
    vm_size             = "Standard_B4ms"
    enable_auto_scaling = true
    max_count           = 10
    min_count           = 1
    max_pods            = 50
    os_disk_size_gb     = 250
    os_type             = "Linux"
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = azurerm_subnet.aks-01.id
  }

  agent_pool_profile {
    name                = "win"
    count               = 3
    vm_size             = "Standard_B4ms"
    enable_auto_scaling = true
    max_count           = 10
    min_count           = 1
    max_pods            = 50
    os_disk_size_gb     = 250
    os_type             = "Windows"
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = azurerm_subnet.aks-01.id
  }

  windows_profile {
    admin_username = var.windows_admin_username
    admin_password = var.windows_admin_password
  }

  service_principal {
    client_id     = var.AKS_CLIENTID
    client_secret = var.AKS_CLIENTSECRET
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
  }
}
