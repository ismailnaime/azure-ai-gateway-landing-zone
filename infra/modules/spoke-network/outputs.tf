output "virtual_network_id" {
  description = "Resource ID of the spoke virtual network."
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "Name of the spoke virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Spoke subnet names mapped to their resource IDs."
  value       = { for name, subnet in azurerm_subnet.this : name => subnet.id }
}

output "route_table_id" {
  description = "Resource ID of the spoke route table, or null when route_to_firewall is disabled."
  value       = try(azurerm_route_table.this[0].id, null)
}
