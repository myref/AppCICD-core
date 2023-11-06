resource "cml2_node" "compartment" {
  lab_id           = var.pod
  label            = "${var.application}-${var.environment}-${var.name}"
  x                = 720
  y                = 160-(var.y)*200
  tags             = ["compartment"]
  nodedefinition   = "unmanaged_switch"
}

resource "cml2_link" "cust_tenant-compartment" {
  lab_id           = var.pod
  node_a           = var.tenant_id
  slot_a           = var.y + 4
  node_b           = cml2_node.compartment.id
  slot_b           = 0
} 

resource "ansible_group" "compartiment" {
  inventory_group_name = var.name
  children = var.children
  vars = {
    pod                  = var.pod
    tenant_id            = var.tenant_id
    vrf                  = var.vrf
    application          = var.application
    environment          = var.environment
    name                 = var.name
    description          = var.description
    cstatus              = var.cstatus
    ctype                = var.ctype
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    y                    = var.y
  }
}

resource "cml2_lifecycle" "Compartment" {
  lab_id = var.pod
  elements = [
    cml2_node.compartment.id,
    cml2_link.cust_tenant-compartment.id
  ]

  staging = {
    stages          = ["compartment"]
    start_remaining = false
  }
} 
