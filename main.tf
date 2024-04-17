terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }
}
provider "azurerm" {
  features {}
  use_oidc = true
  skip_provider_registration = true
}

# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "rg-aks-3" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_resource_group" "rg-aks-2" {
  name     = var.resource_group_name_2
  location = var.location
}
