terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "shared-ressources-inaime"
    storage_account_name = "terraformtfstateina"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    use_oidc             = true
    use_azuread_auth     = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
