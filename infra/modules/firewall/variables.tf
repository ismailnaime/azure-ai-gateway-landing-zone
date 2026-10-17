variable "name" {
  description = "Name of the Azure Firewall."
  type        = string
}

variable "location" {
  description = "Azure region for the firewall."
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group for the firewall and policy."
  type        = string
}

variable "firewall_subnet_id" {
  description = "Resource ID of the dedicated AzureFirewallSubnet in the hub VNet."
  type        = string
}

variable "sku_tier" {
  description = "Azure Firewall tier. Basic lowers capability and cost; Standard or Premium are typical enterprise tiers."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Basic, Standard, or Premium."
  }
}

variable "log_analytics_workspace_id" {
  description = "Optional Log Analytics workspace ID for firewall diagnostics."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the firewall and public IP."
  type        = map(string)
  default     = {}
}
