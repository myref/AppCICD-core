variable "resource_group_name" {
    type    = string
}

variable "ctype" {
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

