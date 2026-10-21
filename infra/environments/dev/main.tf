resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "hub_network" {
  source = "../../modules/hub-network"

  name                = var.hub_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.hub_address_space
  subnets             = var.hub_subnets
  tags                = var.tags
}

module "spoke_network" {
  source = "../../modules/spoke-network"

  name                = var.spoke_name
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.spoke_address_space
  subnets             = var.spoke_subnets
  route_to_firewall   = var.route_spoke_to_firewall
  firewall_private_ip = var.route_spoke_to_firewall ? module.firewall.firewall_private_ip : null
  tags                = var.tags
}

module "firewall" {
  source = "../../modules/firewall"

  name                = "afw-ai-gateway-dev"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  firewall_subnet_id  = module.hub_network.subnet_ids["AzureFirewallSubnet"]
  sku_tier            = var.firewall_sku_tier
  tags                = var.tags
}

module "hub_spoke_peering" {
  source = "../../modules/vnet-peering"

  hub_name                  = module.hub_network.virtual_network_name
  hub_resource_group_name   = azurerm_resource_group.this.name
  hub_virtual_network_id    = module.hub_network.virtual_network_id
  spoke_name                = module.spoke_network.virtual_network_name
  spoke_resource_group_name = azurerm_resource_group.this.name
  spoke_virtual_network_id  = module.spoke_network.virtual_network_id
}

module "private_dns" {
  source = "../../modules/private-dns"

  name_prefix         = "dns-ai-gateway-dev"
  resource_group_name = azurerm_resource_group.this.name
  zones               = local.private_dns_zones
  tags                = var.tags
}

locals {
  private_dns_zones = {
    for zone_key, zone in var.private_dns_zones : zone_key => {
      zone_name = zone.zone_name
      vnets = {
        for vnet_key, vnet_selector in zone.vnets : vnet_key => (
          vnet_selector == "hub" ? module.hub_network.virtual_network_id :
          vnet_selector == "spoke" ? module.spoke_network.virtual_network_id :
          vnet_selector
        )
      }
    }
  }
}
