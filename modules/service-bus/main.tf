resource "azurerm_servicebus_namespace" "namespace" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  #capacity            = "16"        

  tags = {
    "terraform"        = "v0.13"
  }
}


resource "azurerm_servicebus_namespace_authorization_rule" "authorization" {
  depends_on = [azurerm_servicebus_namespace.namespace]
  name                = var.servicebus_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = false
}

resource "azurerm_servicebus_topic" "source" {
  name                = "${var.servicebus_name}-sbt-source"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  enable_partitioning = false
}

resource "azurerm_servicebus_topic_authorization_rule" "example" {
  name                = "${var.servicebus_name}-sbtauth-source"
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  topic_name          = azurerm_servicebus_topic.source.name
  resource_group_name = var.resource_group_name
  send                = true
  listen              = true
  manage              = true
}

resource "azurerm_servicebus_topic" "destination" {
  name                = "${var.servicebus_name}-sbt-destination"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  enable_partitioning = true
}

resource "azurerm_servicebus_subscription" "example" {
  name                = "${var.servicebus_name}-sbsubscription"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  topic_name          = azurerm_servicebus_topic.source.name
  forward_to          = azurerm_servicebus_topic.destination.name
  max_delivery_count  = var.max_delivery_count
}


resource "azurerm_servicebus_queue" "example" {
  name                = var.servicebus_queue_name
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  enable_partitioning = false
}
