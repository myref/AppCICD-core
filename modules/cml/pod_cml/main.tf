resource "cml2_lab" "AppPoDSim" {
  title       = "${var.prov}-${var.region}-${var.name}"
  description = "Virtual functionally equivalent lab to test application installation"
  notes       = "${var.description}"
}

resource "ansible_group" "deployment" {
  inventory_group_name = "${var.prov}-${var.region}-${var.name}"
  children = ["podinfra", "services", "data", "sysbeheer", "backend", "acme"]
    vars = {
      deployment_id = cml2_lab.AppPoDSim.id
  }
}

resource "cml2_lifecycle" "App-PoD" {
  lab_id = cml2_lab.AppPoDSim.id
  elements = [
    cml2_node.fabric.id,
    cml2_node.oob.id,
    cml2_node.rr.id,
    cml2_link.fabric-rr.id,

    cml2_node.comServices.id,
    cml2_link.fabric-comServices.id,
    cml2_link.oob-comServices.id,
    cml2_node.comServicesJumpVlan.id,
    cml2_link.comServices-comServicesJumpVlan.id,
    cml2_node.servicesJump.id,
    cml2_link.comServicesJumpVlan-servicesJump.id,
    cml2_node.servicesGw.id,
    cml2_link.comServices-servicesGw.id,
    cml2_link.comServicesJumpVlan-servicesJump.id,
    cml2_node.servicesBr.id,
    cml2_link.servicesGw-nat.id,

    cml2_node.gridmaster.id,
    cml2_link.backendServicesVlan-gridmaster.id,
    cml2_node.infoblox_member_a.id,
    cml2_link.infoblox_member_a-MGMT.id,
    cml2_node.comServicesVlan_infoblox_i.id,
    cml2_link.infoblox_member_a-i.id,
    cml2_link.comServices-comServicesVlan_infoblox_i.id,
    cml2_node.comServicesVlan_infoblox_e.id,
    cml2_link.infoblox_member_a-e.id,
    cml2_link.comServices-comServicesVlan_infoblox_e.id,
    cml2_node.infoblox_member_b.id,
    cml2_link.infoblox_member_b-MGMT.id,
    cml2_link.infoblox_member_b-i.id,
    cml2_link.infoblox_member_b-e.id,

    cml2_node.comPodinfra.id,
    cml2_link.fabric-comPodinfra.id,
    cml2_link.oob-comPodinfra.id,
    cml2_node.comPodinfraJumpVlan.id,
    cml2_link.comPodinfra-comPodinfraJumpVlan.id,
    cml2_node.podinfraJump.id,
    cml2_link.comPodinfraJumpVlan-podinfraJump.id,
    cml2_node.infobloxMgmtVlan.id,

    cml2_node.comSysbeheer.id,
    cml2_link.fabric-comSysbeheer.id,
    cml2_link.oob-comSysbeheer.id,
    cml2_node.comSysbeheerJumpVlan.id,
    cml2_link.comSysbeheer-comSysbeheerJumpVlan.id,
    cml2_node.sysbeheerJump.id,
    cml2_link.comSysbeheerJumpVlan-SysbeheerJump.id,

    cml2_node.comData.id,
    cml2_link.fabric-comData.id,
    cml2_link.oob-comData.id,
    cml2_node.comDataJumpVlan.id,
    cml2_link.comData-comDataJumpVlan.id,
    cml2_node.dataJump.id,
    cml2_link.comDataJumpVlan-DataJump.id,

    cml2_node.backend.id,
    cml2_link.fabric-backend.id,
    cml2_link.oob-backend.id,
    cml2_node.backendJumpVlan.id,
    cml2_link.backend-backendJumpVlan.id,
    cml2_node.BackendJump.id,
    cml2_link.backendJumpVlan-BackendJump.id,

    cml2_node.backendServicesVlan.id,
    cml2_link.backend-backendServicesVlan.id,
    cml2_node.gridmaster.id,
    cml2_link.backendServicesVlan-gridmaster.id
  ]
  configs = {
    "RR":                file("modules/cml/pod_cml/configs/rr.cfg")
    "com-services":      file("modules/cml/pod_cml/configs/comServices.cfg")
    "com-svc-gw":        file("modules/cml/pod_cml/configs/com-svc-gw.cfg")
    "services jump":     file("modules/cml/pod_cml/configs/servicesJump.cfg")
    "com-podinfra":      file("modules/cml/pod_cml/configs/comPodinfra.cfg")
    "podinfra jump":     file("modules/cml/pod_cml/configs/podinfraJump.cfg")
    "com-sysbeheer":     file("modules/cml/pod_cml/configs/comSysbeheer.cfg")
    "sysbeheer jump":    file("modules/cml/pod_cml/configs/sysbeheerJump.cfg")
    "com-data":          file("modules/cml/pod_cml/configs/comData.cfg")
    "dataJump":          file("modules/cml/pod_cml/configs/dataJump.cfg")
    "backend":           file("modules/cml/pod_cml/configs/backend.cfg")
    "backend jump":      file("modules/cml/pod_cml/configs/backendJump.cfg")
    "backend desktop":   file("modules/cml/pod_cml/configs/backendDesktop.cfg")
  }
  staging = {
    stages          = ["fabric", "services", "infoblox"]
    start_remaining = false
#    stages          = ["fabric", "podinfra", "backend", "services", "infoblox", "data", "sysbeheer"]
#    start_remaining = true
  }
} 