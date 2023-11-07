# We now create ASG for each compartment for the customer and permit default traffic flows
# in the server definition, we must add the NIC to the ASG

resource "azurerm_application_security_group" "cust_asg" {
  name                = "cust-tenant-${var.key}_asg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "ansible_group" "compartiment" {
  inventory_group_name = var.name
  children = var.children
  vars = {
    pod                  = var.pod
    tenant               = var.tenant
    application          = var.application
    environment          = var.environment
    key                  = var.key
    name                 = var.name
    description          = var.description
    resource_group_name  = var.tenant
    location             = var.location
    cstatus              = var.cstatus
    ctype                = var.ctype
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    y                    = var.y
  }
}
