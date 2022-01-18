resource "azurerm_network_interface" "main" {
  name                = var.vm_network_interface
  location            = var.location
  resource_group_name = var.resource_group_name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "winconfiguration"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.vm_publicip_id
  }
}

resource "azurerm_network_security_group" "winserver" {
  name                = var.vm_network_securitygroup
  location            = var.location
  resource_group_name = var.resource_group_name
    security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "31001"
    priority                   = 101
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "31001"
    destination_address_prefix = azurerm_network_interface.main.private_ip_address
  }

    security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "31002"
    priority                   = 102
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "31002"
    destination_address_prefix = azurerm_network_interface.main.private_ip_address
  }

    security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "RDP"
    priority                   = 103
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "40.80.83.255/32"
    destination_port_range     = "3389"
    destination_address_prefix = azurerm_network_interface.main.private_ip_address
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

# plan {
#    publisher = "openvpn"
#    name      = "access_server_byol"
#    product   = "openvpnas"
#  }

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = var.vm_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vm_managed_disk_type
  }
  os_profile {
    computer_name  = var.vm_computer_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }
  os_profile_windows_config {
  }
  tags = {
    environment = "Production"
  }
}


#Note - accept the market place license 
#az vm image list --location centralindia --offer openvpnas --publisher openvpn --all --help
#az vm image accept-terms --urn openvpn:openvpnas:access_server_byol:285.0.0