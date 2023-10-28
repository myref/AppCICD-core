variable "prov" {
    type    = string
}

variable "region" {
    type    = string
    default = "Europe"
}

variable "az" {
    type    = string
    default = "West Europe"
}

variable "resource_group_name" {
    type    = string
}

variable "location" {
    type    = string
}

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

variable "centercode" {
    type    = string
}

variable "read" {
    type    = string
}

variable "write" {
    type    = string
}

variable "own" {
    type    = string
}

