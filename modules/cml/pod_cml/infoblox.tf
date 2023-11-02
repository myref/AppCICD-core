resource "cml2_node" "gridmaster" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "Gridmaster"
  x                = 1000
  y                = 1080
  tags             = ["infoblox"]
  nodedefinition   = "Infoblox"
}

resource "ansible_host" "Gridmaster" {
    inventory_hostname = "gridmaster"
    groups = ["backend"]
    vars = {
        ansible_host = "192.168.205.50"
    }
}

resource "cml2_link" "backendServicesVlan-gridmaster" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.backendServicesVlan.id
  slot_a           = 1
  node_b           = cml2_node.gridmaster.id
  slot_b           = 1
} 

resource "cml2_node" "infoblox_member_a" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "Member A"
  x                = -1120
  y                = 280
  tags             = ["infoblox"]
  nodedefinition   = "Infoblox"
}

resource "ansible_host" "GridmemberA" {
    inventory_hostname = "gridmembera"
    groups = ["services"]
    vars = {
        ansible_host = "192.168.205.66"
        mgmt = "192.168.205.66"
        lan1 = "192.168.201.146"
        lan2 = "192.168.205.137"
    }
}

resource "cml2_link" "infoblox_member_a-MGMT" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.infoblox_member_a.id
  slot_a           = 0
  node_b           = cml2_node.infobloxMgmtVlan.id
  slot_b           = 1
} 

resource "cml2_node" "comServicesVlan_infoblox_i" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "Infoblox_i"
  x                = -800
  y                = 280
  tags             = ["infoblox"]
  nodedefinition   = "unmanaged_switch"
}

resource "cml2_link" "infoblox_member_a-i" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.infoblox_member_a.id
  slot_a           = 1
  node_b           = cml2_node.comServicesVlan_infoblox_i.id
  slot_b           = 1
} 

resource "cml2_link" "comServices-comServicesVlan_infoblox_i" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.comServices.id
  slot_a           = 5
  node_b           = cml2_node.comServicesVlan_infoblox_i.id
  slot_b           = 0
} 

resource "cml2_node" "comServicesVlan_infoblox_e" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "Infoblox_e"
  x                = -800
  y                = 360
  tags             = ["infoblox"]
  nodedefinition   = "unmanaged_switch"
}

resource "cml2_link" "infoblox_member_a-e" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.infoblox_member_a.id
  slot_a           = 2
  node_b           = cml2_node.comServicesVlan_infoblox_e.id
  slot_b           = 1
} 

resource "cml2_link" "comServices-comServicesVlan_infoblox_e" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.comServices.id
  slot_a           = 6
  node_b           = cml2_node.comServicesVlan_infoblox_e.id
  slot_b           = 0
} 

resource "cml2_node" "infoblox_member_b" {
  lab_id           = cml2_lab.AppPoDSim.id
  label            = "Member B"
  x                = -1120
  y                = 360
  tags             = ["infoblox"]
  nodedefinition   = "Infoblox"
}

resource "ansible_host" "GridmemberB" {
    inventory_hostname = "gridmemberb"
    groups = ["services"]
    vars = {
        ansible_host = "192.168.205.67"
        mgmt = "192.168.205.67"
        lan1 = "192.168.201.147"
        lan2 = "10.18.205.138"
    }
}

resource "cml2_link" "infoblox_member_b-MGMT" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.infoblox_member_b.id
  slot_a           = 0
  node_b           = cml2_node.infobloxMgmtVlan.id
  slot_b           = 2
} 

resource "cml2_link" "infoblox_member_b-i" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.infoblox_member_b.id
  slot_a           = 1
  node_b           = cml2_node.comServicesVlan_infoblox_i.id
  slot_b           = 2
} 

resource "cml2_link" "infoblox_member_b-e" {
  lab_id           = cml2_lab.AppPoDSim.id
  node_a           = cml2_node.infoblox_member_b.id
  slot_a           = 2
  node_b           = cml2_node.comServicesVlan_infoblox_e.id
  slot_b           = 2
} 
 
