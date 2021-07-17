/* Resource Group */
variable "env" {
}

variable "region" {
}

/* STORAGE */
variable "storage_name" {
}

variable "stg_ip_rules_bsai" {
}

variable "default_action_rule" {
}

variable "allow_blob_public_access_bsai" {
}

variable "stg_account_tier_bsai" {
}

variable "stg_access_tier" {
}

variable "storageshare_quota_bsai" {
}

variable "enable_https_traffic_only_bsai" {
}

variable "nfsv3_enabled_bsai" {
}

variable "account_replication_type_bsai" {
}


/* Azure Function */
variable "function_name1" {
}

variable "function_name2" {
}

variable "function_name3" {
}

variable "fun_service_plan_name" {
}

variable "tier_az_fun_plan" {
}

variable "size_az_fun_plan" {
}

variable "functions_worker_runtime" {
}

variable "website_node_default_version" {
}

variable "website_run_from_package" {
}

/* DATABASE */
variable "cosmodb_account_name_1" {
}

variable "enable_automatic_failover" {
}

variable "failover_location_secondary" {
}

variable "failover_priority_secondary" {
}

variable "cosmosdb_name_1" {
}

variable "ip_range_filter" {
    #type        = list(string)
    #default = "0.0.0.0"
}

/*SERVICE_BUS */
variable "servicebus_name_1" {
}

variable "servicebus_queue_name_1" {
}

variable "servicebus_name_2" {
}

variable "servicebus_queue_name_2" {
}

/* APP_SERVICE */
variable "app_service1" { 
}

#variable "app_service2" { 
#}

variable "app_service_plan_name" {
}

variable "tier_az_appservice_plan" {
}

variable "size_az_appservice_plan" {
}

variable "docker_registry_server_url" {
}

variable "docker_registry_server_username" {
}

variable "docker_registry_server_password" {
}

variable "docker_custom_image_name" {
}

variable "linux_fx_version" {
}

variable "capacity_az_appservice_plan" {
}