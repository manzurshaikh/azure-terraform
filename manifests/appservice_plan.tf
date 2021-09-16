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
}