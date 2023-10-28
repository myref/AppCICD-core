variable "tenant" {
    type    = string
}

module "tenants" {
    source               = "./modules/services/tenants"
    prov                 = var.deployment.cloudprovider
    region               = var.deployment.region
    pod                  = module.pods.pod_id
    fabric               = module.pods.fabric_id
    oob                  = module.pods.oob_id
    com-svc              = module.pods.service_network
    name                 = var.tenant
    description          = "No tenant description"
    status               = "Operational"
    comCust_secret       = var.comCust_secret
    comCust_agent        = var.comCust_agent
    env_compartments     = var.compartments
    centercode           = var.deployment.centercode
    read                 = var.deployment.read
    write                = var.deployment.write
    own                  = var.deployment.own
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password

    depends_on = [
    module.pods
    ]
}
