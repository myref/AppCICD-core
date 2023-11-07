resource "ansible_group" "msp" {
  inventory_group_name = "MSP"
  children = ["Beheer", replace(replace(var.tenant," ",""),"-","_")]
    vars = {
      version = "0.0.1"
  }
}
