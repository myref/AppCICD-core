resource "cml2_node" "server" {
  lab_id           = var.pod
  label            = "${var.name}"
  cpus             = var.cpus
  ram              = var.ram
  x                = 1000
  y                = 225-(var.c)*75-(var.y)*50
  tags             = ["edge"]
  nodedefinition   = "ubuntu"
}

resource "ansible_host" "custAcme" {
    inventory_hostname = "${var.name}"
    groups = [var.compartment_name]
    vars = {
        ansible_host = "192.168.${var.c + 5}.${var.y + 2}"
    }
}

resource "cml2_link" "compartment-server" {
  lab_id           = var.pod
  node_a           = var.compartment
  slot_a           = var.y + 1
  node_b           = cml2_node.server.id
  slot_b           = 0
} 

resource "cml2_lifecycle" "server" {
  lab_id = var.pod
  elements = [
    cml2_node.server.id,
    cml2_link.compartment-server.id
  ]
  configs = {
  }
  staging = {
    stages          = []
    start_remaining = true
  }
} 
