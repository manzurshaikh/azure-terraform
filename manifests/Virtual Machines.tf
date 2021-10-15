##Note - accept the market place license 
##az vm image list --location centralindia --offer openvpnas --publisher openvpn --all --help
##az vm image accept-terms --urn openvpn:openvpnas:access_server_byol:285.0.0

resource "azurerm_public_ip" "openvpn" {
  name                = "${var.env}-vpnip"
  resource_group_name = "${var.env}-bsai"
  location            = "${var.region}"
  allocation_method   = "Static"
}

resource "azurerm_subnet" "vmsubnet" {
  name                 = "vmsubnet"
  resource_group_name  = "${var.env}-bsai"
  address_prefixes     = ["10.0.8.0/24"]
  virtual_network_name = "${var.env}-${var.region}-bsai"
  #service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
}

module "virtual_machine_vpn" {
  source                     = "./../modules/virtual-machine"
  public_ip_name             = "${var.env}-vpnip"
  vm_network_interface       = "vpnserver"
  location                   = "${var.region}"
  resource_group_name        = "${var.env}-bsai"
  virtual_network_name       = "${var.env}-${var.region}-bsai"
  vm_subnet_id               = azurerm_subnet.vmsubnet.id
  vm_publicip_id             = azurerm_public_ip.openvpn.id
  vm_network_securitygroup   = "vpn_server"
  destination_port           = "22"
  vm_name                    = "vpnserver"
  vm_size                    = "Standard_B2s"
  image_publisher            = "Canonical"
  image_offer                = "UbuntuServer"
  image_sku                  = "18.04-LTS"
  image_version              = "latest"
  vm_disk_name               = "vpndisk"
  vm_managed_disk_type       = "Standard_LRS"
  vm_computer_name           = "vpnbsai"
  vm_admin_username          = "vpnbsai"
  vm_admin_password          = "Brainsight@vpn"
}


output "public_ip" {
  value = "${azurerm_public_ip.openvpn.id}"
}