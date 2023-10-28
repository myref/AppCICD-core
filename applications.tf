variable "application" {
    type    = string
}

module "applications" {
    source               = "./modules/services/applications"
    prov                 = var.deployment.cloudprovider
    name                 = var.tenant
    description          = var.networktenant
    apptenant            = module.tenants.tenant_id
    status               = "Operational"
    centercode           = var.deployment.centercode
    read                 = var.deployment.read
    write                = var.deployment.write
    own                  = var.deployment.own

    depends_on = [
    module.tenants
  ]
}
