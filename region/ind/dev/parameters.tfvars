/* Generic */
env    = "dev"
region = "centralindia" 

/* STORAGE */
storage_name                   = "bsaistg"
stg_ip_rules_bsai              = ["103.199.93.37"]
default_action_rule            = "Allow"
allow_blob_public_access_bsai  = true
stg_account_tier_bsai          = "Standard"
stg_access_tier                = "Cool"
storageshare_quota_bsai        = "50"
enable_https_traffic_only_bsai = true
nfsv3_enabled_bsai             = false
account_replication_type_bsai = "LRS"

/* APP SERVICE */
app_service1                = "voxelbox"
app_service_plan_name       = "app_service_plan"
capacity_az_appservice_plan = "1"
tier_az_appservice_plan     = "Basic"
size_az_appservice_plan     = "B1"

/* AZURE FUNCTION */
function_name1               = "datauploadbs"    #should not use "-" for function_name 
function_name2               = "middlewarebs"
function_name3               = "processinvokebs"
fun_service_plan_name        = "fun_service_plan"
tier_az_fun_plan             = "Dynamic"
size_az_fun_plan             = "Y1"
functions_worker_runtime     = "node"
website_node_default_version = "~14"
website_run_from_package     = "0"

/* SERVICE_BUS */
servicebus_name_1       = "datatrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_1 = "datatrigger"   #should not use "-" for servicebus_queue_name 

servicebus_name_2       = "preprocesstrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_2 = "preprocesstrigger"   #should not use "-" for servicebus_queue_name 

/* COSMOS DB */
cosmodb_account_name_1       = "bsaidb"
cosmosdb_name_1              = "bsaidb"
enable_automatic_failover    = false
failover_location_secondary  = "centralindia"
failover_priority_secondary  = "0"
