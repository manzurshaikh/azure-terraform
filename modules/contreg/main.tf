resource "azurerm_container_registry" "container_registery" {
  name                = var.contreg_name
  resource_group_name = var.resource_group_name
  location            = var.contreg_location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    "terraform"        = "v0.13"
  }
}
