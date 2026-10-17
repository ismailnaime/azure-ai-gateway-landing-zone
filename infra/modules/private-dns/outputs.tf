output "zone_ids" {
  description = "Private DNS zone keys mapped to their resource IDs."
  value       = { for key, zone in azurerm_private_dns_zone.this : key => zone.id }
}

output "vnet_link_ids" {
  description = "Private DNS zone and VNet keys mapped to link resource IDs."
  value       = { for key, link in azurerm_private_dns_zone_virtual_network_link.this : key => link.id }
}
