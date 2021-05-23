terraform {
  required_version = "0.13.0"

    backend "azurerm" {
    storage_account_name = "tfstatebs"
    container_name       = "tfstate"
    resource_group_name  = "tfstate"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  version = "2.56.0"
  features {}
}

resource "azurerm_resource_group" "bsrg" {
 name     = "${var.env}-bsrg"
 location = "${var.region}"
}

resource "azurerm_virtual_network" "bsvnet" {
  name                = "${var.env}-bsvnet"
  resource_group_name = "${azurerm_resource_group.bsrg.name}"
  location            = "${azurerm_resource_group.bsrg.location}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.env}-bssubnet"
  virtual_network_name = "${var.env}-bsvnet"
  resource_group_name  = "${azurerm_resource_group.bsrg.name}"
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "bsnwprofile" {
  name                = "${var.env}-bsnwprofile"
  location            = "${azurerm_resource_group.bsrg.location}"
  resource_group_name = "${azurerm_resource_group.bsrg.name}"

  container_network_interface {
    name = "hellocnic"

    ip_configuration {
      name      = "helloipconfig"
      subnet_id = azurerm_subnet.subnet.id
    }
  }
}

resource "azurerm_container_group" "bscontinst" {
  name                = "${var.env}-continst"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.bsrg.name}"
  ip_address_type     = "Public"
  dns_name_label      = "manzurdevops"
  #network_profile_id  = azurerm_network_profile.bsnwprofile.id
  os_type             = "Linux"
  restart_policy      = "Never"

  container {
    name   = "hello-world"
    #image  = "microsoft/aci-helloworld:latest"
    image  = "tutum/hello-world:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "microsoft/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "testing"
  }
}

resource "azurerm_storage_account" "bsstorage" {
  name                     = "${var.env}bsstor"
  resource_group_name      = "${azurerm_resource_group.bsrg.name}"
  location                 = "${azurerm_resource_group.bsrg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "bsstorageshr" {
  name                 = "${var.env}-bsstorageshr"
  storage_account_name = "${azurerm_storage_account.bsstorage.name}"
  quota                = 50
}
resource "azurerm_container_registry" "bscontreg" {
  name                = "${var.env}bscontreg"
  resource_group_name = "${azurerm_resource_group.bsrg.name}"
  location            = "${azurerm_resource_group.bsrg.location}"
  sku                 = "Standard"
}
