#resource "azurerm_container_group" "container_instance" {
#  name                = "${var.env}-${var.continst}"
#  location            = "${var.region}"
#  resource_group_name = "${var.resource_group_name}"
#  ip_address_type     = "Private"
#  network_profile_id  = azurerm_network_profile.vnet_profile.id
#  os_type             = "Linux"
#  restart_policy      = "Never"
#
#  container {
#    name   = "${var.container_name}"
#    image  = "${var.container_image}"
#    cpu    = "${var.container_cpu}"
#    memory = "${var.container_memory}"
#
#    ports {
#      port     = "${var.container_port}"
#      protocol = "${var.container_protocol}"
#    }
#  }
#
#  tags     = {
#    environment = "${var.container_tags}"
#  }
#}
