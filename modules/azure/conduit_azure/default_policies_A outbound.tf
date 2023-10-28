# Default policies are A->P, A->A, A->D, A->PA, A->AD, A->D, A->PAD
resource "azurerm_network_security_rule" "default_a-with-p_out" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-P_outbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 350 + "${each.value.compartment_index}"
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
    if value.compartment_type == "A"
  }
  destination_application_security_group_ids    = local.compartment_types_with_p
}

resource "azurerm_network_security_rule" "default_a-with-a_out" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-A_outbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 360 + "${each.value.compartment_index}"
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
    if value.compartment_type == "A"
  }
  destination_application_security_group_ids    = local.compartment_types_with_a
}

resource "azurerm_network_security_rule" "default_a-with-d_out" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-D_outbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 370 + "${each.value.compartment_index}"
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
    if value.compartment_type == "A"
  }
  destination_application_security_group_ids    = local.compartment_types_with_d
}
