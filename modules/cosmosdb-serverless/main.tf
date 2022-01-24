resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                                  = var.cosmodb_account_name
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  offer_type                            = "Standard"
  kind                                  = "MongoDB" 
  mongo_server_version                  = "4.0"
  enable_automatic_failover             = var.enable_automatic_failover
  network_acl_bypass_for_azure_services = true
  is_virtual_network_filter_enabled     = var.is_virtual_network_filter_enabled

  //set ip_range_filter to allow azure services (0.0.0.0) and azure portal.
  ip_range_filter = var.ip_range_filter

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "EnableServerless"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "Session"
  }

  geo_location {
    location          = var.failover_location_secondary
    failover_priority = var.failover_priority_secondary 
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  dynamic "virtual_network_rule" {
    for_each = var.vnet_subnet_id
    content {
      id   = virtual_network_rule.value.id
      ignore_missing_vnet_service_endpoint = true
    }
  }

  tags = {
    "terraform"        = "v0.13"
  }
}
