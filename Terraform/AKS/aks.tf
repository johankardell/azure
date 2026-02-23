resource "azurerm_resource_group" "cluster" {
  name     = "Group-Terraform-AKS"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "terraform-aks"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "terraform-aks"
  kubernetes_version  = "1.30"

  default_node_pool {
    name                = "lnx"
    vm_size             = "Standard_B4ms"
    auto_scaling_enabled = true
    max_count           = 10
    min_count           = 1
    max_pods            = 50
    os_disk_size_gb     = 32
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = azurerm_subnet.aks-01.id
  }

  windows_profile {
    admin_username = var.windows_admin_username
    admin_password = var.windows_admin_password
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "win" {
  name                  = "win"
  vm_size               = "Standard_B4ms"
  auto_scaling_enabled  = true
  max_count             = 10
  min_count             = 1
  max_pods              = 50
  os_disk_size_gb       = 64
  os_type               = "Windows"
  vnet_subnet_id        = azurerm_subnet.aks-01.id
  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
}
