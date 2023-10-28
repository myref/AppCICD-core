# We now create ASG for each compartment for the customer and permit default traffic flows
# in the server definition, we must add the NIC to the ASG

resource "azurerm_application_security_group" "cust_asg" {
  name                = "cust-tenant-${var.key}_asg"
  location            = var.location
  resource_group_name = var.resource_group_name
}
