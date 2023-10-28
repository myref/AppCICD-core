variable "prov" {
    type    = string
    default = "CML"
}

variable "region" {
    type    = string
    default = "West"
}

variable "podType" {
    type    = string
    default = "AP"
}

variable "az" {
    type    = string
    default = "AP01"
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
