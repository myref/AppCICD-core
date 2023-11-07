module "environment_cml" {
    source               = "../../cml/environment_cml"
    count                = var.prov == "CML" ? 1 : 0
    name                 = var.name
    environments         = var.etype
    compartments         = var.compartments
    children             = var.children
}

module "environment_azure" {
    source               = "../../azure/environment_azure"
    count                = var.prov == "Azure" ? 1 : 0
    name                 = var.name
    environments         = var.etype
    compartments         = var.compartments
    children             = var.children
}

