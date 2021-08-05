/* Generic */
env = "prod"
region = "centralindia" 

/* STORAGE */
storage_name = "bsaistg"

/* APP SERVICE */
app_service1  = "voxelbox"

/* AZURE FUNCTION */
function_name1 = "dataupload"    #should not use "-" for function_name 
function_name2 = "middleware"
function_name3 = "processinvoke"

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
#failover_location_secondary  = "southindia"
#failover_priority_secondary = "1"
