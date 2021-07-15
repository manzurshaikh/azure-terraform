resource "azurerm_storage_account" "storageaccount_name" {
  name                      = var.storageaccount_name
  resource_group_name       = var.resource_group_name
  location                  = var.storageaccount_location
  account_tier              = var.stg_account_tier
  access_tier               = var.stg_access_tier 
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only
  nfsv3_enabled             = var.nfsv3_enabled
  allow_blob_public_access  = var.allow_blob_public_access 

  tags = {
    "terraform"        = "v0.13"
  }

  network_rules {
    default_action             = var.default_action_rule
    ip_rules                   = var.stg_ip_rules
    virtual_network_subnet_ids = [var.vnet_subnet_id]
  }

}

/* FileShare_Folder_Not_Required */
#resource "azurerm_storage_share" "storageshr" {
#  depends_on = [azurerm_storage_account.storageaccount_name]
#  name                 = var.storageshare_name
#  storage_account_name = var.storage_account_name
#  quota                = var.storageshare_quota
#}
