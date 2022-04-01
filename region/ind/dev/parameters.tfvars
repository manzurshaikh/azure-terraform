/* Generic */
env    = "dev"
region = "centralindia" 

/* STORAGE */
storage_name                   = "bsaistg"
stg_ip_rules_bsai              = ["20.193.136.157","20.193.136.160","20.193.136.214","20.193.136.224","20.193.136.239","20.193.136.249","20.193.137.13","20.193.137.14","20.193.137.36","20.193.137.55","20.193.136.216","20.193.136.217","104.211.113.109","52.172.164.90","104.211.116.183","13.71.1.53","52.172.221.97","52.172.211.172","52.172.144.111","104.211.118.93","52.172.215.180","52.172.221.13","13.71.36.155","52.172.136.188","20.193.128.244","20.193.129.6","20.193.129.126","20.193.136.12","20.193.136.57","20.193.136.59","52.140.106.224","52.140.106.225","40.80.83.255"]
default_action_rule            = "Allow"
allow_blob_public_access_bsai  = false
stg_account_tier_bsai          = "Standard"
stg_access_tier                = "Cool"
storageshare_quota_bsai        = "50"
enable_https_traffic_only_bsai = true
nfsv3_enabled_bsai             = false
account_replication_type_bsai = "LRS"

storage_name1                  = "bsdatastg"
stg_ip_rules_bsai1              = ["20.193.136.157","20.193.136.160","20.193.136.214","20.193.136.224","20.193.136.239","20.193.136.249","20.193.137.13","20.193.137.14","20.193.137.36","20.193.137.55","20.193.136.216","20.193.136.217","104.211.113.109","52.172.164.90","104.211.116.183","13.71.1.53","52.172.221.97","52.172.211.172","52.172.144.111","104.211.118.93","52.172.215.180","52.172.221.13","13.71.36.155","52.172.136.188","20.193.128.244","20.193.129.6","20.193.129.126","20.193.136.12","20.193.136.57","20.193.136.59","52.140.106.224","52.140.106.225","40.80.83.255"]
default_action_rule1            = "Deny"
allow_blob_public_access_bsai1  = true
stg_account_tier_bsai1          = "Premium"
stg_access_tier1                = "Hot"
storageshare_quota_bsai1        = "200"
enable_https_traffic_only_bsai1 = true
nfsv3_enabled_bsai1             = false
account_replication_type_bsai1 = "LRS"


storage_name2                   = "databs"
stg_ip_rules_bsai2              = ["20.198.119.4","40.80.90.196","40.80.83.255"] #fake IP #40.80.90.196 medidata #40.80.83.255 vpn

stg_ip_rules_bsai3              = ["20.198.119.4","40.80.90.196","40.80.83.255"] #fake IP #40.80.90.196 medidata #40.80.83.255 VPN


/* AZURE FUNCTION PLAN - CONSUMTION */
fun_service_plan_name        = "fun_service_plan"
tier_az_fun_plan             = "Dynamic"
size_az_fun_plan             = "Y1"

/* Premium_Plan Azure Function */
fun_premium_plan_name       = "fun_premium_plan"
#capacity_az_funpremium_plan = "1"
tier_az_funpremium_plan     = "ElasticPremium"
size_az_funpremium_plan     = "EP1"

/* APP_SERVICE_PLAN AZURE APP SERVICE ML DOCKER */
app_service_plan_docker_name       = "app_service_mldocker_plan"
#capacity_az_appservice_docker_plan = "1"
tier_az_appservice_docker_plan     = "PremiumV3"
size_az_appservice_docker_plan     = "P2v3"

/* APP_SERICE_PLAN File_processing Docker */
tier_az_appservice_fileprocess_plan = "PremiumV3"
size_az_appservice_fileprocess_plan = "P1v3"

/* APP_SERVICE_PLAN AZURE APP SERVICE ML DOCKER_SMRI */
tier_az_appservice_voxelbox_smri = "PremiumV3"
size_az_appservice_voxelbox_smri = "P1v3"

/* APP_SERVICE_PLAN AZURE APP SERVICE VOXELBOX_DTI */
tier_az_appservice_voxelbox_dti = "PremiumV3"
size_az_appservice_voxelbox_dti = "P1v3"

/* APP_SERVICE_PLAN AZURE APP SERVICE BsaiGeneralPurpose */
tier_az_appservice_bsaigeneralpurpose = "PremiumV2"
size_az_appservice_bsaigeneralpurpose = "P1v2"

/* APP_SERVICE_PLAN AZURE APP SERVICE windows */
tier_az_appservice_windows = "Basic"
size_az_appservice_windows = "B1"

/* APP_SERVICE_PLAN AZURE APP SERVICE VOXELBOX_PLUS */
tier_az_appservice_voxelbox_plus = "PremiumV2"
size_az_appservice_voxelbox_plus = "P1v2"

/* APP_SERVICE_PLAN AZURE APP SERVICE VOXELBOX_PROD */
tier_az_appservice_voxelbox_prod = "PremiumV3"
size_az_appservice_voxelbox_prod = "P2v3"

/* APP_SERVICE_PLAN AZURE APP SERVICE UAT_VOXELBOX_FC */
tier_az_appservice_uat_voxelboxfc = "PremiumV3"
size_az_appservice_uat_voxelboxfc = "P1v3"

/* APP_SERVICE_PLAN AZURE APP SERVICE UAT_VOXELBOX */
tier_az_appservice_uat_voxelbox = "PremiumV3"
size_az_appservice_uat_voxelbox = "P2v3"

/* APP SERVICE */
#app_service1                  = "voxelbox"
#app_service2                  = "voxelboxplus"
app_service3                  = "bsaiuploaderbackend"   
app_service4                  = "fileprocessingnew"
#app_service5                  = "voxelboxsmri"
#app_service6                  = "voxelboxdti"
app_service7                  = "brainsightuploader"  #manual upload code
app_service8                  = "voxelboxfc"
#app_service9                  = "voxelboxdementia"
app_service10                 = "uat-datafiletesting"
#app_service11                 = "fileprocessing-carpl"
#app_service12                 = "normative-mapping"
#app_service13                 = "uat-voxelbox"
app_service14                 = "voxelbox-prod"
#app_service15                 = "uat-voxelboxfc"
#app_service16                 = "uat-voxelboxnmli"

/* AZURE FUNCTION */
#function_name1                = "fileuloadbs"    #should not use "-" for function_name 
#function_name2                = "middlewarebs"
function_name3                = "processinvokebs"
#function_name4                = "processstatusbs"
#function_name5                = "inferencestatusbs"
function_name6                = "inferenceinvokebs"
function_name7                = "smriinvokebs"
#function_name8                = "feedbackbs"
function_name9                = "uatpreprocessinvokebs"
function_name10               = "uatinferenceinvokebs"
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

servicebus_name_4       = "uatinferencetrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_4 = "uatinferencetrigger"        #should not use "-" for servicebus_queue_name 

servicebus_name_5       = "uatpreprocesstrigger"        #should not use "-" for servicebus_queue_name 
servicebus_queue_name_5 = "uatpreprocesstrigger"        #should not use "-" for servicebus_queue_name 

#/* ACI */
#aci_name_1              = "voxelbox"
#aci_ip_type_aci_1       = "Public"
#container_name_aci_1    = "voxelbox"
#container_image_aci_1   = "devbsai.azurecr.io/voxelbox:v0.1"
#container_cpu_aci_1     = "4"
#container_memory_aci_1  = "16"
#container_port_aci_1    = "5000"
#aci_storage_share_name  = "training"
#aci_storage_mount_path  = "/training"
#
#/* ACI-2 */
#aci_name_2              = "voxelbox-2"
#aci_ip_type_aci_2       = "Public"
#container_name_aci_2    = "voxelbox"
#container_image_aci_2   = "devbsai.azurecr.io/voxelbox:v0.7"
#container_cpu_aci_2     = "2"
#container_memory_aci_2  = "8"
#container_port_aci_2    = "5000"


/* COSMOS DB */
/* Note - Enable Azure portal Access in Network once this feature is available */
cosmodb_account_name_1       = "bsaidb"
cosmosdb_name_1              = "bsaidb"
enable_automatic_failover    = false
failover_location_secondary  = "centralindia"
failover_priority_secondary  = "0"
ip_range_filter              = "20.193.136.157,20.193.136.160,20.193.136.214,20.193.136.224,20.193.136.239,20.193.136.249,20.193.137.13,20.193.137.14,20.193.137.36,20.193.137.55,20.193.136.216,20.193.136.217,104.211.113.109,52.172.164.90,104.211.116.183,13.71.1.53,52.172.221.97,52.172.211.172,52.172.144.111,104.211.118.93,52.172.215.180,52.172.221.13,13.71.36.155,52.172.136.188,20.193.128.244,20.193.129.6,20.193.129.126,20.193.136.12,20.193.136.57,20.193.136.59,52.140.106.224,103.199.93.77,104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26,52.140.106.224,52.140.106.224"
ip_range_filter1             = "40.80.83.255"   #Notes: 40.80.83.255-Dipak

