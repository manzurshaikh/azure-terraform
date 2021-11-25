resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.windows.id
  #app_service_plan_id = var.azurerm_app_service_plan

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

resource "azurerm_app_service_plan" "windows" {
  name                = azurerm_app_service.app_service.name
  location            = azurerm_app_service.app_service.location
  resource_group_name = azurerm_app_service.app_service.resource_group_name

  sku {
    tier = var.appservice_tier
    size = var.appservice_size
  }
}

### Scaling ###
#resource "azurerm_monitor_autoscale_setting" "example" {
#  name                = var.appservice_plan_name
#  resource_group_name = var.resource_group_name
#  location            = var.location
#  target_resource_id  = var.appservice_target_resource_id
#
#  profile {
#    name = "Default"
#
#    capacity {
#      default = 2
#      minimum = 2
#      maximum = 10
#    }
#
#    rule {
#      metric_trigger {
#        #metric_name        = "CpuPercentage"
#        #metric_name        = "MemoryPercentage"
#        metric_name        = "CpuPercentage"
#        metric_resource_id = azurerm_app_service_plan.windows.id
#        time_grain         = "PT1M"
#        statistic          = "Average"                              #make as variable
#        time_window        = "PT5M"
#        time_aggregation   = "Maximum"
#        operator           = "GreaterThan"
#        threshold          = 50                                  #make as variable
#        metric_namespace   = "microsoft.web/serverfarms"
#        #dimensions {
#        #  name     = "Instance"
#        #  operator = "Equals"
#        #  values   = ["ALL values"]
#        #}
#      }
#
#      scale_action {
#        direction = "Increase"
#        type      = "ChangeCount"
#        value     = "1"
#        cooldown  = "PT5M"
#      }
#    }
#
#    rule {
#      metric_trigger {
#        #metric_name        = "MemoryPercentage"
#        metric_name        = "CpuPercentage"
#        metric_resource_id = azurerm_app_service_plan.windows.id
#        time_grain         = "PT1M"
#        statistic          = "Average"                              #make as variable
#        time_window        = "PT5M"
#        time_aggregation   = "Minimum"
#        operator           = "LessThan"
#        threshold          = 2                                  #make as variable
#        metric_namespace   = "microsoft.web/serverfarms"
#      }
#
#      scale_action {
#        direction = "Decrease"
#        type      = "ChangeCount"
#        value     = "1"
#        cooldown  = "PT20M"
#      }
#    }
#  }
#}
#