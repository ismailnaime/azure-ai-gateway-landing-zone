resource "azurerm_private_dns_zone" "this" {
  for_each = var.zones

  name                = each.value.zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

locals {
  vnet_links = merge({}, [
    for zone_key, zone in var.zones : {
      for vnet_name, vnet_id in zone.vnets : "${zone_key}/${vnet_name}" => {
        zone_key  = zone_key
        vnet_name = vnet_name
        vnet_id   = vnet_id
      }
    }
  ]...)
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.vnet_links

  name                  = "${var.name_prefix}-${each.value.vnet_name}-${each.value.zone_key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.zone_key].name
  virtual_network_id    = each.value.vnet_id
  registration_enabled  = false
  tags                  = var.tags
}
