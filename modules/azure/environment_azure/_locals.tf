locals {
  compartment_names = [
    for key, value in var.compartments : replace(replace(value.name," ",""),"-","_")
  ]
}
