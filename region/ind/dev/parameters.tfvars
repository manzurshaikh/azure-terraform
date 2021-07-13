/* Generic */
env = "dev"
region = "centralindia" 

/* STORAGE */
storage_name = "bsai"

/* APP SERVICE */
app_service1  = "bsai"

/* AZURE FUNCTION */
function_name1 = "concurrencybs"    #should not use "-" for function_name 
#function_name2 = "middleware"
#function_name3 = "invokeprocessing"

/* SERVICE_BUS */
servicebus_name_1 = "contest"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_1 = "conqueue"   #should not use "-" for servicebus_queue_name 

/* COSMOS DB */
cosmodb_account_name_1 = "bsaidb"
cosmosdb_name_1 = "bsaidb"
enable_automatic_failover = false
failover_location_secondary  = "centralindia"
failover_priority_secondary = "0"
