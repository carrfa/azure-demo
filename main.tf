#ID 22
provider "azurerm" {
  features {}
}

module "terraform-azurerm-virtual-machine" {
  source  = "spacelift.io/carrfa/terraform-azurerm-virtual-machine/default"
  version = "0.1.0"

  # Required inputs 
  image_os            = "linux"
  location            = azurerm_resource_group.rg.location
  name                = "tf-fca-vm-module"
  os_simple = "UbuntuServer"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  subnet_id           = azurerm_subnet.subnet.id
}

resource "azurerm_resource_group" "rg" {
  name     = "tf-fca-rg"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tf-fca-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "tf-fca-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "tf-fca-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_rule" "rule" {
  name                        = "tf-fca-rule"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "10.0.0.0/16"
}

resource "azurerm_public_ip" "pip" {
  name                = "tf-fca-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "tf-fca-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "tf-example-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

/*
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "tf-fca-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "Password1234!"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
*/
