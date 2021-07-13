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
}

variable "cosmosdb_name" {
}


#variable "backup" {
#  type        = map(string)
#  description = "Backup block with type (Continuous / Periodic), interval_in_minutes and retention_in_hours keys"
#  default = {
#    type                = "Periodic"
#    interval_in_minutes = 24 * 60
#    retention_in_hours  = 7 * 24
#  }
#}

