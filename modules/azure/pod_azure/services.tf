resource "azurerm_virtual_network" "com-svc_vnet" {
  name                = "com-svc_vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.18.205.0/24", "192.168.201.0/24"]

  tags = {
    environment = "comServices"
  }
}
