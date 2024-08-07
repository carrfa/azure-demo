# ID 14
location        = "westeurope"
resource_group_name = "tf-example-rg"
vm_name          = "tf-example-vm"
vm_size          = "Standard_B1s"
admin_username   = "adminuser"
admin_password   = "Password1234!"
subnet_id        = "/subscriptions/<subscription-id>/resourceGroups/tf-example-rg/providers/Microsoft.Network/virtualNetworks/tf-example-vnet/subnets/tf-example-subnet"
public_ip_address_id = "/subscriptions/<subscription-id>/resourceGroups/tf-example-rg/providers/Microsoft.Network/publicIPAddresses/tf-example-pip"
network_security_group_name = "tf-example-nsg"
source_image_publisher = "Canonical"
source_image_offer = "UbuntuServer"
source_image_sku = "18.04-LTS"
source_image_version = "latest"
