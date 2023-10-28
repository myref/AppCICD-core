module "pods" {
    source               = "./modules/services/pods"
    prov                 = var.deployment.cloudprovider
    region               = var.deployment.region
    podType              = "AP"
    az                   = var.deployment.availability_zone
    tenant               = var.tenant
    centercode           = var.deployment.centercode
    read                 = var.deployment.read
    write                = var.deployment.write
    own                  = var.deployment.own
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password
}
