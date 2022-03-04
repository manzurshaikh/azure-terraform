######Note - Vnet subnet - https://www.calculator.net
##upcoming subnets
#172.16.0.0 - done
#172.16.32.0 - done
#172.16.64.0	
#172.16.96.0	
#172.16.128.0
#172.16.160.0
#172.16.192.0
#172.16.224.0

###This Subnet used for AKS and not used any service_delegation
resource "azurerm_subnet" "dev-subnet-01" {
  depends_on                                    = [module.vnet]
  name                                          = "${var.env}_subnet-01"
  virtual_network_name                          = "${var.env}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["172.16.0.0/19"] #8k
  enforce_private_link_service_network_policies = false
    enforce_private_link_endpoint_network_policies = true
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform
}


resource "azurerm_subnet" "dev-subnet-02" {
  depends_on                                    = [module.vnet]
  name                                          = "${var.env}_subnet-02"
  virtual_network_name                          = "${var.env}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["172.16.32.0/19"]
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}


#Small Subnet with 256 IP used for App Service/VM's
resource "azurerm_subnet" "dev-subnet-03" {
  depends_on                                    = [module.vnet]
  name                                          = "${var.env}_subnet-03"
  virtual_network_name                          = "${var.env}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["172.16.64.0/24"]
  enforce_private_link_service_network_policies = false
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform
}

#Small Subnet with 256 IP used for App Service/VM's
resource "azurerm_subnet" "dev-subnet-03-01" {
  depends_on                                    = [module.vnet]
  name                                          = "${var.env}_subnet-03-01"
  virtual_network_name                          = "${var.env}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["172.16.65.0/24"]  ###further divide into 172.16.66.0 etc max can go up to 172.16.95.0 (Last)
  enforce_private_link_service_network_policies = false
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.AzureCosmosDB", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.ContainerRegistry"]
  service_endpoint_policy_ids                   = toset(null)    #Enable from the console currently not supported in Terraform

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
