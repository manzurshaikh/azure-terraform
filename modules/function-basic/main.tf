resource "azurerm_storage_account" "main" {
  name                     = var.function_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  access_tier             = "Cool"
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
  application_type    = "Node.JS"
}

resource "azurerm_app_service_plan" "main" {
  #depends_on = [azurerm_function_app.main]
  name                = var.fun_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "functionapp"

  sku {
    tier = var.tier_az_fun_plan
    size = var.size_az_fun_plan
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
    FUNCTIONS_WORKER_RUNTIME = "var.functions_worker_runtime"
    WEBSITE_NODE_DEFAULT_VERSION = "var.website_node_default_version"
    WEBSITE_RUN_FROM_PACKAGE = "var.website_run_from_package"
  }

  tags = {
    "terraform"        = "v0.13"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "swift_connection" {
  app_service_id = azurerm_function_app.main.id
  subnet_id      = var.virtual_network_name
}