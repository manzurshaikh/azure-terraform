provider "azurerm" {
  version = "2.80.0"
  features {}
}

/* Azure Public-DNS */
module "dns" {
  depends_on = [module.resource_group]
  source                  = "./../modules/dns-zones"
  resource_group_name     = "${var.env}-bsai"
  domain_name             = "brainsightai.com"
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

resource "azurerm_subnet" "internalml" {
  depends_on                                    = [module.vnet]
  name                                          = "internalml"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.6.0/24"]
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

resource "azurerm_subnet" "internalml2" {
  depends_on                                    = [module.vnet]
  name                                          = "internalml2"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.7.0/24"]
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

resource "azurerm_subnet" "internalml3" {
  depends_on                                    = [module.vnet]
  name                                          = "internalml3"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.12.0/24"]
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

resource "azurerm_subnet" "generalpurpose" {
  depends_on                                    = [module.vnet]
  name                                          = "generalpurpose"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.11.0/24"]
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

resource "azurerm_subnet" "voxelboxprod" {
  depends_on                                    = [module.vnet]
  name                                          = "voxelboxprod"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.13.0/24"]
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

resource "azurerm_subnet" "subnet01" {
  depends_on                                    = [module.vnet]
  name                                          = "subnet01"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.14.0/24"]
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

resource "azurerm_subnet" "subnet02" {
  depends_on                                    = [module.vnet]
  name                                          = "subnet02"
  virtual_network_name                          = "${var.env}-${var.region}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["10.0.15.0/24"]
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

#resource "azurerm_subnet" "generalpurpose2" {
#  depends_on                                    = [module.vnet]
#  name                                          = "generalpurpose2"
#  virtual_network_name                          = "${var.env}-${var.region}-bsai"
#  resource_group_name                           = "${var.env}-bsai"
#  address_prefixes                              = ["10.0.14.0/24"]
#  enforce_private_link_service_network_policies = false
#  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
#  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform
#
#  delegation {
#    name = "delegation"
#
#    service_delegation {
#      name    = "Microsoft.Web/serverFarms"
#      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#    }
#  }
#}

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

module "vnet-dev" {
  depends_on = [module.resource_group]
  source                  = "./../modules/networking"
  resource_group_name     = "${var.env}-bsai"
  vnet_name               = "${var.env}-bsai"
  location                = "${var.region}"
  vnet_address            = ["172.16.0.0/16"]  #Note [10.0.0.0/8] for class A & [172.16.0.0/16] for class B
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
  storage_account_kind      = "StorageV2"
  stg_account_tier          = var.stg_account_tier_bsai
  stg_access_tier           = var.stg_access_tier
  storageshare_quota        = var.storageshare_quota_bsai
  stg_ip_rules              = var.stg_ip_rules_bsai
  default_action_rule       = var.default_action_rule
  #vnet_subnet_id            = azurerm_subnet.backend.id
  vnet_subnet_id            = [azurerm_subnet.backend.id, azurerm_subnet.application.id, azurerm_subnet.frontend.id, azurerm_subnet.internal.id, azurerm_subnet.internalml.id, azurerm_subnet.internalml2.id]
  allow_blob_public_access  = var.allow_blob_public_access_bsai
  enable_https_traffic_only = var.enable_https_traffic_only_bsai
  nfsv3_enabled             = var.nfsv3_enabled_bsai
  account_replication_type  = var.account_replication_type_bsai
  storage_min_tls_version   = "TLS1_0"
}

module "storage_bsai_1" {
  depends_on = [module.resource_group]
  source   = "./../modules/storage"
  storageaccount_name       = "${var.env}${var.storage_name1}"
  resource_group_name       = "${var.env}-bsai"
  storageaccount_location   = "${var.region}"
  storageshare_name         = "${var.env}${var.storage_name1}"
  storage_account_name      = "${var.env}${var.storage_name1}"
  storage_account_kind      = "FileStorage"
  stg_account_tier          = var.stg_account_tier_bsai1
  stg_access_tier           = var.stg_access_tier1
  storageshare_quota        = var.storageshare_quota_bsai1
  stg_ip_rules              = var.stg_ip_rules_bsai1
  default_action_rule       = var.default_action_rule1
  #vnet_subnet_id            = azurerm_subnet.backend.id
  vnet_subnet_id            = [azurerm_subnet.backend.id, azurerm_subnet.application.id, azurerm_subnet.frontend.id, azurerm_subnet.internal.id, azurerm_subnet.internalml.id, azurerm_subnet.internalml2.id, azurerm_subnet.vmsubnet.id, azurerm_subnet.generalpurpose.id, azurerm_subnet.internalml3.id, azurerm_subnet.akssubnet.id, azurerm_subnet.voxelboxprod.id, azurerm_subnet.subnet01.id, azurerm_subnet.subnet02.id]
  allow_blob_public_access  = var.allow_blob_public_access_bsai1
  enable_https_traffic_only = var.enable_https_traffic_only_bsai1
  nfsv3_enabled             = var.nfsv3_enabled_bsai1
  account_replication_type  = var.account_replication_type_bsai1
  storage_min_tls_version   = "TLS1_2"
}

module "dev-storage_bsai" {
  depends_on = [module.resource_group]
  source   = "./../modules/storage"
  storageaccount_name       = "${var.env}databs"
  resource_group_name       = "${var.env}-bsai"
  storageaccount_location   = "${var.region}"
  storageshare_name         = "${var.env}${var.storage_name2}"
  storage_account_name      = "${var.env}${var.storage_name2}"
  storage_account_kind      = "FileStorage"
  stg_account_tier          = var.stg_account_tier_bsai1
  stg_access_tier           = var.stg_access_tier1
  storageshare_quota        = var.storageshare_quota_bsai1
  stg_ip_rules              = var.stg_ip_rules_bsai3
  default_action_rule       = var.default_action_rule1
  #vnet_subnet_id            = azurerm_subnet.backend.id
  vnet_subnet_id            = [azurerm_subnet.dev-subnet-01.id, azurerm_subnet.dev-subnet-03.id]
  allow_blob_public_access  = var.allow_blob_public_access_bsai1
  enable_https_traffic_only = var.enable_https_traffic_only_bsai1
  nfsv3_enabled             = var.nfsv3_enabled_bsai1
  account_replication_type  = var.account_replication_type_bsai1
  storage_min_tls_version   = "TLS1_2"
}

module "container_registery" {
  depends_on               = [module.resource_group]
  source                   = "./../modules/contreg"
  contreg_name             = "${var.env}bsai"
  resource_group_name      = "${var.env}-bsai"
  contreg_location         = "${var.region}"  
}


module "container_registery_ge" {
  depends_on               = [module.resource_group]
  source                   = "./../modules/contreg"
  contreg_name             = "${var.env}gerepo"
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
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.mldockers_plan.id
}


module "app_service2" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_plus.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service2}"
  virtual_network_name            = azurerm_subnet.internalml3.id
  #virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service2
  linux_fx_version                = var.linux_fx_version_app_service2
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_plus.id
}

module "app_service3" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.bsaigeneralpurpose.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.app_service3}"
  virtual_network_name            = azurerm_subnet.generalpurpose.id
  #virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service3
  linux_fx_version                = var.linux_fx_version_app_service3
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  #app_storage_account_name        = "${var.env}${var.storage_name}"
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.bsaigeneralpurpose.id
}

module "app_service4" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.fileprocess_plan.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service4}"
  #virtual_network_name            = azurerm_subnet.internal.id
  virtual_network_name            = azurerm_subnet.internalml2.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service4
  linux_fx_version                = var.linux_fx_version_app_service4
  docker_enable_ci                = "true"
  #health_check_path               = "/report/test1"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.fileprocess_plan.id
}

module "app_service5" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_smri.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service5}"
  virtual_network_name            = azurerm_subnet.internalml.id
  #virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service5
  linux_fx_version                = var.linux_fx_version_app_service5
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.fileprocess_plan.id
}

module "app_service6" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_dti.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service6}"
  #virtual_network_name            = azurerm_subnet.internalml2.id
  virtual_network_name            = azurerm_subnet.internal.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service6
  linux_fx_version                = var.linux_fx_version_app_service6
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service7" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice-win"
  azurerm_app_service_plan        = azurerm_app_service_plan.windows.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.app_service7}"
}

module "app_service8" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_dti.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service8}"
  #virtual_network_name            = azurerm_subnet.internalml2.id
  virtual_network_name            = azurerm_subnet.internal.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service8
  linux_fx_version                = var.linux_fx_version_app_service8
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service9" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_dti.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service9}"
  #virtual_network_name            = azurerm_subnet.internalml2.id
  virtual_network_name            = azurerm_subnet.internal.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service9
  linux_fx_version                = var.linux_fx_version_app_service9
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service10" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.bsaigeneralpurpose.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = var.app_service10
  #virtual_network_name            = azurerm_subnet.internalml2.id
  virtual_network_name            = azurerm_subnet.generalpurpose.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service10
  linux_fx_version                = var.linux_fx_version_app_service10
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service11" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.bsaigeneralpurpose.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service11}"
  #virtual_network_name            = azurerm_subnet.internalml2.id
  virtual_network_name            = azurerm_subnet.generalpurpose.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service11
  linux_fx_version                = var.linux_fx_version_app_service11
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service12" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_plus.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service12}"
  virtual_network_name            = azurerm_subnet.internalml3.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service12
  linux_fx_version                = var.linux_fx_version_app_service12
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service13" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.uat_voxelbox.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = var.app_service13
  virtual_network_name            = azurerm_subnet.subnet02.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service13
  linux_fx_version                = var.linux_fx_version_app_service13
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_dti.id
}

module "app_service14" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.voxelbox_prod.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = "${var.env}-${var.app_service14}"
  virtual_network_name            = azurerm_subnet.voxelboxprod.id
  #virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service14
  linux_fx_version                = var.linux_fx_version_app_service14
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_plus.id
}

module "app_service15" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.uat_voxelboxfc.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = var.app_service15
  virtual_network_name            = azurerm_subnet.subnet01.id
  #virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service15
  linux_fx_version                = var.linux_fx_version_app_service15
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_plus.id
}

module "app_service16" {
  depends_on                      = [module.resource_group]
  source                          = "./../modules/appservice"
  azurerm_app_service_plan        = azurerm_app_service_plan.uat_voxelboxfc.id
  location                        = "${var.region}"
  resource_group_name             = "${var.env}-bsai"
  app_service_name                = var.app_service16
  virtual_network_name            = azurerm_subnet.subnet01.id
  #virtual_network_name            = azurerm_subnet.application.id
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  docker_custom_image_name        = var.docker_custom_image_name_app_service16
  linux_fx_version                = var.linux_fx_version_app_service16
  docker_enable_ci                = "true"
  #health_check_path               = "/"
  app_storage_key                 = var.app_storage_key_1
  app_storage_account_name        = "${var.env}${var.storage_name1}"
  app_storage_mount_path          = "/training"
  app_storage_name_prefix         = "dev-storage"
  app_storage_share_name          = "training"
  #appservice_target_resource_id   = azurerm_app_service_plan.voxelbox_plus.id
}

#azure_functions
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

module "azure_function7" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name7}"
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

module "azure_function8" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = "${var.env}${var.function_name8}"
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

module "azure_function9" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = var.function_name9
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

module "azure_function10" {
  depends_on                       = [module.resource_group]
  source                           = "./../modules/function-basic"
  function_name                    = var.function_name10
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
  vnet_subnet_id               = [{id   = azurerm_subnet.backend.id}, {id = azurerm_subnet.application.id}, {id = azurerm_subnet.frontend.id}, {id = azurerm_subnet.internal.id}, {id = azurerm_subnet.akssubnet.id}, {id = azurerm_subnet.vmsubnet.id}, {id = azurerm_subnet.internalml2.id}, {id = azurerm_subnet.internalml3.id}, {id = azurerm_subnet.generalpurpose.id}, {id = azurerm_subnet.voxelboxprod.id}, {id = azurerm_subnet.subnet01.id}, {id = azurerm_subnet.subnet02.id}]
}

module "cosmosdb_1_serverless" {
  depends_on                   = [module.vnet]
  source                       = "./../modules/cosmosdb-serverless"
  cosmodb_account_name         = "medidata-tf"
  resource_group_name          = "${var.env}-bsai"
  ip_range_filter              = var.ip_range_filter
  location                     = "${var.region}"
  cosmosdb_name                = "medidata-tf"
  enable_automatic_failover    = var.enable_automatic_failover
  failover_location_secondary  = var.failover_location_secondary
  failover_priority_secondary  = var.failover_priority_secondary
  vnet_subnet_id               = [{id   = azurerm_subnet.backend.id}, {id = azurerm_subnet.application.id}, {id = azurerm_subnet.frontend.id}, {id = azurerm_subnet.internal.id}, {id = azurerm_subnet.akssubnet.id}, {id = azurerm_subnet.vmsubnet.id}, {id = azurerm_subnet.internalml2.id}, {id = azurerm_subnet.internalml3.id}, {id = azurerm_subnet.generalpurpose.id}, {id = azurerm_subnet.subnet01.id}, {id = azurerm_subnet.subnet02.id}]
}

module "dev_cosmosdb_serverless" {
  depends_on                   = [module.vnet]
  source                       = "./../modules/cosmosdb-serverless"
  cosmodb_account_name         = "${var.env}-db"
  resource_group_name          = "${var.env}-bsai"
  ip_range_filter              = var.ip_range_filter
  location                     = "${var.region}"
  cosmosdb_name                = "${var.env}-dev"
  enable_automatic_failover    = var.enable_automatic_failover
  failover_location_secondary  = var.failover_location_secondary
  failover_priority_secondary  = var.failover_priority_secondary
  vnet_subnet_id               = [{id   = azurerm_subnet.dev-subnet-01.id}, {id = azurerm_subnet.dev-subnet-02.id}, {id = azurerm_subnet.dev-subnet-03.id}, {id = azurerm_subnet.dev-subnet-03-01.id}]
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

module "servicebus_4" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = var.servicebus_name_4
  servicebus_sku        = "Standard"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_4
  max_delivery_count    = 1
}

module "servicebus_5" {
  depends_on            = [module.resource_group]
  source                = "./../modules/service-bus"
  servicebus_name       = var.servicebus_name_5
  servicebus_sku        = "Standard"
  resource_group_name   = "${var.env}-bsai"
  location              = "${var.region}"
  servicebus_queue_name = var.servicebus_queue_name_5
  max_delivery_count    = 1
}

#module "aci_1" {
#  depends_on                      = [module.resource_group]
#  source                          = "./../modules/aci"
#  resource_group_name             = "${var.env}-bsai"
#  location                        = "${var.region}"
#  aci_name                        = "${var.env}-${var.aci_name_1}"
#  aci_ip_type                     = var.aci_ip_type_aci_1
#  #virtual_network_name            = azurerm_subnet.aci.id
#  container_name                  = var.container_name_aci_1
#  container_image                 = var.container_image_aci_1
#  container_cpu                   = var.container_cpu_aci_1
#  container_memory                = var.container_memory_aci_1
#  container_port                  = var.container_port_aci_1
#  docker_registry_server_url      = var.docker_registry_server_url_aci
#  docker_registry_server_username = var.docker_registry_server_username
#  docker_registry_server_password = var.docker_registry_server_password
#  aci_storage_account_name        = "${var.env}${var.storage_name}"
#  aci_storage_share_name          = var.aci_storage_share_name
#  aci_storage_mount_path          = var.aci_storage_mount_path
#  aci_storage_key                 = var.aci_storage_key
#}
#
#module "aci_2" {
#  depends_on                      = [module.resource_group]
#  source                          = "./../modules/aci"
#  resource_group_name             = "${var.env}-bsai"
#  location                        = "${var.region}"
#  aci_name                        = "${var.env}-${var.aci_name_2}"
#  aci_ip_type                     = var.aci_ip_type_aci_2
#  #virtual_network_name            = azurerm_subnet.aci.id
#  container_name                  = var.container_name_aci_2
#  container_image                 = var.container_image_aci_2
#  container_cpu                   = var.container_cpu_aci_2
#  container_memory                = var.container_memory_aci_2
#  container_port                  = var.container_port_aci_2
#  docker_registry_server_url      = var.docker_registry_server_url_aci
#  docker_registry_server_username = var.docker_registry_server_username
#  docker_registry_server_password = var.docker_registry_server_password
#  aci_storage_account_name        = "${var.env}${var.storage_name}"
#  aci_storage_share_name          = var.aci_storage_share_name
#  aci_storage_mount_path          = var.aci_storage_mount_path
#  aci_storage_key                 = var.aci_storage_key
#}

/* OUTOUT */
output "subnet_backend_id" {
  value = "${azurerm_subnet.backend.id}"
}

output "subnet_frontend_id" {
  value = "${azurerm_subnet.frontend.id}"
}

output "subnet_application_id" {
  value = "${azurerm_subnet.application.id}"
}

output "subnet_aci_id" {
  value = "${azurerm_subnet.aci.id}"
}

output "subnet_internalml_id" {
  value = "${azurerm_subnet.internalml.id}"
}

output "subnet_internalml2_id" {
  value = "${azurerm_subnet.internalml2.id}"
}

output "subnet_generalpurpose_id" {
  value = "${azurerm_subnet.generalpurpose.id}"
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

output "app_service_plan_voxelbox_smri" {
  value = "${azurerm_app_service_plan.voxelbox_smri.id}"
}

output "app_service_plan_voxelbox_dti" {
  value = "${azurerm_app_service_plan.voxelbox_dti.id}"
}