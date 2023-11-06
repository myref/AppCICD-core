variable "prov" {
    type    = string
}

variable "pod" {
    type    = string
}

variable "region" {
    type    = string
}

variable "tenant" {
    type    = string
}

variable "location" {
    type    = string
}

variable "com-svc" {
    
}

variable "tenant_id" {}

variable "tenant_subnet" {}

variable "tenant_subnet_id" {}

variable "application" {
    type    = string
}

variable "compartment" {
    type    = string
}

variable "compartment_name" {
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

variable "sstatus" {
    type    = string
}

variable "sversion" {
    type    = string
}

variable "centercode" {
    type    = string
}

variable "size" {
    type    = string
}

variable "serverrol" {
    type    = string
}

variable "image" {
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
}

variable "ram" {
    type    = number
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
