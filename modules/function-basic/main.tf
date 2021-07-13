resource "azurerm_storage_account" "main" {
  name                     = var.function_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "terraform"        = "v0.13"
    "createdby"        = "az_function"
  }
}

resource "azurerm_storage_container" "example" {
    name = "${var.function_name}-release"
    storage_account_name = azurerm_storage_account.main.name
    container_access_type = "private"
}

resource "azurerm_application_insights" "main" {
  #depends_on = [azurerm_function_app.main]
  name                = var.function_name
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
}

resource "azurerm_app_service_plan" "main" {
  #depends_on = [azurerm_function_app.main]
  name                = var.function_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "functionapp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "main" {
  depends_on = [azurerm_storage_account.main]
  name                       = var.function_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  version                    = "~3"

  app_settings = {
    AppInsights_InstrumentationKey = azurerm_application_insights.main.instrumentation_key
    FUNCTIONS_WORKER_RUNTIME = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~14"
  #      FUNCTION_APP_EDIT_MODE = "readonly"
  #      HASH = "${base64encode(filesha256("${var.functionapp}"))}"
  #      WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.main.name}.blob.core.windows.net/${azurerm_storage_container.example.name}/${azurerm_storage_blob.example.name}${data.azurerm_storage_account_sas.sas.sas}"
  }

  tags = {
    "terraform"        = "v0.13"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azurerm_function_app.main.id
  subnet_id      = var.virtual_network_name
}
