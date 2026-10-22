# Development environment

This Terraform root configuration creates a resource group and deploys the hub-and-spoke network foundation in it:

- Hub VNet with the required `AzureFirewallSubnet` (`/26` by default) and the Basic tier's `AzureFirewallManagementSubnet` (`/26` by default).
- Workload spoke VNet with a workload subnet.
- Azure Firewall and a spoke route table that sends the default route through it.
- Bidirectional hub/spoke VNet peering.
- Optional Private DNS zones and VNet links, configured with `private_dns_zones`.

The default address ranges are `10.0.0.0/16` for the hub and `10.1.0.0/16` for the spoke. Change them if they overlap with networks reachable from this environment. The firewall tier defaults to Basic to reduce learning-environment cost; set `firewall_sku_tier` to Standard or Premium if needed. Azure Firewall continues to incur charges while provisioned.

The firewall policy is created without allow rules. Add and review firewall rules before expecting the spoke to reach external destinations. Private DNS zones are empty by default because they should match the private endpoints actually deployed. For each zone, `vnets` maps link names to `hub`, `spoke`, or an explicit VNet resource ID.

Initialize and review the plan from this directory before applying:

```sh
terraform init
terraform plan
terraform apply
```

Set `ARM_SUBSCRIPTION_ID` or pass `-var="subscription_id=..."`, and authenticate with Azure CLI or the appropriate service principal environment variables before planning.

Terraform state is stored in the `tfstate` container of the `terraformtfstateina` storage account in `shared-ressources-inaime`, under `dev.terraform.tfstate`. The storage account and container must already exist. The backend uses Microsoft Entra OIDC authentication; the identity running Terraform needs blob data-plane access, such as **Storage Blob Data Contributor**, on the container or storage account. Run `terraform init` to initialize this backend. If migrating state that is already initialized locally, use `terraform init -migrate-state` and confirm the migration prompt.

The `Terraform dev` GitHub Actions workflow runs formatting, initialization, validation, and planning on pushes to `main` that change `infra/` or the workflow file. After the plan succeeds, the same workflow automatically applies its saved plan. Manually dispatching the workflow runs the same plan-and-apply sequence. Configure repository variables `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_SUBSCRIPTION_ID`, an Azure federated identity credential for GitHub Actions, and blob data-plane permissions for the identity. Treat the plan artifact as sensitive because it can contain infrastructure values.

The separate `Terraform dev destroy` workflow runs only when manually dispatched. It creates and applies a saved destroy plan for the resources in this Terraform state. The remote state storage account and container are not managed by this environment and are not destroyed.
