# Default policies are PA<-P, PA<-A, PA<-D, PA<-PA, PA<-AD, PA<-PAD
resource "azurerm_network_security_rule" "default_ad-with-p_in" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-P_inbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 200 + "${each.value.compartment_index}"
  direction                                     = "Inbound"
  access                                        = "Allow"
  protocol                                      = "Tcp"
  source_port_range                             = "*"
  destination_port_range                        = "*"
  resource_group_name                           = var.resource_group_name
  network_security_group_name                   = azurerm_network_security_group.compartment_default.name
  source_application_security_group_ids         = local.compartment_types_with_p
  destination_application_security_group_ids    = ["${each.value.compartment_id}"]
  for_each = {
    for key, value in var.mycompartments :
    key => value
    if value.compartment_type == "AD"
  }
}

resource "azurerm_network_security_rule" "default_ad-with-a_in" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-A_inbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 210 + "${each.value.compartment_index}"
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
    if value.compartment_type == "AD"
  }
}

resource "azurerm_network_security_rule" "default_ad-with-d_in" {
  name                                          = "Default_ruleset_${each.value.compartment_key}-D_inbound"
  description                                   = "Default rules in a standard environment"
  priority                                      = 220 + "${each.value.compartment_index}"
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
    if value.compartment_type == "AD"
  }
}
