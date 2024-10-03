# This is the main configuration file for the module. It is used to define the resources that will be created by the module.


/*
# Importing the Azure naming module to ensure resources have unique CAF compliant names.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = " >= 0.4.0"
}



# Resource group for Prod vHUB
resource "azurerm_resource_group" "sit-rg" {
  location = local.location
  name     = local.sit_resource_group_name
}

# Resource group for Prod vHUB
resource "azurerm_resource_group" "dev-rg" {
  location = local.location
  name     = local.dev_resource_group_name
}
*/

module "avm-res-resources-resourcegroup-dev" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"
  location = var.location
  name     = "custom-dev-hub-rg"
}

module "avm-res-resources-resourcegroup-nprd" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"
  location = var.location
  name     = "custom-nprd-hub-rg"
}


module "custom_wan" {

source  = "Azure/avm-ptn-virtualwan/azurerm"
  version = "0.5.0"
  create_resource_group          = true
  resource_group_name            = var.wan_rg_name
  location                       = var.location
  virtual_wan_name               = var.wan_name
  disable_vpn_encryption         = false
  allow_branch_to_branch_traffic = true
  type                           = "Standard"
  virtual_wan_tags               = local.tags
  virtual_hubs = local.virtual_hubs
  firewalls = local.firewalls
  routing_intents = local.routing_intents
depends_on = [
    module.avm-res-resources-resourcegroup-dev,
    module.avm-res-resources-resourcegroup-nprd
]
}

