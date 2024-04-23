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
resource "azurerm_linux_virtual_machine" "bad_linux_example" {
  name                            = "bad-linux-machine"
  resource_group_name             = azurerm_resource_group.rg-aks-1.name
  location                        = azurerm_resource_group.rg-aks-1.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "somePassword"
  disable_password_authentication = false
}

resource "azurerm_virtual_machine" "bad_example" {
    name                            = "bad-linux-machine"
    resource_group_name             = azurerm_resource_group.rg-aks-1.name
    location                        = azurerm_resource_group.rg-aks-1.location
    size                            = "Standard_F2"
    admin_username                  = "adminuser"
    admin_password                  = "somePassword"

    os_profile {
        computer_name  = "hostname"
        admin_username = "testadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
  }
