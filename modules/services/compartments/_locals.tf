locals {
  compartment_types = distinct([for _, compartment in var.compartments : compartment.type])
}
