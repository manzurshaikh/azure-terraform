/* Generic */
env = "dev"
region = "centralindia" 

/* STORAGE */
storage_name = "bsaistg"
stg_ip_rules_bsai = ["103.199.93.222"]
allow_blob_public_access_bsai = false
stg_account_tier_bsai = "Standard"
storageshare_quota_bsai = "50"
enable_https_traffic_only_bsai = true
nfsv3_enabled_bsai = false
account_replication_type_bsai = "LRS"

/* APP SERVICE */
app_service1  = "voxelbox"

/* AZURE FUNCTION */
function_name1 = "datauploadbs"    #should not use "-" for function_name 
function_name2 = "middlewarebs"
function_name3 = "processinvokebs"

/* SERVICE_BUS */
servicebus_name_1 = "datatrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_1 = "datatrigger"   #should not use "-" for servicebus_queue_name 

servicebus_name_2 = "preprocesstrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_2 = "preprocesstrigger"   #should not use "-" for servicebus_queue_name 

/* COSMOS DB */
cosmodb_account_name_1 = "bsaidb"
cosmosdb_name_1 = "bsaidb"
enable_automatic_failover = false
failover_location_secondary  = "centralindia"
failover_priority_secondary = "0"
