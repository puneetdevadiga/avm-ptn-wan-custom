locals {
    tags = {
    environment = "common"
    owner       = "Network Team"
  }

  # Virtual Hubs Configuration
  virtual_hubs = {
    (var.dev_hub_key) = {
      virtual_hub_key = var.dev_hub_key
      name            = var.dev_hub_name
      location        = var.location
      resource_group  = var.devhub_rg_name
      address_prefix  = var.dev_hub_cidr
      tags            = var.tags
    },
    (var.nprd_hub_key) = {
      virtual_hub_key = var.nprd_hub_key
      name            = var.nprd_hub_name
      location        = var.location
      resource_group  = var.nprdhub_rg_name
      address_prefix  = var.nprd_hub_cidr
      tags            = var.tags
    }
   }

  # Firewall Configuration for each hub
  firewalls = {
    (var.dev_firewall_key) = {
      firewall_key    = var.dev_firewall_key
      name            = var.dev_firewall_name
      virtual_hub_key = var.dev_hub_key
      sku_name        = "AZFW_Hub"
      sku_tier        = "Standard"
    },
    (var.nprd_firewall_key) = {
      firewall_key    = var.nprd_firewall_key
      name            = var.nprd_firewall_name
      virtual_hub_key = var.nprd_hub_key
      sku_name        = "AZFW_Hub"
      sku_tier        = "Standard"
    }
  }

  # Routing Intents for each hub
  routing_intents = {
    (var.dev_routing_intent_key) = {
      name            = var.dev_routing_intent_name
      virtual_hub_key = var.dev_hub_key
      routing_policies = [{
        name                  = var.dev_routing_policy_name
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = var.dev_firewall_key
      }]
    },
    (var.nprd_routing_intent_key) = {
      name            = var.nprd_routing_intent_name
      virtual_hub_key = var.nprd_hub_key
      routing_policies = [{
        name                  = var.nprd_routing_policy_name
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = var.nprd_firewall_key
      }]
    }
  }
}