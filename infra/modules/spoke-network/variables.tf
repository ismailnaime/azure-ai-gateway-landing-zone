variable "name" {
  description = "Name of the spoke virtual network."
  type        = string
}

variable "location" {
  description = "Azure region for the spoke network."
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group for the spoke network."
  type        = string
}

variable "address_space" {
  description = "Address spaces assigned to the spoke virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Spoke subnet names mapped to their CIDR prefixes."
  type        = map(string)
}

variable "firewall_private_ip" {
  description = "Private IP address of the hub firewall used for the spoke default route. Required when route_to_firewall is true."
  type        = string
  default     = null
}

variable "route_to_firewall" {
  description = "Create and associate a route table sending 0.0.0.0/0 to the hub firewall."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the spoke virtual network and route table."
  type        = map(string)
  default     = {}

  validation {
    condition     = !var.route_to_firewall || (var.firewall_private_ip != null && can(cidrhost("${var.firewall_private_ip}/32", 0)))
    error_message = "Set firewall_private_ip to a valid IPv4 address when route_to_firewall is true."
  }
}
