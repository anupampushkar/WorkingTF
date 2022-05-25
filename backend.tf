terraform {
   backend "azurerm" {
    resource_group_name     = "rg-adxdev_terraform_hub-uaen-001" 
      storage_account_name  = "stadxterraformuaen001"
      container_name        = "terraform"
      key                   = "hub/supreme.tfstate"
     #access_key             = ""

   }
 }
