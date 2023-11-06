variable "prov" {
    type    = string
}

variable "pod" {
    type    = string
}

variable "tenant" {
    type    = string
}

variable "tenant_id" {
    type    = string
}

variable "vrf" {
    type    = string
}

variable "vnet" {}

variable "servers" {}

variable "children" {}

variable "compartments" {}

variable "application" {
    type    = string
}

variable "region" {
    type    = string
}

variable "environment" {
    type    = string
}

variable "key" {
    type    = string
}

variable "name" {
    type    = string
}

variable "description" {
    type    = string
}

variable "cstatus" {
    type    = string
}

variable "cversion" {
    type    = string
}

variable "ctype" {
    type    = string
}

variable "numOfServers" {
    type    = number
}

variable "addressing" {
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

variable "y" {
    type    = number
}

variable "cml_url" {
  description = "CML controller address"
  type        = string
  default     = "https://cml.tooling.provider.test"
}

variable "cml_username" {
  description = "cml2 username"
  type        = string
  default     = "developer"
}

variable "cml_password" {
  description = "cml2 password"
  type        = string
  sensitive   = true
} 
