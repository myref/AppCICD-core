resource "ansible_group" "beheer" {
  inventory_group_name = "Beheer"
  children = ["Monitoring", "Tooling", "Access", "Services", "SOC"]
    vars = {
      version = "0.0.1"
  }
}

resource "ansible_group" "monitoring" {
  inventory_group_name = "Monitoring"
  children = ["OBM", "SCOM"]
    vars = {
      version = "0.0.1"
  }
}

resource "ansible_group" "tooling" {
  inventory_group_name = "Tooling"
  children = ["git", "Orchestrator",]
    vars = {
      version = "0.0.1"
  }
}

resource "ansible_group" "access" {
  inventory_group_name = "Access"
  children = []
    vars = {
      version = "0.0.1"
  }
}

resource "ansible_group" "services" {
  inventory_group_name = "Services"
  children = ["IPAM", "AD", "PKI", "MECM", "Trellix", "Flexera", "IPA", "TSAC", "CAPSULE", "Ansible", "Barman"]
    vars = {
      version = "0.0.1"
  }
}

resource "ansible_group" "soc" {
  inventory_group_name = "SOC"
  children = ["Splunk", "Nessus"]
    vars = {
      version = "0.0.1"
  }
}
