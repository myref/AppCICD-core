# Default policies are P->A, P->PA, P->PAD
resource "azurerm_network_security_rule" "default_p-with-p_out" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-P_outbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 300 + "${each.value.compartment_index}"
  direction                                     = "Outbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "*"
  resource_group_name                           = var.resource_group_name
  network_security_group_name                   = azurerm_network_security_group.compartment_default.name
  source_application_security_group_ids         = ["${each.value.compartment_id}"]
  for_each = {
    for key, value in var.mycompartments :
    key => value
    if value.compartment_type == "P"
  }
  destination_application_security_group_ids    = local.compartment_types_with_p
}

resource "azurerm_network_security_rule" "default_p-with-a_out" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-A_outbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 310 + "${each.value.compartment_index}"
  direction                                     = "Outbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "*"
  resource_group_name                           = var.resource_group_name
  network_security_group_name                   = azurerm_network_security_group.compartment_default.name
  source_application_security_group_ids         = ["${each.value.compartment_id}"]
  for_each = {
    for key, value in var.mycompartments :
    key => value
    if value.compartment_type == "P"
  }
  destination_application_security_group_ids    = local.compartment_types_with_a
}
