resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                      = var.cosmodb_account_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  offer_type                = "Standard"
  //kind                      = "GlobalDocumentDB"
  kind                      = "MongoDB" 
  mongo_server_version      = "4.0"
  enable_automatic_failover = var.enable_automatic_failover
  network_acl_bypass_for_azure_services = true

  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled

  //set ip_range_filter to allow azure services (0.0.0.0) and azure portal.
  ip_range_filter = var.ip_range_filter

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
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

  virtual_network_rule  {
    id                = var.vnet_subnet_id
    ignore_missing_vnet_service_endpoint = true
  }

  #backup {
  #type                = "Periodic"
  #interval_in_minutes = 60 * 24
  #retention_in_hours  = 7 * 60
  # }

  tags = {
    "terraform"        = "v0.13"
  }
}

#resource "azurerm_cosmosdb_mongo_database" "mongo" {
#  depends_on = [azurerm_cosmosdb_account.cosmosdb]
#  name                = var.cosmosdb_name
#  resource_group_name = var.resource_group_name
#  account_name        = var.cosmodb_account_name
#  #throughput          = "autoscale"
#}

#resource "azurerm_cosmosdb_mongo_collection" "table" {
#  depends_on = [azurerm_cosmosdb_mongo_database.mongo]
#  name                = "bsai-cosmos-mongo-db"
#  resource_group_name = var.resource_group_name
#  account_name        = var.cosmodb_account_name
#  database_name       = "bsaitest"
#
#  default_ttl_seconds = "777"
#  #shard_key           = "uniqueKey"
#  #throughput          = "autoscale"
#}