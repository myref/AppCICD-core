resource "cml2_node" "comPodinfra" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "com-podinfra"
  x              = -1440
  y              = -120
  tags           = ["podinfra"]
  nodedefinition = "csr1000v"
}

resource "cml2_link" "fabric-comPodinfra" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.fabric.id
  slot_a         = 2
  node_b         = cml2_node.comPodinfra.id
  slot_b         = 1
} 

resource "cml2_link" "oob-comPodinfra" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.oob.id
  slot_a         = 2
  node_b         = cml2_node.comPodinfra.id
  slot_b         = 0
} 

resource "cml2_node" "comPodinfraJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "podinfra-jump-VLAN"
  x              = -1640
  y              = -120
  tags           = ["podinfra"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_link" "comPodinfra-comPodinfraJumpVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comPodinfraJumpVlan.id
  slot_a         = 0
  node_b         = cml2_node.comPodinfra.id
  slot_b         = 3
} 

resource "cml2_node" "podinfraJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "podinfra jump"
  x              = -1840
  y              = -120
  tags           = ["podinfra"]
  nodedefinition = "ubuntu"
  imagedefinition = "jumphost"
}

resource "cml2_link" "comPodinfraJumpVlan-podinfraJump" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comPodinfraJumpVlan.id
  slot_a         = 1
  node_b         = cml2_node.podinfraJump.id
  slot_b         = 0
} 

resource "cml2_node" "infobloxMgmtVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "podinfra-infoblox-mgmt-VLAN"
  x              = -1440
  y              = 320
  tags           = ["podinfra"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_link" "comPodinfra-infobloxMgmtVlan" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.comPodinfra.id
  slot_a         = 4
  node_b         = cml2_node.infobloxMgmtVlan.id
  slot_b         = 0
} 
