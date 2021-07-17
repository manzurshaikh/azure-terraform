resource "azurerm_app_service_plan" "appservice_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    capacity = var.capacity_az_appservice_plan
    tier = var.tier_az_appservice_plan
    size = var.size_az_appservice_plan
  }
}

resource "azurerm_app_service" "app_service" {
  depends_on = [azurerm_app_service_plan.appservice_plan]
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.appservice_plan.id

    site_config {
    app_command_line = ""
    linux_fx_version = var.linux_fx_version
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = var.docker_registry_server_url
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.docker_registry_server_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.docker_registry_server_password
    "DOCKER_CUSTOM_IMAGE_NAME"            = var.docker_custom_image_name
  }

  tags = {
    "terraform"        = "v0.13"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service" {
  app_service_id = azurerm_app_service.app_service.id
  subnet_id      = var.virtual_network_name
}