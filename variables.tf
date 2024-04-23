variable "location" {
  description = "The location where resources will be created"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the VM"
  type        = string
  default     = "tf-example-rg"
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "tf-example-vm"
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The username of the VM admin account"
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "The password of the VM admin account"
  type        = string
  default     = "Password1234!"
}

variable "subnet_id" {
  description = "The ID of the subnet in which to create the VM"
  type        = string
  default     = "/subscriptions/<subscription-id>/resourceGroups/tf-example-rg/providers/Microsoft.Network/virtualNetworks/tf-example-vnet/subnets/tf-example-subnet"
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address associated with the VM"
  type        = string
  default     = "/subscriptions/<subscription-id>/resourceGroups/tf-example-rg/providers/Microsoft.Network/publicIPAddresses/tf-example-pip"
}

variable "network_security_group_name" {
  description = "The name of the network security group associated with the VM"
  type        = string
  default     = "tf-example-nsg"
}

variable "source_image_publisher" {
  description = "The publisher of the source image for the VM"
  type        = string
  default     = "Canonical"
}

variable "source_image_offer" {
  description = "The offer of the source image for the VM"
  type        = string
  default     = "UbuntuServer"
}

variable "source_image_sku" {
  description = "The SKU of the source image for the VM"
  type        = string
  default     = "18.04-LTS"
}

variable "source_image_version" {
  description = "The version of the source image for the VM"
  type        = string
  default     = "latest"
}
