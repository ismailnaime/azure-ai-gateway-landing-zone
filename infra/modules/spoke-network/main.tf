resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}

resource "azurerm_route_table" "this" {
  count = var.route_to_firewall ? 1 : 0

  name                = "rt-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_route" "default_to_firewall" {
  count = var.route_to_firewall ? 1 : 0

  name                   = "default-to-hub-firewall"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.this[0].name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = var.route_to_firewall ? azurerm_subnet.this : {}

  subnet_id      = each.value.id
  route_table_id = azurerm_route_table.this[0].id
}
