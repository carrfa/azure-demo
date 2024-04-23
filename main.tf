provider "azurerm" {
   features {}
}
# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "rg-aks-2" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_resource_group" "rg-aks-1" {
  name     = var.resource_group_name_2
  location = var.location
}
