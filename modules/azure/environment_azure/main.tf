resource "azurerm_virtual_network" "compartment_vnet" {
  name                = "${var.ctype}_vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["192.168.0.0/17"]
}

application security groups