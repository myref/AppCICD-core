variable "cml_url" {
  description = "CML controller address"
  type        = string
}

variable "cml_username" {
  description = "cml2 username"
  type        = string
}

variable "cml_password" {
  description = "cml2 password"
  type        = string
  sensitive   = true
} 

variable "name" {
    type    = string
}

variable "networktenant" {
    type    = string
}

variable "comCust_secret" {
    type    = string
    default = "secret" 
}

variable "comCust_agent" {
    type    = string
    default = "agent" 
}


variable "databases"{}
variable "App_Relation_hash_id"{}
