##Note - accept the market place license 
##az vm image list --location centralindia --offer openvpnas --publisher openvpn --all --help
##az vm image accept-terms --urn openvpn:openvpnas:access_server_byol:285.0.0
##az vm image list --offer Windows-10 --publisher MicrosoftWindowsDesktop --all --output table
##az vm image accept-terms --urn MicrosoftWindowsDesktop:Windows-10:19h2-ent-g2:18363.1854.2110060539

resource "azurerm_public_ip" "openvpn" {
  name                = "${var.env}-vpnip"
  resource_group_name = "${var.env}-bsai"
  location            = "${var.region}"
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "medidataserver" {
  name                = "${var.env}-medidataserver"
  resource_group_name = "${var.env}-bsai"
  location            = "${var.region}"
  allocation_method   = "Static"
}

#resource "azurerm_public_ip" "dassaultserver" {
#  name                = "${var.env}-dassaultserver"
#  resource_group_name = "${var.env}-bsai"
#  location            = "${var.region}"
#  allocation_method   = "Static"
#}

resource "azurerm_subnet" "vmsubnet" {
  name                 = "vmsubnet"
  resource_group_name  = "${var.env}-bsai"
  address_prefixes     = ["10.0.8.0/24"]
  virtual_network_name = "${var.env}-${var.region}-bsai"
  service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
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

module "virtual_machine_medidata" {
  source                     = "./../modules/virtual-machine-windows"
  public_ip_name             = "${var.env}-medidataip"
  vm_network_interface       = "medidataserver"
  location                   = "${var.region}"
  resource_group_name        = "${var.env}-bsai"
  virtual_network_name       = "${var.env}-${var.region}-bsai"
  vm_subnet_id               = azurerm_subnet.vmsubnet.id
  vm_publicip_id             = azurerm_public_ip.medidataserver.id
  vm_network_securitygroup   = "medidata_server"
  vm_name                    = "medidataserver"
  vm_size                    = "Standard_DS1_v2"
  image_publisher            = "MicrosoftWindowsServer"
  image_offer                = "WindowsServer"
  image_sku                  = "2019-datacenter-gensecond"
  image_version              = "latest"
  vm_disk_name               = "medidatasrvdisk"
  vm_managed_disk_type       = "Standard_LRS"
  vm_computer_name           = "medidataserver"
  vm_admin_username          = "medidata"
  vm_admin_password          = "Brainsight@2021"
}

#module "virtual_dassaultsystem" {
#  source                     = "./../modules/virtual-machine-windows"
#  public_ip_name             = "${var.env}-dassaultsystem"
#  vm_network_interface       = "dassaultsystem"
#  location                   = "${var.region}"
#  resource_group_name        = "${var.env}-bsai"
#  virtual_network_name       = "${var.env}-${var.region}-bsai"
#  vm_subnet_id               = azurerm_subnet.vmsubnet.id
#  vm_publicip_id             = azurerm_public_ip.dassaultserver.id
#  vm_network_securitygroup   = "dassaultserver"
#  vm_name                    = "dassaultserver"
#  vm_size                    = "Standard_NV4as_v4"
#  image_publisher            = "MicrosoftWindowsDesktop"
#  image_offer                = "Windows-10"
#  image_sku                  = "19h2-entn-g2"
#  image_version              = "latest"
#  vm_disk_name               = "dassaultvdisk"
#  vm_managed_disk_type       = "Standard_LRS"
#  vm_computer_name           = "dassaultsystem"
#  vm_admin_username          = "dassaultsystem"
#  vm_admin_password          = "Brainsight@2021"
#}


output "public_ip" {
  value = "${azurerm_public_ip.openvpn.id}"
}

output "public_ip_medidataserver" {
  value = "${azurerm_public_ip.medidataserver.id}"
}

#output "public_ip_dassaultserver" {
#  value = "${azurerm_public_ip.dassaultserver.id}"
#}

output "subnet_vmsubnet_id" {
  value = "${azurerm_subnet.vmsubnet.id}"
}