variable "prov" {
    type    = string
    default = "CML"
}

variable "pod" {
    type    = string
}

variable "fabric" {
    type    = string
}

variable "oob" {
    type    = string
}

variable "name" {
    type    = string
}

variable "description" {
    type    = string
    default = ""
}

variable "comCust_secret" {
    type    = string
}

variable "comCust_agent" {
    type    = string
}

variable "env_compartments" {
    type    = map
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
