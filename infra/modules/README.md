# Network modules

These local modules are building blocks for a hub-and-spoke workload landing zone. They do not deploy anything until called by a Terraform root configuration.

## Modules

- `hub-network`: hub VNet and caller-defined subnets. Define `AzureFirewallSubnet` as at least `/26` for Azure Firewall, and `AzureFirewallManagementSubnet` as at least `/26` when using the Basic tier.
- `spoke-network`: spoke VNet, subnets, and an optional default route through the firewall.
- `firewall`: Azure Firewall, Standard static public IP, firewall policy, and optional Log Analytics diagnostics.
- `vnet-peering`: both directions of a hub/spoke peering with forwarded traffic enabled.
- `private-dns`: Private DNS zones and links to supplied VNets, with auto-registration disabled.

## Intended dependency order

1. Create hub and spoke VNets.
2. Create the firewall in the hub `AzureFirewallSubnet`.
3. Create spoke route tables using the firewall private IP.
4. Create hub/spoke peerings.
5. Create Private DNS zones and link the hub and required spokes.

The modules accept existing resource groups; resource-group lifecycle and subscription-level governance belong in the environment composition or a separate foundation module.

## Cost and operational notes

Azure Firewall is billed while provisioned, with additional data-processing charges. The default tier in the module is Standard; set `sku_tier = "Basic"` for a lower-cost learning configuration where its feature limits are acceptable. Check current regional pricing before applying. Keep a teardown plan for non-production environments.

Firewall policy starts without allow rules. Add explicit, reviewed network/application rules before expecting traffic to pass. Diagnostics are optional and require a Log Analytics workspace; workspace ingestion and retention can also incur charges.

Private DNS zones should be selected for the private endpoints actually deployed. Do not link every zone to every network by default; use the least set of links required by name resolution.
