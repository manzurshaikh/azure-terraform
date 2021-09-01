/* Generic */
env    = "dev"
region = "centralindia" 

/* STORAGE */
storage_name                   = "bsaistg"
stg_ip_rules_bsai              = ["20.193.136.157","20.193.136.160","20.193.136.214","20.193.136.224","20.193.136.239","20.193.136.249","20.193.137.13","20.193.137.14","20.193.137.36","20.193.137.55","20.193.136.216","20.193.136.217","104.211.113.109","52.172.164.90","104.211.116.183","13.71.1.53","52.172.221.97","52.172.211.172","52.172.144.111","104.211.118.93","52.172.215.180","52.172.221.13","13.71.36.155","52.172.136.188","20.193.128.244","20.193.129.6","20.193.129.126","20.193.136.12","20.193.136.57","20.193.136.59","52.140.106.224"]
default_action_rule            = "Allow"
allow_blob_public_access_bsai  = false
stg_account_tier_bsai          = "Standard"
stg_access_tier                = "Cool"
storageshare_quota_bsai        = "50"
enable_https_traffic_only_bsai = true
nfsv3_enabled_bsai             = false
account_replication_type_bsai = "LRS"

/* AZURE FUNCTION PLAN - CONSUMTION */
fun_service_plan_name        = "fun_service_plan"
tier_az_fun_plan             = "Dynamic"
size_az_fun_plan             = "Y1"

/* Premium_Plan Azure Function */
fun_premium_plan_name       = "fun_premium_plan"
capacity_az_funpremium_plan = "1"
tier_az_funpremium_plan     = "ElasticPremium"
size_az_funpremium_plan     = "EP1"

/* APP_SERVICE_PLAN AZURE APP SERVICE ML DOCKER */
app_service_plan_docker_name       = "app_service_mldocker_plan"
capacity_az_appservice_docker_plan = "1"
tier_az_appservice_docker_plan     = "PremiumV2"
size_az_appservice_docker_plan     = "P2v2"

/* APP SERVICE */
app_service1                  = "voxelbox"
app_service2                  = "voxelboxplus"
app_service3                  = "fileprocesssing"
app_service4                  = "fileprocessingnew"

/* AZURE FUNCTION */
function_name1                = "datauploadsbs"    #should not use "-" for function_name 
function_name2                = "middlewarebs"
function_name3                = "processinvokebs"
function_name4                = "processstatusbs"
function_name5                = "inferencestatusbs"
function_name6                = "inferenceinvokebs"
functions_worker_runtime      = "node"
website_node_default_version  = "~14"
website_run_from_package      = "0"
website_run_from_package_fun1 = "true"

/* SERVICE_BUS */
servicebus_name_1       = "datatrigger"             #should not use "-" for servicebus_queue_name 
servicebus_queue_name_1 = "datatrigger"             #should not use "-" for servicebus_queue_name 

servicebus_name_2       = "preprocesstrigger"       #should not use "-" for servicebus_queue_name 
servicebus_queue_name_2 = "preprocesstrigger"       #should not use "-" for servicebus_queue_name 

servicebus_name_3       = "inferencetrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_3 = "inferencetrigger"        #should not use "-" for servicebus_queue_name 

/* ACI */
aci_name_1              = "voxelbox"
aci_ip_type_aci_1       = "Public"
container_name_aci_1    = "voxelbox"
container_image_aci_1   = "devbsai.azurecr.io/voxelbox:v0.1"
container_cpu_aci_1     = "4"
container_memory_aci_1  = "16"
container_port_aci_1    = "5000"
aci_storage_share_name  = "training"
aci_storage_mount_path  = "/training"

/* ACI-2 */
aci_name_2              = "voxelbox-2"
aci_ip_type_aci_2       = "Public"
container_name_aci_2    = "voxelbox"
container_image_aci_2   = "devbsai.azurecr.io/voxelbox:v0.7"
container_cpu_aci_2     = "2"
container_memory_aci_2  = "8"
container_port_aci_2    = "5000"


/* COSMOS DB */
/* Note - Enable Azure portal Access in Network once this feature is available */
cosmodb_account_name_1       = "bsaidb"
cosmosdb_name_1              = "bsaidb"
enable_automatic_failover    = false
failover_location_secondary  = "centralindia"
failover_priority_secondary  = "0"
ip_range_filter              = "20.193.136.157,20.193.136.160,20.193.136.214,20.193.136.224,20.193.136.239,20.193.136.249,20.193.137.13,20.193.137.14,20.193.137.36,20.193.137.55,20.193.136.216,20.193.136.217,104.211.113.109,52.172.164.90,104.211.116.183,13.71.1.53,52.172.221.97,52.172.211.172,52.172.144.111,104.211.118.93,52.172.215.180,52.172.221.13,13.71.36.155,52.172.136.188,20.193.128.244,20.193.129.6,20.193.129.126,20.193.136.12,20.193.136.57,20.193.136.59,52.140.106.224,103.199.93.77,104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"
