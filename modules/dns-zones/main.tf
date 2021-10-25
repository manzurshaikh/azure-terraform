resource "azurerm_dns_zone" "bsai-public" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
}
