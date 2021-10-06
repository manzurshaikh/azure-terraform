#/bin/bash
#az webapp stop --name dev-voxelbox --resource-group dev-bsai
#az webapp start --name dev-voxelbox --resource-group dev-bsai

instance1=dev-voxelbox 
instance2=dev-voxelboxplus 
instance3=dev-voxelboxdti
instance4=dev-voxelboxsmri
instance5=dev-fileprocessingnew

resource_group=dev-bsai


#az webapp stop --name $instance1 --resource-group $resource_group
#az webapp stop --name $instance2 --resource-group $resource_group
#az webapp stop --name $instance3 --resource-group $resource_group
#az webapp stop --name $instance4 --resource-group $resource_group
#az webapp stop --name $instance5 --resource-group $resource_group


az webapp start --name $instance1 --resource-group $resource_group
az webapp start --name $instance2 --resource-group $resource_group
az webapp start --name $instance3 --resource-group $resource_group
az webapp start --name $instance4 --resource-group $resource_group
az webapp start --name $instance5 --resource-group $resource_group
