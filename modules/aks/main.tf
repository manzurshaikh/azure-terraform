#provider "azurerm" {
#  features {}
#}

resource "azurerm_public_ip" "aks" {
  name                = "aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Terraform-aks"
  }
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "dev-aks-dns"
  kubernetes_version  = "1.20.7"

  default_node_pool {
    name           = "examplepool"
    node_count     = 2
    vm_size        = "Standard_B2s"
    os_disk_size_gb = 50
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 4
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true  
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    network_policy     = "calico"
  }

  tags = {
    environment = "Terraform_aks"  
   }
}

#data "azurerm_public_ip" "aks" {
#  name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.example.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
#  resource_group_name = var.resource_group_name
#}