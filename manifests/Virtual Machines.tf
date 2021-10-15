#resource "azurerm_subnet" "vmsubnet" {
#  name                 = "vmsubnet"
#  resource_group_name  = "${var.env}-bsai"
#  address_prefixes     = ["10.0.8.0/24"]
#  virtual_network_name = "${var.env}-${var.region}-bsai"
#  #service_endpoints    = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
#}
#
#resource "azurerm_public_ip" "pip" {
#  name                = "${var.env}-vpnip"
#  resource_group_name = "${var.env}-bsai"
#  location            = "${var.region}"
#  allocation_method   = "Static"
#}
#
#resource "azurerm_network_interface" "main" {
#  name                = "${var.env}-vpnnic"
#  location            = "${var.region}"
#  resource_group_name = "${var.env}-bsai"
#
#  ip_configuration {
#    name                          = "vpnconfiguration"
#    subnet_id                     = azurerm_subnet.vmsubnet.id
#    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id          = azurerm_public_ip.pip.id
#  }
#}
#
#resource "azurerm_network_security_group" "vpnserver" {
#  name                = "vpn_server"
#  location            = "${var.region}"
#  resource_group_name = "${var.env}-bsai"
#  security_rule {
#    access                     = "Allow"
#    direction                  = "Inbound"
#    name                       = "tls"
#    priority                   = 100
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    source_address_prefix      = "*"
#    destination_port_range     = "22"
#    destination_address_prefix = azurerm_network_interface.main.private_ip_address
#  }
#}
#
#resource "azurerm_virtual_machine" "main" {
#  name                  = "${var.env}-vpn"
#  location              = "${var.region}"
#  resource_group_name   = "${var.env}-bsai"
#  network_interface_ids = [azurerm_network_interface.main.id]
#  vm_size               = "Standard_B2s"
#
## plan {
##    publisher = "openvpn"
##    name      = "access_server_byol"
##    product   = "openvpnas"
##  }
#
#  # Uncomment this line to delete the OS disk automatically when deleting the VM
#  # delete_os_disk_on_termination = true
#
#  # Uncomment this line to delete the data disks automatically when deleting the VM
#  # delete_data_disks_on_termination = true
#
#  storage_image_reference {
#    publisher = "Canonical"
#    offer     = "UbuntuServer"
#    sku       = "18.04-LTS"
#    version   = "latest"
#  }
#  storage_os_disk {
#    name              = "vpndisk"
#    caching           = "ReadWrite"
#    create_option     = "FromImage"
#    managed_disk_type = "Standard_LRS"
#  }
#  os_profile {
#    computer_name  = "vpn"
#    admin_username = "vpnbsai"
#    admin_password = "Brainsight@vpn"
#  }
#  os_profile_linux_config {
#    disable_password_authentication = false
#  }
#  tags = {
#    environment = "Production"
#  }
#}
#
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