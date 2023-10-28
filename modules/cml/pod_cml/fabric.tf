resource "cml2_node" "fabric" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "Fabric"
  x              = -40
  y              = 120
  tags           = ["fabric"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_node" "oob" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "OOB"
  x              = -40
  y              = -120
  tags           = ["fabric"]
  nodedefinition = "unmanaged_switch"
}

resource "cml2_node" "rr" {
  lab_id         = cml2_lab.AppPoDSim.id
  label          = "RR"
  x              = -40
  y              = 0
  tags           = ["fabric"]
  nodedefinition = "csr1000v"
}

resource "cml2_link" "oob-rr" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.oob.id
  slot_a         = 8
  node_b         = cml2_node.rr.id
  slot_b         = 0
} 

resource "cml2_link" "fabric-rr" {
  lab_id         = cml2_lab.AppPoDSim.id
  node_a         = cml2_node.fabric.id
  slot_a         = 8
  node_b         = cml2_node.rr.id
  slot_b         = 1
} 