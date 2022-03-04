#Update Kubernetes credentials in local ./kubeconfig
#az aks get-credentials --resource-group dev-bsai --name dev-aks --admin --overwrite-existing

#Create Service Principle Role for Kubernetes Cluster
#az ad sp create-for-rbac --skip-assignment

#Create Secret for access Storage Account in Kubernetes Applications
#kubectl create secret generic azure-secret1 --from-literal=azurestorageaccountname=devfilesharestg --from-literal=azurestorageaccountkey=qU/A1Xl1x58FGLCItQYsgNL1WmfzpS0rWl+6bl+K8CXI9KY3Mt2qsuna8rJk3MQ89V7N3JoEsDSkoOM0HPzHWA==

#Attach Container Registry to Kubernetes Cluster
#az aks update -n dev-aks -g dev-bsai --attach-acr devbsai

#Create Role to map Static Public IP to Kubernetes SERVICE
# Enter your details below.
PIP_RESOURCE_GROUP=dev-bsai
AKS_RESOURCE_GROUP=dev-bsai
AKS_CLUSTER_NAME=dev-k8s
# Do not change anything below this line
CLIENT_ID=$(az aks show --resource-group dev-bsai --name dev-k8s --query "servicePrincipalProfile.clientId" --output tsv)
SUB_ID=$(az account show --query "id" --output tsv)

az role assignment create\
    --assignee $CLIENT_ID \
    --role "Network Contributor" \
    --scope /subscriptions/$SUB_ID/resourceGroups/$PIP_RESOURCE_GROUP
