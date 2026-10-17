variable "name_prefix" {
  description = "Prefix used for Private DNS zone virtual network link names."
  type        = string
}

variable "resource_group_name" {
  description = "Existing resource group for the Private DNS zones."
  type        = string
}

variable "zones" {
  description = "Private DNS zone map. Each entry has a zone_name and a map of virtual network names to IDs. Registration is disabled by default."
  type = map(object({
    zone_name = string
    vnets     = map(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags applied to Private DNS zones."
  type        = map(string)
  default     = {}
}
