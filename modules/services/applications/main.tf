module "application_azure" {
    source               = "../../azure/application_azure"
    count                = var.prov == "Azure" ? 1 : 0
    application          = var.application
    prov                 = var.prov
    region               = var.region
    az                   = var.az
}

module "application_cml" {
    source               = "../../cml/application_cml"
    count                = var.prov == "CML" ? 1 : 0
    application          = var.application
    prov                 = var.prov
    region               = var.region
    az                   = var.az
}
