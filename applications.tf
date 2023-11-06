variable "application" {
    type    = string
}

module "applications" {
    source               = "./modules/services/applications"
    prov                 = var.deployment.cloudprovider
    name                 = var.tenant
    description          = var.networktenant
    tenant               = module.tenants.tenant_id
    region               = var.deployment.region
    az                   = var.deployment.availability_zone
    application          = var.application
    status               = "Operational"
    centercode           = var.deployment.centercode
    read                 = var.deployment.read
    write                = var.deployment.write
    own                  = var.deployment.own

    depends_on = [
    module.tenants
  ]
}
