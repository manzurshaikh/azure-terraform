##Note - removed nat gateway due to app service external IP is  not required at the moment
#resource "azurerm_public_ip" "natgw" {
#  name                = "nat-gateway-publicIP"
#  location            = var.region
#  resource_group_name = "${var.env}-bsai"
#  allocation_method   = "Static"
#  sku                 = "Standard"
#  zones               = ["1"]
#}
#
#resource "azurerm_public_ip_prefix" "example" {
#  name                = "nat-gateway-publicIPPrefix"
#  location            = var.region
#  resource_group_name = "${var.env}-bsai"
#  prefix_length       = 30
#  zones               = ["1"]
#}
#
#resource "azurerm_nat_gateway" "example" {
#  name                    = "nat-Gateway"
#  location                = var.region
#  resource_group_name     = "${var.env}-bsai"
#  public_ip_address_ids   = [azurerm_public_ip.natgw.id]
#  #public_ip_prefix_ids    = [azurerm_public_ip_prefix.natgw.id]
#  sku_name                = "Standard"
#  idle_timeout_in_minutes = 10
#  zones                   = ["1"]
#}
#
#
#resource "azurerm_subnet_nat_gateway_association" "example" {
#  subnet_id      = azurerm_subnet.generalpurpose.id
#  nat_gateway_id = azurerm_nat_gateway.example.id
#}