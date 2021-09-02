provider "azurerm" {
  version = "2.65.0"
  features {}
}

/* AZURE SUBNETS */
resource "azurerm_subnet_service_endpoint_storage_policy" "stg" {
  depends_on          = [module.vnet]
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
  depends_on                                    = [module.vnet]
  name                                          = "backend"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.0.0/24"]
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "application" {
  depends_on                                    = [module.vnet]
  name                                          = "application"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.2.0/24"]
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "frontend" {
  depends_on                                    = [module.vnet]
  name                                          = "frontend"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.1.0/24"]
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "internal" {
  depends_on                                    = [module.vnet]
  name                                          = "internal"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.3.0/24"]
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}


resource "azurerm_subnet" "aci" {
  depends_on                                    = [module.vnet]
  name                                          = "aci"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.4.0/24"]
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

/* Azure Function Basic (consumtion) plan */
resource "azurerm_app_service_plan" "main" {
  name                = "${var.env}_${var.fun_service_plan_name}"
  resource_group_name = "${var.env}-bsai"
  location            = var.region
  kind                = "functionapp"

  sku {
    tier = var.tier_az_fun_plan
    size = var.size_az_fun_plan
  }
}

/* App_Service plan for Premium Azure Function */
resource "azurerm_app_service_plan" "funpremium_plan" {
  name                = "${var.env}_${var.fun_premium_plan_name}"
  location            = var.region
  resource_group_name = "${var.env}-bsai"
  kind                = "elastic"
  reserved            = true

  sku {
  #  capacity = var.capacity_az_funpremium_plan
    tier     = var.tier_az_funpremium_plan
    size     = var.size_az_funpremium_plan
  }
}

/* App_Service plan for Azure App Service ML Dockers */
resource "azurerm_app_service_plan" "mldockers_plan" {
  name                = "${var.env}_${var.app_service_plan_docker_name}"
  location            = var.region
  resource_group_name = "${var.env}-bsai"
  kind                = "Linux"
  reserved            = true
  #maximum_elastic_worker_count = "10"
  per_site_scaling             = false

  sku {
  #  capacity = var.capacity_az_appservice_docker_plan
    tier     = var.tier_az_appservice_docker_plan
    size     = var.size_az_appservice_docker_plan
  }
}

/* Azure Autoscaling for App Service Plan */
module "appservice_autoscaling_mldocker" {
  source                        = "./../modules/appservicescale"
  appservice_plan_name          = "mldockers_plan_scaling_rule"
  resource_group_name           = "${var.env}-bsai"
  location                      = var.region
  appservice_target_resource_id = azurerm_app_service_plan.mldockers_plan.id
}

/* App_Service plan for Azure App Service file_processing */
resource "azurerm_app_service_plan" "fileprocess_plan" {
  name                         = "${var.env}_${var.fileprocess_plan_name}"
  location                     = var.region
  resource_group_name          = "${var.env}-bsai"
  kind                         = "Linux"
  reserved                     = true
  #maximum_elastic_worker_count = "10"
  per_site_scaling             = false

  sku {
  #  capacity = var.capacity_az_appservice_docker_plan
    tier     = var.tier_az_appservice_docker_plan
    size     = var.size_az_appservice_docker_plan
  }
}

/* Azure Autoscaling for App Service Plan */
module "appservice_autoscaling_fileprocessing" {
  source                        = "./../modules/appservicescale"
  appservice_plan_name          = "fileprocess_plan_scaling_rule"
  resource_group_name           = "${var.env}-bsai"
  location                      = var.region
  appservice_target_resource_id = azurerm_app_service_plan.fileprocess_plan.id
}

/* Azure Resource Group */
module "resource_group" {
  source                 = "./../modules/resourcegp"
  resource_group_name    = "${var.env}-bsai"
  region                 = "${var.region}"
}

/* Azure Virtual Network */
module "vnet" {
  depends_on = [module.resource_group]
  source                  = "./../modules/networking"
  resource_group_name     = "${var.env}-bsai"
  vnet_name               = "${var.env}-${var.region}-bsai"
  location                = "${var.region}"
  vnet_address            = ["10.0.0.0/16"]
}

/* Azure Storage Account for File Share */
module "storage_bsai" {
  depends_on = [module.resource_group]
  source   = "./../modules/storage"
  storageaccount_name       = "${var.env}${var.storage_name}"
  resource_group_name       = "${var.env}-bsai"
  storageaccount_location   = "${var.region}"
  storageshare_name         = "${var.env}${var.storage_name}"
  storage_account_name      = "${var.env}${var.storage_name}"
  stg_account_tier          = var.stg_account_tier_bsai
  stg_access_tier           = var.stg_access_tier
  storageshare_quota        = var.storageshare_quota_bsai
  stg_ip_rules              = var.stg_ip_rules_bsai
  default_action_rule       = var.default_action_rule
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
  azurerm_app_service_plan        = azurerm_app_service_plan.mldockers_plan.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service1}"
  virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service1
  linux_fx_version                = var.linux_fx_version_app_service1
  docker_enable_ci                = "true"
  app_storage_key                 = var.app_storage_key_1
  #app_storage_account_name        = "${var.env}${var.storage_name}" 
  app_storage_account_name        = "devfilesharestg"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.mldockers_plan.id
}

module "app_service2" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.mldockers_plan.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service2}"
  virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service2
  linux_fx_version                = var.linux_fx_version_app_service2
  docker_enable_ci                = "true"
  app_storage_key                 = var.app_storage_key_1
  #app_storage_account_name        = "${var.env}${var.storage_name}"
  app_storage_account_name        = "devfilesharestg"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.mldockers_plan.id
}

module "app_service3" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.mldockers_plan.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service3}"
  virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service3
  linux_fx_version                = var.linux_fx_version_app_service3
  docker_enable_ci                = "true"
  app_storage_key                 = var.app_storage_key_1
  #app_storage_account_name        = "${var.env}${var.storage_name}"
  app_storage_account_name        = "devfilesharestg"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.mldockers_plan.id
}

module "app_service4" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.fileprocess_plan.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service4}"
  virtual_network_name            = azurerm_subnet.internal.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service3
  linux_fx_version                = var.linux_fx_version_app_service3
  docker_enable_ci                = "true"
  app_storage_key                 = var.app_storage_key_1
  #app_storage_account_name        = "${var.env}${var.storage_name}"
  app_storage_account_name        = "devfilesharestg"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.fileprocess_plan.id
}

module "azure_function1" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name1}"
  location                         = "${var.region}"
  resource_group_name              = "${var.env}-bsai"
  virtual_network_name             = azurerm_subnet.frontend.id
  functions_worker_runtime         = var.functions_worker_runtime
  website_node_default_version     = var.website_node_default_version
  website_run_from_package         = var.website_run_from_package_fun1
  #AzureWebJobs.fileupload.Disabled = toset(null)
  app_service_plan_id              = azurerm_app_service_plan.funpremium_plan.id
  fun_os_type                      = "linux"
  website_enable_app_service_storage = "true"
  website_enable_sync_update_site    = "true"
}


module "azure_function2" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name2}"
  location                         = "${var.region}"
  resource_group_name              = "${var.env}-bsai"
  virtual_network_name             = azurerm_subnet.backend.id
  functions_worker_runtime         = var.functions_worker_runtime
  website_node_default_version     = var.website_node_default_version
  website_run_from_package         = var.website_run_from_package
  #AzureWebJobs_fileupload_Disabled = toset(null)
  app_service_plan_id              = azurerm_app_service_plan.main.id
  fun_os_type                      = toset(null)
  website_enable_app_service_storage = "true"
  website_enable_sync_update_site    = "true"
}

module "azure_function3" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name3}"
  location                         = "${var.region}"
  resource_group_name              = "${var.env}-bsai"
  virtual_network_name             = azurerm_subnet.backend.id
  functions_worker_runtime         = var.functions_worker_runtime
  website_node_default_version     = var.website_node_default_version
  website_run_from_package         = var.website_run_from_package
  #AzureWebJobs_fileupload_Disabled = toset(null)
  app_service_plan_id              = azurerm_app_service_plan.main.id
  fun_os_type                      = toset(null)
  website_enable_app_service_storage = "true"
  website_enable_sync_update_site    = "true"
}

module "azure_function4" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name4}"
  location                         = "${var.region}"
  resource_group_name              = "${var.env}-bsai"
  virtual_network_name             = azurerm_subnet.backend.id
  functions_worker_runtime         = var.functions_worker_runtime
  website_node_default_version     = var.website_node_default_version
  website_run_from_package         = var.website_run_from_package
  #AzureWebJobs_fileupload_Disabled = "1"
  app_service_plan_id              = azurerm_app_service_plan.main.id
  fun_os_type                      = toset(null)
  website_enable_app_service_storage = "true"
  website_enable_sync_update_site    = "true"
}

module "azure_function5" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name5}"
  location                         = "${var.region}"
  resource_group_name              = "${var.env}-bsai"
  virtual_network_name             = azurerm_subnet.backend.id
  functions_worker_runtime         = var.functions_worker_runtime
  website_node_default_version     = var.website_node_default_version
  website_run_from_package         = var.website_run_from_package
  #AzureWebJobs_fileupload_Disabled = "1"
  app_service_plan_id              = azurerm_app_service_plan.main.id
  fun_os_type                      = toset(null)
  website_enable_app_service_storage = "true"
  website_enable_sync_update_site    = "true"
}

module "azure_function6" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name6}"
  location                         = "${var.region}"
  resource_group_name              = "${var.env}-bsai"
  virtual_network_name             = azurerm_subnet.backend.id
  functions_worker_runtime         = var.functions_worker_runtime
  website_node_default_version     = var.website_node_default_version
  website_run_from_package         = var.website_run_from_package
  #AzureWebJobs_fileupload_Disabled = "1"
  app_service_plan_id              = azurerm_app_service_plan.main.id
  fun_os_type                      = toset(null)
  website_enable_app_service_storage = "true"
  website_enable_sync_update_site    = "true"
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
  vnet_subnet_id               = [{id   = azurerm_subnet.backend.id}, {id = azurerm_subnet.application.id}, {id = azurerm_subnet.frontend.id}, {id = azurerm_subnet.internal.id}, {id = azurerm_subnet.akssubnet.id}]
}

module "servicebus_1" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = "${var.env}${var.servicebus_name_1}"
  servicebus_sku        = "Standard"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_1
  max_delivery_count    = 1
}

module "servicebus_2" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = "${var.env}${var.servicebus_name_2}"
  servicebus_sku        = "Standard"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_2
  max_delivery_count    = 1
}

module "servicebus_3" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = "${var.env}${var.servicebus_name_3}"
  servicebus_sku        = "Standard"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_3
  max_delivery_count    = 1
}

module "aci_1" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/aci"
  resource_group_name             = "${var.env}-bsai"
  location                        = "${var.region}"
  aci_name                        = "${var.env}-${var.aci_name_1}"
  aci_ip_type                     = var.aci_ip_type_aci_1
  #virtual_network_name            = azurerm_subnet.aci.id
  container_name                  = var.container_name_aci_1
  container_image                 = var.container_image_aci_1
  container_cpu                   = var.container_cpu_aci_1
  container_memory                = var.container_memory_aci_1
  container_port                  = var.container_port_aci_1
  docker_registry_server_url      = var.docker_registry_server_url_aci
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  aci_storage_account_name        = "${var.env}${var.storage_name}"
  aci_storage_share_name          = var.aci_storage_share_name
  aci_storage_mount_path          = var.aci_storage_mount_path
  aci_storage_key                 = var.aci_storage_key
}

module "aci_2" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/aci"
  resource_group_name             = "${var.env}-bsai"
  location                        = "${var.region}"
  aci_name                        = "${var.env}-${var.aci_name_2}"
  aci_ip_type                     = var.aci_ip_type_aci_2
  #virtual_network_name            = azurerm_subnet.aci.id
  container_name                  = var.container_name_aci_2
  container_image                 = var.container_image_aci_2
  container_cpu                   = var.container_cpu_aci_2
  container_memory                = var.container_memory_aci_2
  container_port                  = var.container_port_aci_2
  docker_registry_server_url      = var.docker_registry_server_url_aci
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  aci_storage_account_name        = "${var.env}${var.storage_name}"
  aci_storage_share_name          = var.aci_storage_share_name
  aci_storage_mount_path          = var.aci_storage_mount_path
  aci_storage_key                 = var.aci_storage_key
}

/* OUTOUT */
output "subnet_backend_id" {
  value = "${azurerm_subnet.backend.id}"
}

output "subnet_frontend_id" {
  value = "${azurerm_subnet.frontend.id}"
}

#output "subnet_application_id" {
#  value = "${azurerm_subnet.application.id}"
#}

output "subnet_aci_id" {
  value = "${azurerm_subnet.aci.id}"
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

output "app_service_plan_mldockers_plan" {
  value = "${azurerm_app_service_plan.mldockers_plan.id}"
}

output "app_service_plan_funpremium_plan" {
  value = "${azurerm_app_service_plan.funpremium_plan.id}"
}
