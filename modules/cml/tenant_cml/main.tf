resource "cml2_node" "bkn" {
  lab_id           = var.pod
  label            = "BKN"
  x                = 400
  y                = -250
  tags             = ["customer"]
  nodedefinition   = "external_connector"
  configuration    = "NAT"
}

resource "cml2_node" "cust_fw" {
  lab_id           = var.pod
  label            = "${var.name}_fw"
  x                = 400
  y                = -120
  tags             = ["customer"]
  nodedefinition   = "asav"
}

resource "cml2_link" "cust_fw-bkn" {
  lab_id           = var.pod
  node_a           = cml2_node.cust_fw.id
  slot_a           = 1
  node_b           = cml2_node.bkn.id
  slot_b           = 0
} 

resource "cml2_node" "cust_tenant" {
  lab_id           = var.pod
  label            = "cust_${var.name}"
  x                = 400
  y                = 120
  tags             = ["customer"]
  nodedefinition   = "csr1000v"
}

resource "ansible_group" "ACME" {
  inventory_group_name = var.name
  children = [var.application]
  vars = {
   }
}

resource "ansible_host" "custAcme" {
    inventory_hostname = "custAcme"
    groups = [var.name]
    vars = {
        ansible_host = "192.168.202.150"
        lo0          = "192.168.254.150"
    }
}

resource "cml2_link" "cust_fw-cust_tenant" {
  lab_id           = var.pod
  node_a           = cml2_node.cust_fw.id
  slot_a           = 2
  node_b           = cml2_node.cust_tenant.id
  slot_b           = 2
} 

resource "cml2_link" "fabric-cust_tenant" {
  lab_id           = var.pod
  node_a           = var.fabric
  node_b           = cml2_node.cust_tenant.id
  slot_b           = 1
}   

resource "cml2_link" "oob-cust_tenant" {
  lab_id           = var.pod
  node_a           = var.oob
  node_b           = cml2_node.cust_tenant.id
  slot_b           = 0
}   

resource "cml2_node" "tenantJumpVlan" {
  lab_id           = var.pod
  label            = "${var.name}-jumpVLAN"
  x                = 720
  y                = 360
  tags             = ["customer"]
  nodedefinition   = "unmanaged_switch"
}

resource "cml2_link" "cust_tenant-tenantJumpVlan" {
  lab_id           = var.pod
  node_a           = cml2_node.cust_tenant.id
  slot_a           = 3
  node_b           = cml2_node.tenantJumpVlan.id
  slot_b           = 0
} 

resource "cml2_node" "tenantJump" {
  lab_id           = var.pod
  label            = "${var.name} jump hosts"
  x                = 1000
  y                = 360
  tags             = ["customer"]
  nodedefinition = "ubuntu"
  imagedefinition = "jumphost"
}

resource "ansible_host" "custJump" {
    inventory_hostname = "custJump"
    groups = [var.name]
    vars = {
        ansible_host = "192.168.128.250"
        ansible_user = "ubuntu"
    }
}

resource "cml2_link" "tenantJumpVlan-tenantJump" {
  lab_id           = var.pod
  node_a           = cml2_node.tenantJumpVlan.id
  slot_a           = 1
  node_b           = cml2_node.tenantJump.id
  slot_b           = 0
}   

resource "cml2_lifecycle" "Tenant" {
  lab_id = var.pod
  elements = [
    cml2_node.bkn.id,
    cml2_node.cust_fw.id,
    cml2_link.cust_fw-bkn.id,
    cml2_node.cust_tenant.id,
    cml2_link.cust_fw-cust_tenant.id,
    cml2_node.tenantJumpVlan.id,
    cml2_link.cust_tenant-tenantJumpVlan.id,
    cml2_node.tenantJump.id,
    cml2_link.tenantJumpVlan-tenantJump.id
  ]
  configs = {
    "${var.name}_fw":            file("modules/cml/tenant_cml/configs/tenant_fw.cfg")
    "cust_${var.name}":          templatefile("modules/cml/tenant_cml/configs/cust_tenant.cfg", {
       env_compartments = [
            for key, compartment in var.env_compartments : {
                index       = index(keys(var.env_compartments), key) + 5
                compartment = compartment
            }]
       vrf              = var.name
       })
    "${var.name} jump hosts":    templatefile("modules/cml/tenant_cml/configs/cust-tenant_jumphost.cfg", { comCustSecret = var.comCust_secret, comCustAgent = var.comCust_agent })
  }
  staging = {
    stages          = []
    start_remaining = false
  }
} 
