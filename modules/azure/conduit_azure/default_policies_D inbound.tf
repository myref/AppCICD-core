# Default policies are D<-A, D<-D, D<-AD, D<-PAD
resource "azurerm_network_security_rule" "default_d-with-a_in" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-A_inbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 100 + "${each.value.compartment_index}"
  direction                                     = "Inbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "*"
  resource_group_name                           = var.resource_group_name
  network_security_group_name                   = azurerm_network_security_group.compartment_default.name
  source_application_security_group_ids         = local.compartment_types_with_a
  destination_application_security_group_ids    = ["${each.value.compartment_id}"]
  for_each = {
    for key, value in var.mycompartments :
    key => value
    if value.compartment_type == "D"
  }
}

resource "azurerm_network_security_rule" "default_d-with-d_in" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-D_inbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 110 + "${each.value.compartment_index}"
  direction                                     = "Inbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "*"
  resource_group_name                           = var.resource_group_name
  network_security_group_name                   = azurerm_network_security_group.compartment_default.name
  source_application_security_group_ids         = local.compartment_types_with_d
  destination_application_security_group_ids    = ["${each.value.compartment_id}"]
  for_each = {
    for key, value in var.mycompartments :
    key => value
    if value.compartment_type == "D"
  }
}
