#provider "azurerm" {
#  features {}
#}

#resource "azurerm_public_ip" "voxelbox" {
#  name                = "voxelbox"
#  resource_group_name = var.resource_group_name
#  location            = var.location
#  allocation_method   = "Static"
#  sku                 = "Standard"
#
#  tags = {
#    environment = "Terraform-aks"
#  }
#}
#
#resource "azurerm_public_ip" "voxelboxplus" {
#  name                = "voxelboxplus"
#  resource_group_name = var.resource_group_name
#  location            = var.location
#  allocation_method   = "Static"
#  sku                 = "Standard"
#
#  tags = {
#    environment = "Terraform-aks"
#  }
#}

resource "azurerm_kubernetes_cluster" "example" {
  name                    = var.aks_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.aks_dns_name
  #kubernetes_version      = "1.20.7"
  kubernetes_version      = "1.21.9"
  private_cluster_enabled = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled  = var.private_cluster_public_fqdn_enabled
  #sku_tier                = "Free"


  linux_profile {
    admin_username = "bsaiuser"

    ssh_key {
      key_data = file("~/.ssh/k8s.pub")         
    }
  }

  default_node_pool {
    name                = "vmpool"
   #node_count          = 4
    vm_size             = "Standard_B2s"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 10
    vnet_subnet_id          = var.aks_subnet_id
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
    #network_policy     = "calico"
    service_cidr       = "172.0.0.0/24"
    dns_service_ip     = "172.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }
  
 addon_profile {
   aci_connector_linux {
     enabled = false
 }

http_application_routing {
    enabled = false
  }

azure_policy {
  enabled = false
}

ingress_application_gateway {
  enabled = false
  #ingress_application_gateway_identity = []
}

kube_dashboard {
  enabled = false
}

oms_agent {
  enabled = false 
  #oms_agent_identity = [] 
 }
}

  tags = {
    environment = "Terraform_aks"  
   }
}

resource "azurerm_kubernetes_cluster_node_pool" "pool" {
  name                  = "memnodepool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  #vm_size               = "Standard_DS2_v2" 
  vm_size               = "Standard_D8as_v4"
  vnet_subnet_id          = var.aks_subnet_id
  os_disk_size_gb       = 50
  enable_auto_scaling   = true
  min_count             = 1
  max_count             = 10
  max_pods              = 10
  node_labels = {
    "hardware" = "highmem"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "cpu" {
  name                  = "cpunodepool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size               = "Standard_B2s"
  vnet_subnet_id          = var.aks_subnet_id
  os_disk_size_gb       = 50
  enable_auto_scaling   = true
  min_count             = 1
  max_count             = 10
  max_pods              = 10
  node_labels = {
    "hardware" = "highcpu"
  }

  tags = {
    Environment = "Production"
  }
}


#data "azurerm_public_ip" "aks" {
#  name                = reverse(split("/", tolist(azurerm_kubernetes_cluster.example.network_profile.0.load_balancer_profile.0.effective_outbound_ips)[0]))[0]
#  resource_group_name = var.resource_group_name
#}


output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}

#Notes - Persistant volume - kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=$AKS_PERS_STORAGE_ACCOUNT_NAME --from-literal=azurestorageaccountkey=$STORAGE_KEY
#echo "$(terraform output kube_config)" > /Users/manjur/.kube/config