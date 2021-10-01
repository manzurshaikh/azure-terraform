resource "azurerm_monitor_autoscale_setting" "example" {
  name                = var.appservice_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.appservice_target_resource_id

  profile {
    name = "Default"

    capacity {
      default = 2
      minimum = 2
      maximum = 10
    }

    rule {
      metric_trigger {
        #metric_name        = "CpuPercentage"
        #metric_name        = "MemoryPercentage"
        metric_name        = var.metric_name_scale_up
        metric_resource_id = var.appservice_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"                              #make as variable
        time_window        = "PT5M"
        time_aggregation   = "Maximum"
        operator           = "GreaterThan"
        threshold          = 50                                  #make as variable
        metric_namespace   = "microsoft.web/serverfarms"
        #dimensions {
        #  name     = "Instance"
        #  operator = "Equals"
        #  values   = ["ALL values"]
        #}
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        #metric_name        = "MemoryPercentage"
        metric_name        = var.metric_name_scale_down
        metric_resource_id = var.appservice_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"                              #make as variable
        time_window        = "PT5M"
        time_aggregation   = "Minimum"
        operator           = "LessThan"
        threshold          = 2                                  #make as variable
        metric_namespace   = "microsoft.web/serverfarms"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}
