resource "azurerm_storage_account" "main" {
  name                     = var.function_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  access_tier             = "Cool"
  account_replication_type = "LRS"
  #allow_blob_public_access  = true

  tags = {
    "terraform"        = "v0.13"
    "createdby"        = "az_function"
  }

  #network_rules {
  #  default_action             = "Allow"
  #  #ip_rules                  = var.stg_ip_rules
  #  virtual_network_subnet_ids = [var.virtual_network_name]
  #}
}

resource "azurerm_application_insights" "main" {
  name                = var.function_name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "Node.JS"
}

resource "azurerm_function_app" "main" {
  depends_on = [azurerm_storage_account.main]
  name                       = var.function_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  version                    = "~3"
  os_type                    = var.fun_os_type
  #identity {
  #  type = "SystemAssigned"
  #}

  app_settings = {
    #StorageContainerName             = var.test_storage_container_name
    AppInsights_InstrumentationKey   = azurerm_application_insights.main.instrumentation_key
    #AzureWebJobs.fileupload.Disabled = var.AzureWebJobs_fileupload_Disabled
    FUNCTIONS_WORKER_RUNTIME         = var.functions_worker_runtime
    WEBSITE_NODE_DEFAULT_VERSION     = var.website_node_default_version
    WEBSITE_RUN_FROM_PACKAGE         = var.website_run_from_package
  }

  tags = {
    "terraform"        = "v0.13"
  }
}

/* Enable in Premium Plan */
resource "azurerm_app_service_virtual_network_swift_connection" "swift_connection" {
  app_service_id = azurerm_function_app.main.id
  subnet_id      = var.virtual_network_name
}
