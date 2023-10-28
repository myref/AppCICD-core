terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.23.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~>1.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    cml2 = {
      source  = "ciscodevnet/cml2"
    }
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }

  }

  backend "pg" {
    conn_str = "postgres://cicdtoolbox-db.internal.provider.test/terraform"
  }

} 

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true

}

provider "cml2" {
  address     = var.cml_url
  username    = var.cml_username
  password    = var.cml_password
  skip_verify = true
} 