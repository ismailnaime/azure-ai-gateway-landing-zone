# Azure AI Gateway Landing Zone

Terraform learning project for an Azure hub-and-spoke landing zone that will later host an AI gateway workload.

## Current state

The repository currently contains reusable network modules only. The development environment files are empty placeholders. No Azure infrastructure has been deployed, and the modules are not yet composed into a deployable root stack.

## Network modules

- `infra/modules/hub-network`: hub VNet and configurable subnets.
- `infra/modules/spoke-network`: spoke VNet, subnets, and optional default route through Azure Firewall.
- `infra/modules/firewall`: Azure Firewall, public IP, firewall policy, and optional diagnostics.
- `infra/modules/vnet-peering`: bidirectional VNet peering.
- `infra/modules/private-dns`: Private DNS zones and explicit VNet links.

See [module notes](infra/modules/README.md) for dependency order and operational caveats.

## Planned delivery sequence

1. Compose the development root stack and choose the address plan.
2. Add monitoring and explicit firewall rules.
3. Bootstrap remote Terraform state.
4. Configure GitHub Actions OIDC with narrowly scoped Azure roles.
5. Add the APIM and Microsoft Foundry workload after validating region and quota.

## Safety

Do not commit Terraform state, plan files, local variable files, credentials, or client secrets. Review every Terraform plan before applying it. The current firewall policy has no allow rules, so traffic will be denied until explicit rules are configured.
