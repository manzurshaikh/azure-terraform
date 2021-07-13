resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address

  tags = {
    "terraform"        = "v0.13"
  }
}

#resource "azurerm_subnet" "backend" {
#  depends_on = [azurerm_virtual_network.vnet]
#  name                 = var.subnet_name
#  virtual_network_name = var.vnet_name
#  resource_group_name  = var.resource_group_name
#  address_prefixes     = var.subnet_address
#
#  delegation {
#    name = "delegation"
#
#    service_delegation {
#      name    = "Microsoft.Web/serverFarms"
#      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#    }
#  }
#}

#resource "azurerm_subnet" "frontend" {
#  depends_on = [azurerm_virtual_network.vnet]
#  name                 = "frontend"
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  resource_group_name  = var.resource_group_name
#  address_prefixes     = ["10.0.1.0/24"]
#}

#resource "azurerm_subnet" "database" {
#  depends_on = [azurerm_virtual_network.vnet]
#  name                 = "database"
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  resource_group_name  = var.resource_group_name
#  address_prefixes     = ["10.0.2.0/24"]
#}
