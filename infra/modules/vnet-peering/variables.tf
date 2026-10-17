variable "hub_name" {
  description = "Hub virtual network name."
  type        = string
}

variable "hub_resource_group_name" {
  description = "Resource group containing the hub VNet."
  type        = string
}

variable "hub_virtual_network_id" {
  description = "Resource ID of the hub VNet."
  type        = string
}

variable "spoke_name" {
  description = "Spoke virtual network name."
  type        = string
}

variable "spoke_resource_group_name" {
  description = "Resource group containing the spoke VNet."
  type        = string
}

variable "spoke_virtual_network_id" {
  description = "Resource ID of the spoke VNet."
  type        = string
}
