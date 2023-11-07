#resource "azurerm_virtual_network" "compartment_vnet" {
#  name                = "${var.environments}_vnet"
#  resource_group_name = var.resource_group_name
#  location            = var.location
#  address_space       = ["192.168.0.0/17"]
#}

resource "ansible_group" "envs" {
  inventory_group_name = var.name
  children = local.compartment_names
  vars = {
    envs = "${var.environments}"
  }
}