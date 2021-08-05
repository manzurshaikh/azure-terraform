output "servicebus_connection_string" {
  value = "${azurerm_servicebus_namespace.namespace.default_primary_connection_string}"
  sensitive   = true
}
