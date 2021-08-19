# Enter your details below.
PIP_RESOURCE_GROUP=dev-bsai
AKS_RESOURCE_GROUP=dev-bsai
AKS_CLUSTER_NAME=dev-aks
# Do not change anything below this line
CLIENT_ID=$(az aks show --resource-group dev-bsai --name dev-aks --query "servicePrincipalProfile.clientId" --output tsv)
SUB_ID=$(az account show --query "id" --output tsv)

az role assignment create\
    --assignee $CLIENT_ID \
    --role "Network Contributor" \
    --scope /subscriptions/$SUB_ID/resourceGroups/$PIP_RESOURCE_GROUP
