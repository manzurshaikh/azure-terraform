variable "resource_group_name" {
}

variable "location" {
}

variable "cosmodb_account_name" {
}

variable "ip_range_filter" {
}

variable "failover_location_secondary" {
}

variable "failover_priority_secondary" {
}

variable "enable_automatic_failover" {
}

variable "is_virtual_network_filter_enabled" {
  default     = true
}

variable "vnet_subnet_id" {
  description = "List of subnets to be used in Cosmosdb."
  type = list(object({
    id   = string
  }))
}

variable "cosmosdb_name" {
}
