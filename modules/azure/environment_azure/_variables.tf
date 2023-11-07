variable "name" {
    type    = string
}

variable "description" {
    type    = string
    default = ""
}

variable "status" {
    type    = string
    default = "Operational"
}

variable "environments" {}
variable "compartments" {}
variable "children" {}
