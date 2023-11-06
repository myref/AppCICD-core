locals {
  compartment_names = [
    for key, value in var.compartments : value.name
  ]
}
