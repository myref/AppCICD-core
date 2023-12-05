resource "cml2_node" "comServices" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "com-services"
  x                = -480
  y                = 320
  tags             = ["services"]
  nodedefinition   = "csr1000v"
}  

resource "cml2_link" "fabric-comServices" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.fabric.id
  slot_a           = 1
  node_b           = cml2_node.comServices.id
  slot_b           = 1
} 

resource "cml2_link" "oob-comServices" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.oob.id
  slot_a           = 1
  node_b           = cml2_node.comServices.id
  slot_b           = 0
}   

resource "cml2_node" "comServicesJumpVlan" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "com-services-jump"
  x                = -800
  y                = 40
  tags             = ["services"]
  nodedefinition   = "unmanaged_switch"
}

resource "cml2_link" "comServices-comServicesJumpVlan" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.comServicesJumpVlan.id
  slot_a           = 0
  node_b           = cml2_node.comServices.id
  slot_b           = 3
} 

resource "cml2_node" "servicesJump" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "services jump"
  x                = -1120
  y                = 40
  tags             = ["services"]
  nodedefinition = "ubuntu"
  imagedefinition = "jumphost"
}

resource "ansible_host" "servicesJump" {
    inventory_hostname = "servicesJump"
    groups = ["services"]
    vars = {
        ansible_host = "192.168.201.250"
    }
}

resource "cml2_link" "comServicesJumpVlan-servicesJump" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.comServicesJumpVlan.id
  slot_a           = 1
  node_b           = cml2_node.servicesJump.id
  slot_b           = 0
}   

resource "cml2_node" "servicesGw" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "com-svc-gw"
  x                = -480
  y                = -40
  tags             = ["services"]
  nodedefinition   = "iosv"
}

resource "cml2_link" "comServices-servicesGw" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.comServices.id
  slot_a           = 2
  node_b           = cml2_node.servicesGw.id
  slot_b           = 1
} 

resource "cml2_node" "servicesBr" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "nat"
  x                = -480
  y                = -250
  tags             = ["services"]
  nodedefinition   = "external_connector"
  configuration    = "NAT"
}

resource "cml2_link" "servicesGw-nat" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.servicesGw.id
  slot_a           = 0
  node_b           = cml2_node.servicesBr.id
  slot_b           = 0
} 
