variable "name" {
  description = "Name of the hub virtual network."
  type        = string
}

variable "location" {
  description = "Azure region for the hub network."
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group for the hub network."
  type        = string
}

variable "address_space" {
  description = "Address spaces assigned to the hub virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Hub subnet names mapped to their CIDR prefixes. Include AzureFirewallSubnet with at least /26 when deploying Azure Firewall."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags applied to the hub virtual network."
  type        = map(string)
  default     = {}
}
