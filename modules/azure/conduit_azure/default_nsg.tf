resource "azurerm_network_security_group" "compartment_default" {
  name                = "compartment-default_nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
}