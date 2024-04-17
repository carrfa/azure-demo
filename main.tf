provider "azurerm" {
   features {}
}
# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "rg-aks-3" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_machine" "vm" {
  name                  = "my-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg-aks.name
  vm_size               = "Standard_DS2_v2"
  network_interface_ids = [azurerm_network_interface.nic.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "my-vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "my-vm"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-aks.name

  ip_configuration {
    name                          = "my-nic-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.rg-aks.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-aks.name
  address_space       = ["10.0.0.0/16"]
}