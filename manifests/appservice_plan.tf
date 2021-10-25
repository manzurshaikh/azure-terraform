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
  metric_name_scale_up          = "CpuPercentage"
  metric_name_scale_down        = "CpuPercentage"
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
    tier     = var.tier_az_appservice_fileprocess_plan
    size     = var.size_az_appservice_fileprocess_plan
  }
}

/* Azure Autoscaling for App Service Plan */
module "appservice_autoscaling_fileprocessing" {
  source                        = "./../modules/appservicescale"
  appservice_plan_name          = "fileprocess_plan_scaling_rule"
  resource_group_name           = "${var.env}-bsai"
  location                      = var.region
  appservice_target_resource_id = azurerm_app_service_plan.fileprocess_plan.id
  metric_name_scale_up          = "CpuPercentage"
  metric_name_scale_down        = "CpuPercentage"
}

/* App_Service plan for Azure App Service ML DOCKER_SMRI */
resource "azurerm_app_service_plan" "voxelbox_dti" {
  name                         = "${var.env}_voxelbox_dti"
  location                     = var.region
  resource_group_name          = "${var.env}-bsai"
  kind                         = "Linux"
  reserved                     = true
  #maximum_elastic_worker_count = "10"
  per_site_scaling             = false

  sku {
  #  capacity = var.capacity_az_appservice_docker_plan
    tier     = var.tier_az_appservice_voxelbox_dti
    size     = var.size_az_appservice_voxelbox_dti
  }
}

/* Azure Autoscaling for App Service Plan */
module "appservice_autoscaling_voxelbox_dti" {
  source                        = "./../modules/appservicescale"
  appservice_plan_name          = "voxelbox_dti_scaling_rule"
  resource_group_name           = "${var.env}-bsai"
  location                      = var.region
  appservice_target_resource_id = azurerm_app_service_plan.voxelbox_dti.id
  metric_name_scale_up          = "CpuPercentage"
  metric_name_scale_down        = "CpuPercentage"
}

/* App_Service plan for Azure App Service ML DOCKER_SMRI */
resource "azurerm_app_service_plan" "voxelbox_smri" {
  name                         = "${var.env}_voxelbox_smri"
  location                     = var.region
  resource_group_name          = "${var.env}-bsai"
  kind                         = "Linux"
  reserved                     = true
  #maximum_elastic_worker_count = "10"
  per_site_scaling             = false

  sku {
  #  capacity = var.capacity_az_appservice_docker_plan
    tier     = var.tier_az_appservice_voxelbox_smri
    size     = var.size_az_appservice_voxelbox_smri
  }
}

/* Azure Autoscaling for App Service Plan voxelbox_smri */
module "appservice_autoscaling_voxelbox_smri" {
  source                        = "./../modules/appservicescale"
  appservice_plan_name          = "voxelbox_smri_scaling_rule"
  resource_group_name           = "${var.env}-bsai"
  location                      = var.region
  appservice_target_resource_id = azurerm_app_service_plan.voxelbox_smri.id
  metric_name_scale_up          = "CpuPercentage"       #MemoryPercentage
  metric_name_scale_down        = "CpuPercentage"
}

/* App_Service plan for Azure App Service ML BsaiGeneralPurpose */
resource "azurerm_app_service_plan" "bsaigeneralpurpose" {
  name                         = "${var.env}_bsaigeneralpurpose"
  location                     = var.region
  resource_group_name          = "${var.env}-bsai"
  kind                         = "Linux"
  reserved                     = true
  #maximum_elastic_worker_count = "10"
  per_site_scaling             = false

  sku {
  #  capacity = var.capacity_az_appservice_docker_plan
    tier     = var.tier_az_appservice_bsaigeneralpurpose
    size     = var.size_az_appservice_bsaigeneralpurpose
  }
}

/* Azure Autoscaling for App Service Plan for BSAIGeneralPurpose */
module "appservice_autoscaling_brainsightuploader" {
  source                        = "./../modules/appservicescale"
  appservice_plan_name          = "bsaigeneralpurpose_scaling_rule"
  resource_group_name           = "${var.env}-bsai"
  location                      = var.region
  appservice_target_resource_id = azurerm_app_service_plan.bsaigeneralpurpose.id
  metric_name_scale_up          = "CpuPercentage"       #MemoryPercentage
  metric_name_scale_down        = "CpuPercentage"
}


/* App_Service plan for Azure App Service windows */
resource "azurerm_app_service_plan" "windows" {
  name                         = "${var.env}_windows"
  location                     = var.region
  resource_group_name          = "${var.env}-bsai"
  kind                         = "Linux"
  reserved                     = true
  #maximum_elastic_worker_count = "10"
  per_site_scaling             = false

  sku {
  #  capacity = var.capacity_az_appservice_docker_plan
    tier     = var.tier_az_appservice_windows
    size     = var.size_az_appservice_windows
  }
}
