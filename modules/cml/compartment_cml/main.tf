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

resource "cml2_lifecycle" "Compartment" {
  lab_id = var.pod
  elements = [
    cml2_node.compartment.id,
    cml2_link.cust_tenant-compartment.id
  ]
  configs = {
    "${var.vrf}":    templatefile("modules/cml/compartment_cml/configs/compartment_interface.cfg", {
       interface      = var.y + 5
       description    = var.description
       vrf            = var.ctype
       subnet         = var.y + 1
       })
  }
  staging = {
    stages          = ["compartment"]
    start_remaining = false
  }
} 
