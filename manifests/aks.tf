resource "azurerm_subnet" "akssubnet" {
  name                 = "akssubnet"
  resource_group_name  = "${var.env}-bsai"
  address_prefixes     = ["10.0.5.0/24"]
  virtual_network_name = "${var.env}-${var.region}-bsai"
  service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
}

module "aks_bsai" {
  source               = "./../modules/aks"
  aks_name             = "${var.env}-aks"
  aks_dns_name         = "${var.env}-aks"
  location             = "${var.region}"
  resource_group_name  = "${var.env}-bsai"
  virtual_network_name = "${var.env}-${var.region}-bsai"
  appId                = var.appId
  client_secret        = var.client_secret
}

output "kube_config" {
  value = module.aks_bsai.kube_config
  sensitive = true
}
