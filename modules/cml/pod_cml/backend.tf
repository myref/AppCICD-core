resource "ansible_group" "backend" {
  inventory_group_name = "backend"
  children = ["backend", "backendJump", "backendDesktop"]
}

resource "cml2_node" "backend" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "backend"
  x              = 400
  y              = 920
  tags           = ["backend"]
  nodedefinition = "csr1000v"
}

resource "ansible_host" "backend" {
    inventory_hostname = "backend"
    groups = ["backend"]
    vars = {
        ansible_host = "192.168.202.157"
        lo0          = "192.168.254.157"
    }
}

resource "cml2_link" "fabric-backend" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.fabric.id
  slot_a         = 9
  node_b         = cml2_node.backend.id
  slot_b         = 1
} 

resource "cml2_link" "oob-backend" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.oob.id
  slot_a         = 9
  node_b         = cml2_node.backend.id
  slot_b         = 0
} 

resource "cml2_node" "backendJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "backend-jump-VLAN"
  x              = 720
  y              = 920
  tags           = ["data"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_link" "backend-backendJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.backendJumpVlan.id
  slot_a         = 0
  node_b         = cml2_node.backend.id
  slot_b         = 3
} 

resource "cml2_node" "BackendJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "backend jump"
  x              = 1000
  y              = 920
  tags           = ["backend"]
  nodedefinition = "ubuntu"
  imagedefinition = "jumphost"
}

resource "ansible_host" "backendJump" {
    inventory_hostname = "backendJump"
    groups = ["backend"]
    vars = {
        ansible_host = "192.168.210.250"
    }
}

resource "cml2_link" "backendJumpVlan-BackendJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.backendJumpVlan.id
  slot_a         = 1
  node_b         = cml2_node.BackendJump.id
  slot_b         = 0
} 

resource "cml2_node" "BackendDesktop" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "backend desktop"
  x              = 1000
  y              = 820
  tags           = ["backend"]
  nodedefinition = "desktop"
}

resource "ansible_host" "backendDesktop" {
    inventory_hostname = "backendDesktop"
    groups = ["backend"]
    vars = {
        ansible_host = "192.168.210.251"
    }
}

resource "cml2_link" "backendJumpVlan-BackendDesktop" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.backendJumpVlan.id
  slot_a         = 2
  node_b         = cml2_node.BackendDesktop.id
  slot_b         = 0
} 

resource "cml2_node" "backendServicesVlan" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "backend-services"
  x                = 720
  y                = 1080
  tags             = ["backend"]
  nodedefinition   = "unmanaged_switch"
}

resource "cml2_link" "backend-backendServicesVlan" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.backend.id
  slot_a           = 4
  node_b           = cml2_node.backendServicesVlan.id
  slot_b           = 0
} 