# Adding an additional block for importing the firewall policy ID
  data "terraform_remote_state" "custom-avm-res-network-firewallpolicy" {
    backend = "azurerm"

    config = {
      resource_group_name   = "custom-statestore-rg"
      storage_account_name  = "customstgacctfstatepqf"
      container_name        = "stage02"
      key                   = "custom-avm-res-network-firewallpolicy.tfstate"
    }
  }

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
      firewall_policy_id = data.terraform_remote_state.custom-avm-res-network-firewallpolicy.outputs.dev_firewall_policy_id
    },
    (var.nprd_firewall_key) = {
      firewall_key    = var.nprd_firewall_key
      name            = var.nprd_firewall_name
      virtual_hub_key = var.nprd_hub_key
      sku_name        = "AZFW_Hub"
      sku_tier        = "Standard"
      firewall_policy_id = data.terraform_remote_state.custom-avm-res-network-firewallpolicy.outputs.nprd_firewall_policy_id
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