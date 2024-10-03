<!-- BEGIN_TF_DOCS -->
> [!IMPORTANT]
> This script utilizes the Azure Verified Modules (AVM) and can be leveraged for all types of environments (development, testing, production, etc.). The input parameters provided in this repository are examples. While using this repository one should carefully review their environment specific requirements and adjust the parameters accordingly.

> [!IMPORTANT]
> The author assumes no responsibility for any breaking changes that may occur. Any feedback or issues related to the AVM should be reported to the respective module's GitHub repository.


# Azure Virtual WAN with Viruta kHub Networking using Azure Verified Modules

This module is designed to simplify the creation of virtual wan based networks in Azure.

## Components deployed

- Virtual WAN
- Virtual Hub [secureHub][multiple : dev,prod,sbx,etc.]
- Routing Intent [multiple : dev,prod,sbx,etc.]
- Azure Firewall [multiple : dev,prod,sbx,etc.]

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_allow_branch_to_branch_traffic"></a> [allow\_branch\_to\_branch\_traffic](#input\_allow\_branch\_to\_branch\_traffic)

Description: Switch to flip VWAN branch to branch traffic

Type: `bool`

### <a name="input_location"></a> [location](#input\_location)

Description: Virtual WAN location

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Virtual WAN Resource group name

Type: `string`

### <a name="input_virtual_wan_name"></a> [virtual\_wan\_name](#input\_virtual\_wan\_name)

Description: Virtual WAN name

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group)

Description: If true will create a resource group, otherwise will use the existing resource group supplied in resource\_group\_name

Type: `bool`

Default: `false`

### <a name="input_disable_vpn_encryption"></a> [disable\_vpn\_encryption](#input\_disable\_vpn\_encryption)

Description: Switch to flip VWAN vpn encryption

Type: `bool`

Default: `false`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see https://aka.ms/avm/telemetryinfo.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_er_circuit_connections"></a> [er\_circuit\_connections](#input\_er\_circuit\_connections)

Description: Mapping object to link ER circuits to ER Gateways for the creation of connection

Type:

```hcl
map(object({
    name                                 = string
    express_route_gateway_key            = string
    express_route_circuit_peering_id     = string
    authorization_key                    = optional(string)
    enable_internet_security             = optional(bool)
    express_route_gateway_bypass_enabled = optional(bool)
    routing = optional(object({
      associated_route_table_id = string
      propagated_route_table = optional(object({
        route_table_ids = optional(list(string))
        labels          = optional(list(string))
      }))
      inbound_route_map_id  = optional(string)
      outbound_route_map_id = optional(string)
    }))
    routing_weight = optional(number)
  }))
```

Default: `{}`

### <a name="input_expressroute_gateways"></a> [expressroute\_gateways](#input\_expressroute\_gateways)

Description: Express Route Gateway parameters

Type:

```hcl
map(object({
    name                          = string
    virtual_hub_key               = string
    tags                          = optional(map(string))
    allow_non_virtual_wan_traffic = optional(bool)
    scale_units                   = number
  }))
```

Default: `{}`

### <a name="input_firewalls"></a> [firewalls](#input\_firewalls)

Description: Azure Firewall parameters

Type:

```hcl
map(object({
    virtual_hub_key      = string
    sku_name             = string
    sku_tier             = string
    name                 = optional(string)
    dns_servers          = optional(list(string))
    firewall_policy_id   = optional(string)
    private_ip_ranges    = optional(list(string))
    threat_intel_mode    = optional(string, "Alert")
    zones                = optional(list(string))
    vhub_public_ip_count = optional(string)
    tags                 = optional(map(string))
    default_ip_configuration = optional(object({
      name = optional(string)
      public_ip_config = optional(object({
        name       = optional(set(string))
        zones      = optional(set(string))
        ip_version = optional(string)
        sku_tier   = optional(string, "Regional")
      }))
    }))
    management_ip_configuration = optional(object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }))
    ip_configuration = optional(object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }))
  }))
```

Default: `{}`

### <a name="input_office365_local_breakout_category"></a> [office365\_local\_breakout\_category](#input\_office365\_local\_breakout\_category)

Description: Specifies the Office365 local breakout category. Possible values include: Optimize, OptimizeAndAllow, All, None. Defaults to None

Type: `string`

Default: `"None"`

### <a name="input_p2s_gateway_vpn_server_configurations"></a> [p2s\_gateway\_vpn\_server\_configurations](#input\_p2s\_gateway\_vpn\_server\_configurations)

Description: P2S VPN Gateway server configuration parameters

Type:

```hcl
map(object({
    name                     = string
    virtual_hub_key          = string
    vpn_authentication_types = list(string)
    tags                     = optional(map(string))
    client_root_certificate = optional(object({
      name             = string
      public_cert_data = string
    }))
    azure_active_directory_authentication = optional(object({
      audience = string
      issuer   = string
      tenant   = string
    }))
    ipsec_policy = optional(object({
      dh_group               = string
      ike_encryption         = string
      ike_integrity          = string
      ipsec_encryption       = string
      ipsec_integrity        = string
      pfs_group              = string
      sa_lifetime_seconds    = string
      sa_data_size_kilobytes = string
    }))
    vpn_protocols = optional(list(string))
  }))
```

Default: `{}`

### <a name="input_p2s_gateways"></a> [p2s\_gateways](#input\_p2s\_gateways)

Description: P2S VPN Gateway parameters

Type:

```hcl
map(object({
    name                                     = string
    virtual_hub_key                          = string
    tags                                     = optional(map(string))
    p2s_gateway_vpn_server_configuration_key = string
    connection_configuration = object({
      name = string
      vpn_client_address_pool = object({
        address_prefixes = list(string)
      })
    })
    routing_preference                  = optional(string)
    scale_unit                          = number
    dns_servers                         = optional(list(string))
    routing_preference_internet_enabled = optional(bool)
  }))
```

Default: `{}`

### <a name="input_resource_group_tags"></a> [resource\_group\_tags](#input\_resource\_group\_tags)

Description: Virtual WAN Resource group tags

Type: `map(string)`

Default: `{}`

### <a name="input_routing_intents"></a> [routing\_intents](#input\_routing\_intents)

Description: Routing intent for virutal hubs

Type:

```hcl
map(object({
    name            = string
    virtual_hub_key = string
    routing_policies = list(object({
      name                  = string
      destinations          = list(string)
      next_hop_firewall_key = string
    }))
  }))
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### <a name="input_type"></a> [type](#input\_type)

Description: Type of the virtual WAN

Type: `string`

Default: `"Standard"`

### <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs)

Description: Virtual Hub parameters

Type:

```hcl
map(object({
    name                   = string
    location               = string
    resource_group         = optional(string, null)
    address_prefix         = string
    tags                   = optional(map(string))
    hub_routing_preference = optional(string)
  }))
```

Default: `{}`

### <a name="input_virtual_network_connections"></a> [virtual\_network\_connections](#input\_virtual\_network\_connections)

Description: Azure virtual network connections

Type:

```hcl
map(object({
    name                      = string
    virtual_hub_key           = string
    remote_virtual_network_id = string
    internet_security_enabled = optional(bool, false)
    routing = optional(object({
      associated_route_table_id = string
      propagated_route_table = optional(object({
        route_table_ids = optional(list(string), [])
        labels          = optional(list(string), [])
      }))
      static_vnet_route = optional(object({
        name                = optional(string)
        address_prefixes    = optional(list(string), [])
        next_hop_ip_address = optional(string)
      }))
    }))
  }))
```

Default: `{}`

### <a name="input_virtual_wan_tags"></a> [virtual\_wan\_tags](#input\_virtual\_wan\_tags)

Description: Virtual WAN tags

Type: `map(string)`

Default: `{}`

### <a name="input_vpn_gateways"></a> [vpn\_gateways](#input\_vpn\_gateways)

Description: S2S VPN Gateway parameters

Type:

```hcl
map(object({
    name                                  = string
    virtual_hub_key                       = string
    tags                                  = optional(map(string))
    bgp_route_translation_for_nat_enabled = optional(bool)
    bgp_settings = optional(object({
      asn                            = number
      instance_0_bgp_peering_address = optional(string)
      instance_1_bgp_peering_address = optional(string)
      peer_weight                    = number
    }))
    routing_preference = optional(string)
    scale_unit         = optional(number)
  }))
```

Default: `{}`

### <a name="input_vpn_site_connections"></a> [vpn\_site\_connections](#input\_vpn\_site\_connections)

Description: S2S VPN Site Connections parameter

Type:

```hcl
map(object({
    name                = string
    vpn_gateway_key     = string
    remote_vpn_site_key = string
    vpn_links = list(object({
      name                 = string
      egress_nat_rule_ids  = optional(list(string))
      ingress_nat_rule_ids = optional(list(string))
      # Index of the link on the vpn gateway
      vpn_site_link_number = number
      bandwidth_mbps       = optional(number)
      bgp_enabled          = optional(bool)
      connection_mode      = optional(string)

      ipsec_policy = optional(object({
        dh_group                 = string
        ike_encryption_algorithm = string
        ike_integrity_algorithm  = string
        encryption_algorithm     = string
        integrity_algorithm      = string
        pfs_group                = string
        sa_data_size_kb          = string
        sa_lifetime_sec          = string
      }))
      protocol                              = optional(string)
      ratelimit_enabled                     = optional(bool)
      route_weight                          = optional(number)
      shared_key                            = optional(string)
      local_azure_ip_address_enabled        = optional(bool)
      policy_based_traffic_selector_enabled = optional(bool)
      custom_bgp_address = optional(list(object({
        ip_address          = string
        ip_configuration_id = string
      })))
    }))
    internet_security_enabled = optional(bool)
    routing = optional(object({
      associated_route_table = string
      propagated_route_table = optional(object({
        route_table_ids = optional(list(string))
        labels          = optional(list(string))
      }))
      inbound_route_map_id  = optional(string)
      outbound_route_map_id = optional(string)
    }))
    traffic_selector_policy = optional(object({
      local_address_ranges  = string
      remote_address_ranges = string
    }))
  }))
```

Default: `{}`

### <a name="input_vpn_sites"></a> [vpn\_sites](#input\_vpn\_sites)

Description: S2S VPN Sites parameter

Type:

```hcl
map(object({
    name = string
    # Name of the virtual hub
    virtual_hub_key = string
    links = list(object({
      name = string
      bgp = optional(object({
        asn             = number
        peering_address = string
      }))
      fqdn          = optional(string)
      ip_address    = optional(string)
      provider_name = optional(string)
      speed_in_mbps = optional(number)
      }
    ))
    address_cidrs = optional(list(string))
    device_model  = optional(string)
    device_vendor = optional(string)
    o365_policy = optional(object({
      traffic_category = object({
        allow_endpoint_enabled    = optional(bool)
        default_endpoint_enabled  = optional(bool)
        optimize_endpoint_enabled = optional(bool)
      })
    }))
    tags = optional(map(string))
  }))
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_azure_firewall_resource_ids"></a> [azure\_firewall\_resource\_ids](#output\_azure\_firewall\_resource\_ids)

Description: A map of Azure Firewall resource IDs with the map keys of the `firewalls` variable.

### <a name="output_azure_firewall_resource_names"></a> [azure\_firewall\_resource\_names](#output\_azure\_firewall\_resource\_names)

Description: A map of Azure Firewall resource names with the map keys of the `firewalls` variable.

### <a name="output_er_gw_id"></a> [er\_gw\_id](#output\_er\_gw\_id)

Description: ExpressRoute Gateway ID

### <a name="output_expressroute_gateway_resource_ids"></a> [expressroute\_gateway\_resource\_ids](#output\_expressroute\_gateway\_resource\_ids)

Description: A map of expressRoute Gateway IDs with the map keys of the `expressroute_gateways` variable.

### <a name="output_expressroute_gateway_resource_names"></a> [expressroute\_gateway\_resource\_names](#output\_expressroute\_gateway\_resource\_names)

Description: A map of expressRoute Gateway names with the map keys of the `expressroute_gateways` variable.

### <a name="output_fw"></a> [fw](#output\_fw)

Description: Firewall Name

### <a name="output_p2s_vpn_gw_id"></a> [p2s\_vpn\_gw\_id](#output\_p2s\_vpn\_gw\_id)

Description: P2S VPN Gateway ID

### <a name="output_p2s_vpn_gw_resource_ids"></a> [p2s\_vpn\_gw\_resource\_ids](#output\_p2s\_vpn\_gw\_resource\_ids)

Description: A map of point to site VPN gateway names with the map keys of the `p2s_gateways` variable.

### <a name="output_p2s_vpn_gw_resource_names"></a> [p2s\_vpn\_gw\_resource\_names](#output\_p2s\_vpn\_gw\_resource\_names)

Description: A map of point to site VPN gateway names with the map keys of the `p2s_gateways` variable.

### <a name="output_resource"></a> [resource](#output\_resource)

Description: The full resource outputs.

### <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name)

Description: Resource Group Name

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: Virtual WAN ID

### <a name="output_s2s_vpn_gw"></a> [s2s\_vpn\_gw](#output\_s2s\_vpn\_gw)

Description: S2S VPN Gateway Objects

### <a name="output_s2s_vpn_gw_id"></a> [s2s\_vpn\_gw\_id](#output\_s2s\_vpn\_gw\_id)

Description: S2S VPN Gateway ID

### <a name="output_virtual_hub_id"></a> [virtual\_hub\_id](#output\_virtual\_hub\_id)

Description: Virtual Hub ID

### <a name="output_virtual_hub_resource_ids"></a> [virtual\_hub\_resource\_ids](#output\_virtual\_hub\_resource\_ids)

Description: A map of Azure Virtual Hub resource IDs with the map keys of the `virtual_hubs` variable.

### <a name="output_virtual_hub_resource_names"></a> [virtual\_hub\_resource\_names](#output\_virtual\_hub\_resource\_names)

Description: A map of Azure Virtual Hub resource names with the map keys of the `virtual_hubs` variable.

### <a name="output_virtual_wan_id"></a> [virtual\_wan\_id](#output\_virtual\_wan\_id)

Description: Virtual WAN ID

### <a name="output_vpn_gateway_resource_ids"></a> [vpn\_gateway\_resource\_ids](#output\_vpn\_gateway\_resource\_ids)

Description: A map of Azure VPN Gateway resource IDs with the map keys of the `vpn_gateways` variable.

### <a name="output_vpn_gateway_resource_names"></a> [vpn\_gateway\_resource\_names](#output\_vpn\_gateway\_resource\_names)

Description: A map of Azure VPN Gateway resource names with the map keys of the `vpn_gateways` variable.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->

