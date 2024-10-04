# This implementation considers storing terraform state in a separate storage account and container. 
#Please replace the values of resource_group_name, storage_account_name, container_name, and key with the values that you have used in your implementation.

# backend.tf 
terraform {
  backend "azurerm" {
    resource_group_name   = "custom-statestore-rg"    
    storage_account_name  = "customstgacctfstatepqf"
    container_name        = "stage02"
    key                   = "custom-avm-ptn-wan.tfstate"
  }
}