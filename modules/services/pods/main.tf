module "pod_cml" {
    source               = "../../cml/pod_cml"
    count                = var.prov == "CML" ? 1 : 0
    prov                 = var.prov
    tenant               = var.tenant
    region               = var.region
    az                   = var.az
    podType              = var.podType
    name                 = var.az
    description          = var.description
    status               = var.status
    application          = var.application
    environment          = var.environment
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password
}

module "pod_azure" {
    source               = "../../azure/pod_azure"
    count                = var.prov == "Azure" ? 1 : 0
    prov                 = var.prov
    region               = var.region
    name                 = var.az
    description          = var.description
    resource_group_name  = var.tenant
    location             = var.region
    status               = var.status
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
}
