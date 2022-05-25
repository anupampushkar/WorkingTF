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

resource "azurerm_resource_group" "mgmt_resource_group" {
  name     = var.mgmt_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}

resource "azurerm_resource_group" "bastion_resource_group" {
  name     = var.bastion_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}

resource "azurerm_resource_group" "security_resource_group" {
  name     = var.security_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}

resource "azurerm_resource_group" "monitor_resource_group_name" {
  name     = var.monitor_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}
resource "azurerm_resource_group" "agw_resource_group" {
  name     = var.agw_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}

resource "azurerm_resource_group" "keyvault_resource_group" {
  name     = var.keyvault_resource_group_name
  location = var.location
  tags = {
			Environment    = var.environment
  }
}


resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = var.ddos_protection_plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.network_resource_group.name
  tags = {
			Environment    = var.environment
  }
    depends_on = [azurerm_resource_group.network_resource_group]
}


resource azurerm_virtual_network "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.network_resource_group.name
  location            = azurerm_resource_group.network_resource_group.location
  address_space       = var.vnet_address_space

    ddos_protection_plan {
       
          id     = azurerm_network_ddos_protection_plan.ddos.id
          enable = true

      
	  
  }
  
  tags = {
			Environment    = var.environment
  }
  depends_on = [azurerm_resource_group.network_resource_group,azurerm_network_ddos_protection_plan.ddos]
  
 }
 
 resource "azurerm_subnet" "subnet" {
  #count   =  length(var.subnet_details)
   for_each = var.subnet_details
  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.network_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_public_ip_name
  location            = azurerm_resource_group.bastion_resource_group.location
  resource_group_name = azurerm_resource_group.bastion_resource_group.name
  allocation_method   = var.bastion_public_ip_allocation_method
  sku                 = var.bastion_public_ip_sku
  availability_zone   = "No-Zone"
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_host_name
  location            = azurerm_resource_group.bastion_resource_group.location
  resource_group_name = azurerm_resource_group.bastion_resource_group.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet["bastion"].id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
  
  tags = {
			Environment    = var.environment
  }
}



resource "azurerm_storage_account" "storage" {
  name                     = var.bootdiag_storage_account_name
  resource_group_name      = azurerm_resource_group.mgmt_resource_group.name
  location                 = azurerm_resource_group.mgmt_resource_group.location
  account_tier             = var.bootdiag_storage_account_tier
  account_replication_type = var.bootdiag_storage_account_replication_type
  
  tags = {
			Environment    = var.environment
  }
}


resource "azurerm_public_ip" "firewall_pip" {
name = var.firewall_pip_name
resource_group_name = azurerm_resource_group.network_resource_group.name
location = azurerm_resource_group.network_resource_group.location
allocation_method = var.firewall_pip_allocation_method
sku = var.firewall_pip_sku
availability_zone   = "No-Zone"
depends_on = [azurerm_resource_group.network_resource_group]

}



resource "azurerm_firewall" "firewall" {
name = var.firewall_name
location = azurerm_resource_group.network_resource_group.location
resource_group_name = azurerm_resource_group.network_resource_group.name
ip_configuration {
name = "configuration"
subnet_id = azurerm_subnet.subnet["firewall"].id
public_ip_address_id = azurerm_public_ip.firewall_pip.id
}
}


data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
name = var.kv_name
location = azurerm_resource_group.keyvault_resource_group.location
resource_group_name = azurerm_resource_group.keyvault_resource_group.name
enabled_for_disk_encryption = var.kv_enabled_for_disk_encryption
tenant_id = data.azurerm_client_config.current.tenant_id
soft_delete_retention_days = var.kv_soft_delete_retention_days
purge_protection_enabled = var.kv_purge_protection_enabled
sku_name = var.kv_sku_name
}

#resource "azurerm_public_ip" "vnet_gateway" {
#name = var.vnet_gateway_pip_name
#resource_group_name = azurerm_resource_group.network_resource_group.name
#location = azurerm_resource_group.network_resource_group.location
#allocation_method = var.vnet_gateway_pip_allocation_method
#sku = var.vnet_gateway_pip_sku
#depends_on = [azurerm_resource_group.network_resource_group]
#}




#resource "azurerm_virtual_network_gateway" "gateway" {
#name = var.virtual_network_gateway_name
#location = azurerm_resource_group.network_resource_group.location
#resource_group_name = azurerm_resource_group.network_resource_group.name



#type = var.virtual_network_gateway_type
#vpn_type = var.virtual_network_gateway_vpn_type



#active_active = var.virtual_network_gateway_active_active
#enable_bgp = var.virtual_network_gateway_enable_bgp
#sku = var.virtual_network_gateway_sku



#ip_configuration {
#public_ip_address_id = azurerm_public_ip.vnet_gateway.id
#private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
#subnet_id = azurerm_subnet.subnet["vpn_gw"].id
#}

resource "azurerm_public_ip" "application_gateway" {
name = var.agw_pip_name
resource_group_name = azurerm_resource_group.agw_resource_group.name
location = azurerm_resource_group.agw_resource_group.location
allocation_method = var.agw_pip_allocation_method
sku = var.agw_pip_sku
availability_zone   = "No-Zone"
depends_on = [azurerm_resource_group.agw_resource_group]
}



resource "azurerm_application_gateway" "network" {
name = var.application_gateway_name
resource_group_name = azurerm_resource_group.agw_resource_group.name
location = azurerm_resource_group.agw_resource_group.location



sku {
name = var.application_gateway_sku_name
tier = var.application_gateway_sku_tier
capacity = var.application_gateway_sku_capacity
}



gateway_ip_configuration {
name = var.gateway_ip_configuration_name
subnet_id = azurerm_subnet.subnet["agw"].id
}



frontend_port {
name = var.frontend_port_name
port = var.frontend_port_value
}



frontend_ip_configuration {
name = var.frontend_public_ip_configuration_name
public_ip_address_id = azurerm_public_ip.application_gateway.id
}




backend_address_pool {
name = var.backend_address_pool_name
}



backend_http_settings {
name = var.backend_http_setting_name
cookie_based_affinity = var.backend_http_cookie_based_affinity
path = var.backend_http_setting_path
port = var.backend_http_setting_port
protocol = var.backend_http_setting_protocol
request_timeout = var.backend_http_setting_request_timeout
}



http_listener {
name = var.http_listener_name
frontend_ip_configuration_name = var.frontend_public_ip_configuration_name
frontend_port_name = var.frontend_port_name
protocol = var.http_listener_protocol
}



request_routing_rule {
name = var.request_routing_rule_name
rule_type = var.request_routing_rule_type
http_listener_name = var.http_listener_name
backend_address_pool_name = var.backend_address_pool_name
backend_http_settings_name = var.backend_http_setting_name
}

tags = {
Environment = var.environment
}
}


resource "azurerm_log_analytics_workspace" "log_analytics" {
name = var.log_analytics_name
location = azurerm_resource_group.monitor_resource_group_name.location
resource_group_name =azurerm_resource_group.monitor_resource_group_name.name
sku = var.log_analytics_sku
retention_in_days = var.log_analytics_retention_in_days
depends_on = [azurerm_resource_group.monitor_resource_group_name]
}





####### VNET PEERING#########

/*resource "azurerm_virtual_network_peering" "DEV_peering" {

name = "vnet-hub-we-001-to-vnet-elms-dev-we-001"
resource_group_name = azurerm_resource_group.network_resource_group.name
virtual_network_name = azurerm_virtual_network.vnet.name
remote_virtual_network_id = "/subscriptions/4ba44d17-a250-4e43-8f03-ba2798775e48/resourceGroups/rg-elms-dev-we-001/providers/Microsoft.Network/virtualNetworks/vnet-elms-dev-we-001"
}


resource "azurerm_virtual_network_peering" "STG_peering" {

name = "vnet-hub-we-001-to-vnet-elms-stg-we-001"
resource_group_name = azurerm_resource_group.network_resource_group.name
virtual_network_name = azurerm_virtual_network.vnet.name
remote_virtual_network_id = "/subscriptions/b6c0a6dd-0975-4587-98f3-a028faa31286/resourceGroups/rg-elms-stg-we-001/providers/Microsoft.Network/virtualNetworks/vnet-elms-stg-we-001"
}


resource "azurerm_virtual_network_peering" "PROD_peering" {

name = "vnet-hub-we-001-to-vnet-elms-prod-we-001"
resource_group_name = azurerm_resource_group.network_resource_group.name
virtual_network_name = azurerm_virtual_network.vnet.name
remote_virtual_network_id = "/subscriptions/fee99cea-24f1-4060-a624-33dd80ec9b7f/resourceGroups/rg-elms-prod-we-001/providers/Microsoft.Network/virtualNetworks/vnet-elms-prod-we-001"
}*/




