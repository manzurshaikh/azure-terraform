resource "azurerm_storage_account" "storageaccount_name" {
  name                     = var.storageaccount_name
  resource_group_name      = var.resource_group_name
  location                 = var.storageaccount_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    "terraform"        = "v0.13"
  }
}

resource "azurerm_storage_share" "storageshr" {
  depends_on = [azurerm_storage_account.storageaccount_name]
  name                 = var.storageshare_name
  storage_account_name = var.storage_account_name
  quota                = var.storageshare_quota
}
