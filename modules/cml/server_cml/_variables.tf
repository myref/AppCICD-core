variable "pod" {
    type    = string
}

variable "tenant" {
    type    = string
}

variable "application" {
    type    = string
}

variable "compartment" {
    type    = string
}

variable "compartment_name" {
    type    = string
}

variable "name" {
    type    = string
}

variable "description" {
    type    = string
}

variable "sstatus" {
    type    = string
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

variable "cpus" {
    type    = number
    default = 2
}

variable "ram" {
    type    = number
    default = 4
}

variable "c" {
    type    = number
}

variable "y" {
    type    = number
}

variable "cml_url" {
  description = "CML controller address"
  type        = string
}

variable "cml_username" {
  description = "cml2 username"
  type        = string
  sensitive   = true
}

variable "cml_password" {
  description = "cml2 password"
  type        = string
  sensitive   = true
} 