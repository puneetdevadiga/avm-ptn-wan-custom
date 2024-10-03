# This file contains the variables that are used in the main configuration file.


# Vartiable for primary location
variable "location" {
  type        = string
  description = "Sets the location for the resources to be created in."
  default = "southeastasia"
}

# Vartiable for resource tagging
variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default = {
    environment = "Common Network Services"
    owner       = "Network Team"
  }
}

########## vWAN Variables ##########
variable "wan_rg_name" {
    description = "vWAN resource group name"
    type    = string
    default = "custom-wan-rg"
}

# Vartiable for vWAN name
variable "wan_name" {
    description = "vWAN name"
    type    = string
    default = "custom-vwan"
}


########## DEV vHUB Variables ##########

variable "devhub_rg_name" {
    description = "DEV vHUB resource group name"
    type    = string
    default = "custom-dev-hub-rg"
}

variable "dev_hub_name" {
    description = "DEV vHUB name"
    type    = string
    default = "dev-vhub"
}

variable "dev_hub_key" {
    description = "DEV vHUB key"
    type    = string
    default = "dev-vhub"
}

# Vartiable for dev hub CIDR
variable "dev_hub_cidr" {
  description = "The address prefix for DEV vHUB"
  type        = string
  default     = "10.1.0.0/24"
}

variable "dev_firewall_key" {
  description = "DEV firewall Key"
  type        = string
  default     = "dev-fw"
}

variable "dev_firewall_name" {
  description = "DEV firewall name"
  type        = string
  default     = "dev-fw"
}

variable "dev_routing_intent_key" {
  description = "The key for the routing intent"
  type        = string
  default     = "dev-vhub-routing-intent"
}

variable "dev_routing_intent_name" {
  description = "The name of the routing intent"
  type        = string
  default     = "dev-private-routing-intent-1"
}

variable "dev_routing_policy_name" {
  description = "The name of the routing policy"
  type        = string
  default     = "dev-vhub-routing-policy-private"
}

########## NPRD vHUB Variables ##########

# Vartiable for resource group name to host nrpd vHUB 
variable "nprdhub_rg_name" {
    description = "NPRD vHUB resource group name"
    type    = string
    default = "custom-nprd-hub-rg"
}

variable "nprd_hub_name" {
    description = "NPRD vHUB name"
    type    = string
    default = "nprd-vhub"
}

variable "nprd_hub_key" {
    description = "NPRD vHUB key"
    type    = string
    default = "nprd-vhub"
}

variable "nprd_hub_cidr" {
  description = "The address prefix for the network"
  type        = string
  default     = "10.2.0.0/24"
}

variable "nprd_firewall_key" {
  description = "The key for the firewall"
  type        = string
  default     = "nprd-fw"
}

variable "nprd_firewall_name" {
  description = "The name of the firewall"
  type        = string
  default     = "nprd-fw"
}

variable "nprd_routing_intent_key" {
  description = "The key for the routing intent"
  type        = string
  default     = "nprd-vhub-routing-intent"
}

variable "nprd_routing_intent_name" {
  description = "The name of the routing intent"
  type        = string
  default     = "nprd-private-routing-intent-1"
}

variable "nprd_routing_policy_name" {
  description = "The name of the routing policy"
  type        = string
  default     = "nprd-vhub-routing-policy-private"
}
