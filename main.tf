#Resource group 
#VNets
#Subnets
#Route tables
#Virtual Machines (Jump servers)
#Azure DDoS
#VPN GW
#Application gateway
#Azure Bastion
#Azure Firewall
#Azure Sentinel
#Azure storage account
#Keyvault
#Log analytics workspace
#testJob
#helloSunil


resource "azurerm_resource_group" "network_resource_group" {
  name     = var.network_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}

