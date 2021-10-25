resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.azurerm_app_service_plan

    site_config {
    use_32_bit_worker_process = true
    dotnet_framework_version = "v4.0"
  }

  #  source_control {
  #  branch             = ""
  #  manual_integration = ""
  #  repo_url           = ""
  #  rollback_enabled   = ""
  #  use_mercurial      = ""
  #}

  tags = {
    "terraform"        = "v0.13"
  }

  #storage_account {
  #    access_key   = var.app_storage_key
  #    account_name = var.app_storage_account_name
  #    mount_path   = var.app_storage_mount_path
  #    name         = var.app_storage_name_prefix
  #    share_name   = var.app_storage_share_name
  #    type         = "AzureFiles"
  #}
}
