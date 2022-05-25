variable "network_resource_group_name" {
  type        = string
  description = "Network components"
  default     = "rg-adxdev_hub-uaen-001"
}



variable "location" {
  type        = string
  description = "The location where the resource group should be created."
  default     = "UAE North"
}