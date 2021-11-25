resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.linux.id
  #app_service_plan_id = var.azurerm_app_service_plan

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
    "DOCKER_ENABLE_CI"                    = var.docker_enable_ci
  }

  tags = {
    "terraform"        = "v0.13"
  }

  storage_account {
      access_key   = var.app_storage_key
      account_name = var.app_storage_account_name
      mount_path   = var.app_storage_mount_path
      name         = var.app_storage_name_prefix
      share_name   = var.app_storage_share_name
      type         = "AzureFiles"
  }

  #storage_account {
  #    access_key   = var.app_storage_key2
  #    account_name = "devfilesharestg"
  #    mount_path   = "/training"
  #    name         = "dev-storage"
  #    share_name   = "training"
  #    type         = "AzureFiles"
  #}
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service" {
  app_service_id = azurerm_app_service.app_service.id
  subnet_id      = var.virtual_network_name
}

resource "azurerm_app_service_plan" "linux" {
  name                = azurerm_app_service.app_service.name
  location            = azurerm_app_service.app_service.location
  resource_group_name = azurerm_app_service.app_service.resource_group_name

  sku {
    tier = var.appservice_tier
    size = var.appservice_size
  }
}