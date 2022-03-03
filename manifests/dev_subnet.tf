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

resource "azurerm_subnet" "dev-subnet-01" {
  depends_on                                    = [module.vnet]
  name                                          = "${var.env}_subnet-01"
  virtual_network_name                          = "${var.env}-bsai"
  resource_group_name                           = "${var.env}-bsai"
  address_prefixes                              = ["172.16.0.0/19"]
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


