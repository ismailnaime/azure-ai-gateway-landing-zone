output "firewall_id" {
  description = "Resource ID of the Azure Firewall."
  value       = azurerm_firewall.this.id
}

output "firewall_private_ip" {
  description = "Private IP address to use as the next hop in spoke route tables."
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "firewall_policy_id" {
  description = "Resource ID of the firewall policy."
  value       = azurerm_firewall_policy.this.id
}

output "firewall_public_ip" {
  description = "Public IP address resource ID assigned to the firewall."
  value       = azurerm_public_ip.this.id
}

output "firewall_management_public_ip" {
  description = "Management public IP address resource ID for Azure Firewall Basic, or null for other tiers."
  value       = try(azurerm_public_ip.management[0].id, null)
}
