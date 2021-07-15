provider "azurerm" {
  version = "2.65.0"
  features {}
}

resource "azurerm_subnet_service_endpoint_storage_policy" "stg" {
  depends_on           = [module.vnet]
  name                = "storage-policy-bsai"
  resource_group_name = "${var.env}-bsai"
  location            = var.region
  definition {
    name        = "storage"
    #description = "definition1"
    service_resources = [
      module.resource_group.id,
      module.storage_bsai.id
    ]
  }
}

resource "azurerm_subnet" "backend" {
  depends_on           = [module.vnet]
  name                 = "backend"
  virtual_network_name = "${var.env}-${var.region}-bsai"
  resource_group_name  = "${var.env}-bsai"
  address_prefixes     = ["10.0.0.0/24"]
  enforce_private_link_service_network_policies = true
  service_endpoints = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "frontend" {
  depends_on = [module.vnet]
  name                 = "frontend"
  virtual_network_name = "${var.env}-${var.region}-bsai"
  resource_group_name  = "${var.env}-bsai"
  address_prefixes     = ["10.0.1.0/24"]
}

module "resource_group" {
  source                 = "./../modules/resourcegp"
  resource_group_name    = "${var.env}-bsai"
  region                 = "${var.region}"
}

module "vnet" {
  depends_on = [module.resource_group]
  source                  = "./../modules/networking"
  resource_group_name     = "${var.env}-bsai"
  vnet_name               = "${var.env}-${var.region}-bsai"
  location                = "${var.region}"
  vnet_address            = ["10.0.0.0/16"]
}

module "storage_bsai" {
  depends_on = [module.resource_group]
  source   = "./../modules/storage"
  storageaccount_name       = "${var.env}${var.storage_name}"
  resource_group_name       = "${var.env}-bsai"
  storageaccount_location   = "${var.region}"
  storageshare_name         = "${var.env}${var.storage_name}"
  storage_account_name      = "${var.env}${var.storage_name}"
  stg_account_tier          = var.stg_account_tier_bsai
  storageshare_quota        = var.storageshare_quota_bsai
  stg_ip_rules              = var.stg_ip_rules_bsai
  vnet_subnet_id            = azurerm_subnet.backend.id
  allow_blob_public_access  = var.allow_blob_public_access_bsai
  enable_https_traffic_only = var.enable_https_traffic_only_bsai
  nfsv3_enabled             = var.nfsv3_enabled_bsai
  account_replication_type  = var.account_replication_type_bsai
}

module "container_registery" {
  depends_on               = [module.resource_group]
  source                   = "./../modules/contreg"
  contreg_name             = "${var.env}bsai"
  resource_group_name      = "${var.env}-bsai"
  contreg_location         = "${var.region}"
  
}

module "app_service1" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  app_name                        = "${var.env}-${var.app_service1}"
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service1}"
  virtual_network_name            = azurerm_subnet.backend.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name
  linux_fx_version                = var.linux_fx_version
}

#module "app_service2" {
#  depends_on           = [module.resource_group]
#  source               = "./../modules/appservice"
#  app_name             = "${var.env}-${var.app_service2}"
#  location             = "${var.region}"
#  resource_group_name  = "${var.env}-bsai"
#  app_service_name     = "${var.env}-${var.app_service2}"
#  virtual_network_name = azurerm_subnet.backend.id
#}

module "azure_function1" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/function-basic"
  function_name                   = "${var.env}${var.function_name1}"
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  storageaccount_name             = "${var.function_name1}"
  virtual_network_name            = azurerm_subnet.backend.id
}

module "azure_function2" {
  depends_on           = [module.resource_group]
  source               = "./../modules/function-basic"
  function_name        = "${var.env}${var.function_name2}"
  location             = "${var.region}"
  resource_group_name  = "${var.env}-bsai"
  storageaccount_name  = "${var.function_name1}"
  virtual_network_name = azurerm_subnet.backend.id
}

module "azure_function3" {
  depends_on           = [module.resource_group]
  source               = "./../modules/function-basic"
  function_name        = "${var.env}${var.function_name3}"
  location             = "${var.region}"
  resource_group_name  = "${var.env}-bsai"
  storageaccount_name  = "${var.function_name1}"
  virtual_network_name = azurerm_subnet.backend.id
}

module "cosmosdb_1" {
  depends_on                   = [module.vnet]
  source                       = "./../modules/cosmosdb"
  cosmodb_account_name         = "${var.env}${var.cosmodb_account_name_1}"
  resource_group_name          = "${var.env}-bsai"
  ip_range_filter              = var.ip_range_filter
  location                     = "${var.region}"
  cosmosdb_name                = var.cosmosdb_name_1
  enable_automatic_failover    = var.enable_automatic_failover
  failover_location_secondary  = var.failover_location_secondary
  failover_priority_secondary  = var.failover_priority_secondary
  vnet_subnet_id               = azurerm_subnet.backend.id    
}

module "servicebus_1" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = "${var.env}${var.servicebus_name_1}"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_1
}

module "servicebus_2" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = "${var.env}${var.servicebus_name_2}"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_2
}

/* OUTOUT */
output "subnet_backend_id" {
  value = "${azurerm_subnet.backend.id}"
}

output "subnet_frontend_id" {
  value = "${azurerm_subnet.frontend.id}"
}

output "resource_group_id" {
  value = "${module.resource_group.id}"
}

output "storage_bsai_id" {
  value = "${module.storage_bsai.id}"
}

output "service_endpoint_policy_ids" {
  value = "${azurerm_subnet_service_endpoint_storage_policy.stg.id}"
}