resource "azurerm_subnet" "akssubnet" {
  name                 = "akssubnet"
  resource_group_name  = "${var.env}-bsai"
  address_prefixes     = ["10.0.5.0/24"]
  virtual_network_name = "${var.env}-${var.region}-bsai"
  enforce_private_link_endpoint_network_policies = true
  service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
}

#resource "azurerm_subnet" "akssubnetv" {
#  name                 = "akssubnetv"
#  resource_group_name  = "${var.env}-bsai"
#  address_prefixes     = ["172.21.0.0/24"]
#  virtual_network_name = "${var.env}-${var.region}-bsai-aks"
#  enforce_private_link_endpoint_network_policies = true
#  service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
#}

#module "aks_bsai" {
#  source               = "./../modules/aks"
#  aks_name             = "${var.env}-aks"
#  aks_dns_name         = "${var.env}-aks"
#  location             = "${var.region}"
#  resource_group_name  = "${var.env}-bsai"
#  virtual_network_name = "${var.env}-${var.region}-bsai"
#  aks_subnet_id        = azurerm_subnet.akssubnet.id
#  appId                = var.appId
#  client_secret        = var.client_secret
#  private_cluster_enabled = false
#  private_cluster_public_fqdn_enabled = false
#}
#
#output "kube_config" {
#  value = module.aks_bsai.kube_config
#  sensitive = true
#}
