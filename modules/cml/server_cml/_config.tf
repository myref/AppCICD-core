terraform {
  required_providers {
    cml2 = {
      source  = "registry.terraform.io/ciscodevnet/cml2"
    }
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
  }
}