resource "cml2_node" "comSysbeheer" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "com-sysbeheer"
  x              = 400
  y              = 480
  tags           = ["sysbeheer"]
  nodedefinition = "csr1000v"
}

resource "cml2_link" "fabric-comSysbeheer" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.fabric.id
  slot_a         = 3
  node_b         = cml2_node.comSysbeheer.id
  slot_b         = 1
} 

resource "cml2_link" "oob-comSysbeheer" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.oob.id
  slot_a         = 3
  node_b         = cml2_node.comSysbeheer.id
  slot_b         = 0
} 

resource "cml2_node" "comSysbeheerJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "com-sysbeheer-jump"
  x              = 720
  y              = 480
  tags           = ["sysbeheer"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_link" "comSysbeheer-comSysbeheerJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comSysbeheerJumpVlan.id
  slot_a         = 0
  node_b         = cml2_node.comSysbeheer.id
  slot_b         = 3
} 

resource "cml2_node" "sysbeheerJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "sysbeheer jump"
  x              = 1000
  y              = 480
  tags           = ["sysbeheer"]
  nodedefinition = "ubuntu"
  imagedefinition = "jumphost"
}

resource "ansible_host" "sysbeheerJump" {
    inventory_hostname = "sysbeheerJump"
    groups = ["sysbeheer"]
    vars = {
        ansible_host = "192.168.203.250"
    }
}

resource "cml2_link" "comSysbeheerJumpVlan-SysbeheerJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comSysbeheerJumpVlan.id
  slot_a         = 1
  node_b         = cml2_node.sysbeheerJump.id
  slot_b         = 0
} 
