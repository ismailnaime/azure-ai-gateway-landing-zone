variable "subscription_id" {
  description = "Azure subscription ID. If omitted, set ARM_SUBSCRIPTION_ID in the environment."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for the development landing zone."
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group created for the development landing zone."
  type        = string
  default     = "rg-ai-gateway-dev"
}

variable "hub_name" {
  description = "Name of the hub virtual network."
  type        = string
  default     = "vnet-ai-gateway-hub-dev"
}

variable "spoke_name" {
  description = "Name of the workload spoke virtual network."
  type        = string
  default     = "vnet-ai-gateway-spoke-dev"
}

variable "hub_address_space" {
  description = "CIDR ranges assigned to the hub VNet."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "hub_subnets" {
  description = "Hub subnet names mapped to CIDR ranges. AzureFirewallSubnet must be at least /26."
  type        = map(string)
  default = {
    AzureFirewallSubnet = "10.0.0.0/26"
  }
}

variable "spoke_address_space" {
  description = "CIDR ranges assigned to the workload spoke VNet."
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "spoke_subnets" {
  description = "Workload spoke subnet names mapped to CIDR ranges."
  type        = map(string)
  default = {
    workload = "10.1.0.0/24"
  }
}

variable "firewall_sku_tier" {
  description = "Azure Firewall tier. Basic is lower cost for learning; Standard and Premium provide additional capabilities."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.firewall_sku_tier)
    error_message = "firewall_sku_tier must be Basic, Standard, or Premium."
  }
}

variable "route_spoke_to_firewall" {
  description = "Send the spoke's default route through the hub firewall."
  type        = bool
  default     = true
}

variable "private_dns_zones" {
  description = "Optional Private DNS zones and VNet links. Supply only zones needed by deployed private endpoints."
  type = map(object({
    zone_name = string
    vnets     = map(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags applied to resources in this environment."
  type        = map(string)
  default = {
    environment = "dev"
    project     = "azure-ai-gateway-landing-zone"
  }
}
