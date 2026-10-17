output "virtual_network_id" {
  description = "Resource ID of the hub virtual network."
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "Name of the hub virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Hub subnet names mapped to their resource IDs."
  value       = { for name, subnet in azurerm_subnet.this : name => subnet.id }
}
