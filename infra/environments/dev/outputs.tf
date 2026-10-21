output "resource_group_name" {
  description = "Development landing zone resource group."
  value       = azurerm_resource_group.this.name
}

output "hub_virtual_network_id" {
  description = "Resource ID of the hub VNet."
  value       = module.hub_network.virtual_network_id
}

output "hub_subnet_ids" {
  description = "Hub subnet IDs keyed by subnet name."
  value       = module.hub_network.subnet_ids
}

output "spoke_virtual_network_id" {
  description = "Resource ID of the workload spoke VNet."
  value       = module.spoke_network.virtual_network_id
}

output "spoke_subnet_ids" {
  description = "Spoke subnet IDs keyed by subnet name."
  value       = module.spoke_network.subnet_ids
}

output "spoke_route_table_id" {
  description = "Spoke route table ID, or null when routing through the firewall is disabled."
  value       = module.spoke_network.route_table_id
}

output "firewall_id" {
  description = "Resource ID of Azure Firewall."
  value       = module.firewall.firewall_id
}

output "firewall_private_ip" {
  description = "Private IP used as the spoke route table next hop."
  value       = module.firewall.firewall_private_ip
}

output "private_dns_zone_ids" {
  description = "Configured Private DNS zone IDs."
  value       = module.private_dns.zone_ids
}
