variable "pod" {
    type    = string
}

variable "tenant_id" {
    type    = string
}

variable "vrf" {
    type    = string
}

variable "application" {
    type    = string
}

variable "environment" {
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

variable "ctype" {
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
