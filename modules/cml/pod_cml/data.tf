resource "cml2_node" "comData" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "com-data"
  x              = 400
  y              = 640
  tags           = ["data"]
  nodedefinition = "csr1000v"
}

resource "ansible_host" "comData" {
    inventory_hostname = "comData"
    groups = ["data"]
    vars = {
        ansible_host = "192.168.202.135"
        lo0          = "192.168.254.135"
    }
}

resource "cml2_link" "fabric-comData" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.fabric.id
  slot_a         = 5
  node_b         = cml2_node.comData.id
  slot_b         = 1
} 

resource "cml2_link" "oob-comData" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.oob.id
  slot_a         = 5
  node_b         = cml2_node.comData.id
  slot_b         = 0
} 

resource "cml2_node" "comDataJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "com-data-jump VLAN"
  x              = 720
  y              = 640
  tags           = ["data"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_link" "comData-comDataJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comDataJumpVlan.id
  slot_a         = 0
  node_b         = cml2_node.comData.id
  slot_b         = 3
} 

resource "cml2_node" "dataJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "dataJump"
  x              = 1000
  y              = 640
  tags           = ["data"]
  nodedefinition = "ubuntu"
  imagedefinition = "jumphost"
}

resource "ansible_host" "dataJump" {
    inventory_hostname = "dataJump"
    groups = ["data"]
    vars = {
        ansible_host = "192.168.205.250"
    }
}

resource "cml2_link" "comDataJumpVlan-DataJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comDataJumpVlan.id
  slot_a         = 1
  node_b         = cml2_node.dataJump.id
  slot_b         = 0
} 
