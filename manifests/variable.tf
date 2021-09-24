/* Resource Group */
variable "env" {
}

variable "region" {
}

/* Container registry */
variable "docker_registry_server_username" {
}

variable "docker_registry_server_password" {
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

/* Azure_Function_Service_Plan_consumtion */
variable "fun_service_plan_name" {
}

variable "tier_az_fun_plan" {
}

variable "size_az_fun_plan" {
}

/* Azure Function */
variable "function_name1" {
}

variable "function_name2" {
}

variable "function_name3" {
}

variable "function_name4" {
}

variable "function_name5" {
}

variable "function_name6" {
}

variable "function_name7" {
}

variable "functions_worker_runtime" {
}

variable "website_node_default_version" {
}

variable "website_run_from_package" {
}

variable "website_run_from_package_fun1" {
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

variable "servicebus_name_3" {
}

variable "servicebus_queue_name_3" {
}

/* Premium_Plan Azure Function */
variable "fun_premium_plan_name" {
}

#variable "capacity_az_funpremium_plan" {
#}

variable "tier_az_funpremium_plan" {
}

variable "size_az_funpremium_plan" {
}

/* APP_SERVICE_PLAN Azure ML Docker */
variable "app_service_plan_docker_name" {
}

#variable "capacity_az_appservice_docker_plan" {
#}

variable "tier_az_appservice_docker_plan" {
}

variable "size_az_appservice_docker_plan" {
}

/* APP_SERICE_PLAN File_processing */
variable "fileprocess_plan_name" {
    default = "fileprocessing_plan"
}

variable "tier_az_appservice_fileprocess_plan" {
}

variable "size_az_appservice_fileprocess_plan" {
}

/* APP_SERVICE_PLAN Azure ML DOCKER_SMRI */
variable "tier_az_appservice_voxelbox_smri" {
}

variable "size_az_appservice_voxelbox_smri" {
}

/* APP_SERVICE_PLAN Azure ML DOCKER_DTI */
variable "tier_az_appservice_voxelbox_dti" {
}

variable "size_az_appservice_voxelbox_dti" {
}

/* APP_SERVICE_1 */
variable "app_service1" { 
}

variable "docker_registry_server_url" {
}

variable "docker_custom_image_name_app_service1" {
}

variable "linux_fx_version_app_service1" {
}

variable "app_storage_key_1" {
}

/* APP_SERVICE_2 */
variable "app_service2" { 
}

variable "docker_custom_image_name_app_service2" {
}

variable "linux_fx_version_app_service2" {
}

#/* APP_SERVICE_3 */
#variable "app_service3" { 
#}
#
#variable "docker_custom_image_name_app_service3" {
#}
#
#variable "linux_fx_version_app_service3" {
#}

/* APP_SERVICE_4 */
variable "app_service4" { 
}

variable "docker_custom_image_name_app_service4" {
}

variable "linux_fx_version_app_service4" {
}

/* APP_SERVICE_5 */
variable "app_service5" { 
}

variable "docker_custom_image_name_app_service5" {
}

variable "linux_fx_version_app_service5" {
}

/* APP_SERVICE_6 */
variable "app_service6" { 
}

variable "docker_custom_image_name_app_service6" {
}

variable "linux_fx_version_app_service6" {
}

#/* ACI */
#variable "aci_name_1" {
#}
#
#variable "aci_ip_type_aci_1" {
#}
#
#variable "container_name_aci_1" {
#}
#
#variable "container_image_aci_1" {
#}
#
#variable "container_cpu_aci_1" {
#}
#
#variable "container_memory_aci_1" {
#}
#
#variable "container_port_aci_1" {
#}
#
#variable "docker_registry_server_url_aci" {
#}
#
#variable "aci_storage_share_name" {
#}
#
#variable "aci_storage_mount_path" {
#}
#
#variable "aci_storage_key" {
#}
#
#/* ACI - 2 */
#variable "aci_name_2" {
#}
#
#variable "aci_ip_type_aci_2" {
#}
#
#variable "container_name_aci_2" {
#}
#
#variable "container_image_aci_2" {
#}
#
#variable "container_cpu_aci_2" {
#}
#
#variable "container_memory_aci_2" {
#}
#
#variable "container_port_aci_2" {
#}

/* AKS */
variable "appId" {
}

variable "client_secret" {
}
