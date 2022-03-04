#resource "azurerm_subnet" "akssubnetv" {
#  name                 = "akssubnetv"
#  resource_group_name  = "${var.env}-bsai"
#  address_prefixes     = ["172.21.0.0/24"]
#  virtual_network_name = "${var.env}-${var.region}-bsai-aks"
#  enforce_private_link_endpoint_network_policies = true
#  service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
#}

module "dev_k8s" {
  source               = "./../modules/aks"
  aks_name             = "${var.env}-k8s"
  aks_dns_name         = "${var.env}-k8s"
  location             = "${var.region}"
  resource_group_name  = "${var.env}-bsai"
  virtual_network_name = "${var.env}-${var.region}-bsai"
  aks_subnet_id        = azurerm_subnet.dev-subnet-01.id
  appId                = var.appId
  client_secret        = var.client_secret
  private_cluster_enabled = true
  private_cluster_public_fqdn_enabled = true
}

output "kube_config_dev_k8s" {
  value = module.dev_k8s.kube_config
  sensitive = true
}
