variable "network_resource_group_name" {
  type        = string
  description = "Network components"
  default     = "rg-adxdev_hub-uaen-001"
}

variable "mgmt_resource_group_name" {
  type        = string
  description = "management components"
  default     = "rg-adxdev_hub-mgmtservices-uaen-001"
}

variable "bastion_resource_group_name" {
  type        = string
  description = "Bastion components"
  default     = "rg-adxdev_hub-mgmtservices-uaen-001"
}

variable "security_resource_group_name" {
  type        = string
  description = "securitycomponents"
  default     = "rg-adxdev_hub-Security-uaen-001"
}

variable "monitor_resource_group_name" {
  type        = string
  description = "monitor components"
  default     = "rg-adxdev_hub-mgmtservices-uaen-001"
}

variable "agw_resource_group_name" {
  type        = string
  description = "application gateway components"
  default     = "rg-adxdev_hub-agw-uaen-001"
}

variable "firewall_resource_group_name" {
  type        = string
  description = "Firewall components"
  default     = "rg-adxdev_hub-firewall-uaen-001"
}

variable "keyvault_resource_group_name" {
  type        = string
  description = "KeyVault components"
  default     = "rg-adxdev_hub-keyvault-uaen-001"
}

variable "environment" {
  type        = string
  description = "Environment tag"
  default    = "HUB"
}




variable "location" {
  type        = string
  description = "The location where the resource group should be created."
  default     = "UAE North"
}


variable "ddos_protection_plan_name" {
  type        = string
  description   = "DDOS Protection Plan"
  default      = "adxdev_ddos_hub-std-uaen-001"
}

variable "vnet_name" {
  type        = string
  description = "Specify the name of the virtual network"
  default     = "vnet-adxdev_hub-uaen-001"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Specify the address space that will be used by the virtual network"
  default = ["10.243.0.0/16"]
}



variable "subnet_details" {
   
  type = map(object({
    
    subnet_name        = string
    address_prefixes = list(string)
    service_endpoints = list(string)
  }))
  
  default = {

                                              mgmt = {
                                                    subnet_name =  "snet_hub_mgmtservices-uaen-001"
                                                    address_prefixes     =  ["10.243.10.0/26"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,
												  
                                                firewall = {
                                                    subnet_name =  "AzureFirewallSubnet"
                                                    address_prefixes     =  ["10.243.20.0/24"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,
												  
												 bastion = {
                                                    subnet_name =  "AzureBastionSubnet"
                                                    address_prefixes     =  ["10.243.30.0/26"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,
												  
												agw = {
                                                    subnet_name =  "snet_hub_agw-uaen-001"
                                                    address_prefixes     =  ["10.243.40.0/24"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,
												  
										   sharedservices = {
                                                    subnet_name =  "snet_hub__sharedservices-uaen-001"
                                                    address_prefixes     =  ["10.243.30.64/26"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,
												  
										     securityhub = {
                                                    subnet_name =  "snet_hub__security-uaen-001"
                                                    address_prefixes     =  ["10.243.50.0/24"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,  
												  
                                                  vpn_gw = {
                                                    subnet_name =  "GatewaySubnet"
                                                    address_prefixes     =  ["10.243.60.0/27"]
                                                    service_endpoints  = ["Microsoft.KeyVault"]
                                                  } ,
                                                }
}

variable "bastion_public_ip_name" {
  type          = string
  description   = "bastion public ip name"
  default       = "pip_bastion_hub-uaen-001"
}

variable "bastion_public_ip_allocation_method" {
  type          = string
  description   = "bastion public ip allocation method"
  default       = "Static"
}

variable "bastion_public_ip_sku" {
  type          = string
  description   = "bastion public sku"
  default       = "Standard"
}

variable "bastion_host_name" {
  type          = string
  description   = "bastion host name"
  default       = "bs-adxdev_hub-uaen-001"
}


variable "bootdiag_storage_account_name" {
  type          = string
  description   = "Storage Account name"
  default       = "stadxdevbootdguaen001"
}


variable "bootdiag_storage_account_tier" {
  type          = string
  description   = "bastion account tier"
  default       = "Standard"
}


variable "bootdiag_storage_account_replication_type" {
  type          = string
  description   = "Replication type"
  default       = "LRS"
}

variable "log_analytics_name" {
  type          = string
  description   = "Log Analytics"
  default       = "la-adxdev-hub-uaen-001"
}

variable "log_analytics_sku" {
  type          = string
  description   = "Analytics sku"
  default       = "PerGB2018"
}

variable "log_analytics_retention_in_days" {
  type          = number
  description   = "Analytics retention in days"
  default       = 30
}


variable "firewall_pip_name" {
type = string
description = "Firewall public ip name"
default = "pip_firewall_hub-we-001"
}



variable "firewall_pip_allocation_method"{
type = string
description = "firewall pip ip allocation method"
default = "Static"
}



variable "firewall_pip_sku" {
type = string
description = "Firewall public sku"
default = "Standard"
}



variable "firewall_name" {
type = string
description = "firewall name"
default = "azfirewall-adxdev_hub-uaen-001"
}


variable "kv_name" {
type = string
description = "Specify the Key vault Name"
default = "kv-adxdev-hub-uaen-001"
}

variable "kv_enabled_for_disk_encryption" {
type = string
description = "Key Vault enable disk encryption"
default = "false"
}
variable "kv_purge_protection_enabled" {
type = string
description = "enable purge protection"
default = "false"
}
variable "kv_soft_delete_retention_days" {
type = number
description = "Key Vault retention days after soft delete"
default = 7
}
variable "kv_sku_name" {
type = string
description = "key vault sku details"
default = "standard"
}


#variable "vnet_gateway_pip_name" {
#type = string
#description = "Specify the name of the public ip. "
#default = "pip_vgw-hub-uaen-001"
#}



#variable "vnet_gateway_pip_allocation_method" {
#type = string
#description = "Specify the allocation method of the public ip. "
#default = "Dynamic"
#}



#variable "vnet_gateway_pip_sku" {
#type = string
#description = "Specify the sku of the public ip."
#default = "Basic"
#}



#variable "virtual_network_gateway_name" {
#type = string
#description = "Specify the name of virtual network gateway"
#default = "vgw-hub-we-001"
#}



#variable "virtual_network_gateway_type" {
#type = string
#description = "Specify the type of virtual network gateway"
#default = "Vpn"
#}



#variable "virtual_network_gateway_vpn_type" {
#type = string
#description = "Specify the vpn type of virtual network gateway"
#default = "RouteBased"
#}




##variable "virtual_network_gateway_active_active" {
#type = bool
#description = "virtual network gateway active?"
#default = false
#}



##variable "virtual_network_gateway_enable_bgp" {
#type = bool
#description = "virtual network gateway bgp?"
#default = false
#}




##variable "virtual_network_gateway_sku" {
#type = string
#description = "Specify the sku type of virtual network gateway"
#default = "VpnGw2"
#}




##variable "ip_configuration_private_ip_address_allocation" {
#type = string
#description = "Specify the private ip address allocation of virtual network gateway"
#default = "Dynamic"
#}


variable "agw_pip_name" {
type = string
description = "Specify the name of the public ip. "
default = "pip_agw_hub-uaen-001"
}

variable "agw_pip_allocation_method" {
type = string
description = "Specify the allocation method of the public ip. "
default = "Static"
}



variable "agw_pip_sku" {
type = string
description = "Specify the sku of the public ip."
default = "Standard"
}




variable "application_gateway_name" {
type = string
description = "Specify the name of the application gateway."
default = "agw-adxdev-hub-uaen-001"
}



variable "application_gateway_sku_name" {
type = string
description = "Specify the sku name of the application gateway ."
default = "WAF_v2"
}



variable "application_gateway_sku_tier" {
type = string
description = "Specify the sku tier of the application gateway."
default = "WAF_v2"
}



variable "application_gateway_sku_capacity" {
type = string
description = "Specify the sku capacity of the application gateway."
default = "2"
}



variable "gateway_ip_configuration_name" {
type = string
description = "Specify the name of the ip configuration."
default = "appGatewayIpConfig"
}




variable "frontend_port_name" {
type = string
description = "Specify the name of the front end port."
default = "port_80"
}



variable "frontend_port_value" {
type = string
description = "Specify the value of the front end port."
default = "80"
}



variable "frontend_public_ip_configuration_name" {
type = string
	description = "Specify the name of the front end ip configuration name."
default= "appGwPublicFrontendIP"
}





variable "backend_address_pool_name" {
type = string
description = "Specify the name of the backend address pool."
default= "BP-pool-test"
}



variable "backend_http_setting_name" {
type = string
description = "Specify the name of the backend http setting name."
default= "HTTP-pool-test"
}

variable "backend_http_cookie_based_affinity" {
type = string
description = "Specify the name of the backend address pool."
default= "Disabled"	
}



variable "backend_http_setting_path" {
type = string
description = "Specify the name of the backend address pool."
default="/"
}



variable "backend_http_setting_port" {
type = string
description = "Specify the name of the backend address pool."
default="80"
}



variable "backend_http_setting_protocol" {
type = string
description = "Specify the name of the backend address pool."
default="Http"
}



variable "backend_http_setting_request_timeout" {
type = string
description = "Specify the name of the backend address pool."
default="60"
}



variable "http_listener_name" {
type = string
description = "Specify the name of http listener."
default="test-listner"
}



variable "http_listener_protocol" {
type = string
description = "Specify the protocal of http listener."
default="Http"
}



variable "request_routing_rule_name" {
type = string
description = "Specify the name of Request Routing rule."
default="test-rule"
}



variable "request_routing_rule_type" {
type = string
description = "Specify the name of Request Routing rule type."
default="Basic"
}

 




