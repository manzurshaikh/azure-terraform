resource "azurerm_network_profile" "main" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = "bsainic"

    ip_configuration {
      name      = "bsaiipconfig"
      subnet_id = var.virtual_network_name
    }
  }
}


resource "azurerm_container_group" "container_instance" {
  #depends_on          = [azurerm_network_profile.main]
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = var.aci_ip_type
  network_profile_id  = azurerm_network_profile.main.id
  os_type             = "Linux"
  restart_policy      = "OnFailure"

  image_registry_credential {
    server   = var.docker_registry_server_url
    username = var.docker_registry_server_username
    password = var.docker_registry_server_password
  }

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    volume {
    name                 = var.aci_storage_share_name
    mount_path           = var.aci_storage_mount_path
    read_only            = false
    share_name           = var.aci_storage_share_name
    storage_account_name = var.aci_storage_account_name
    storage_account_key  = var.aci_storage_key
    }
  }



  tags     = {
    "terraform"        = "v0.13"
  }
}
