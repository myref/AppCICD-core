resource "ansible_group" "msp" {
  inventory_group_name = "MSP"
  children = ["Beheer", var.tenant]
    vars = {
      version = "0.0.1"
  }
}
