resource "ansible_group" "envs" {
  inventory_group_name = var.name
  children = local.compartment_names
  vars = {
    envs = "${var.environments}"
  }
}
