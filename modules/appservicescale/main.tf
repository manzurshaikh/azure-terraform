resource "azurerm_monitor_autoscale_setting" "example" {
  name                = var.appservice_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.appservice_target_resource_id

  profile {
    name = "Default"

    capacity {
      default = 1
      minimum = 1
      maximum = 10
    }

    rule {
      metric_trigger {
        #metric_name        = "CpuPercentage"
        metric_name        = "MemoryPercentage"
        metric_resource_id = var.appservice_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT2M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 33
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
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "MemoryPercentage"
        metric_resource_id = var.appservice_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
        metric_namespace   = "microsoft.web/serverfarms"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }
  }
}
