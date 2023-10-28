locals {
  compartment_types_with_p = [
    for _, value in var.mycompartments :
    value.compartment_id
    if can(regex("P", value.compartment_type))
  ]

  compartment_types_with_a = [
    for _, value in var.mycompartments :
    value.compartment_id
    if can(regex("A", value.compartment_type))
  ]

  compartment_types_with_d = [
    for _, value in var.mycompartments :
    value.compartment_id
    if can(regex("D", value.compartment_type))
  ]
}