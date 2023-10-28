module "tenant_cml" {
    source               = "../../cml/tenant_cml"
    count                = var.prov == "CML" ? 1 : 0
    pod                  = var.pod
    fabric               = var.fabric
    oob                  = var.oob
    name                 = var.name
    description          = var.description
    comCust_secret       = var.comCust_secret
    comCust_agent        = var.comCust_agent
    env_compartments     = var.env_compartments
    status               = var.status
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password
}

module "tenant_azure" {
    source               = "../../azure/tenant_azure"
    count                = var.prov == "Azure" ? 1 : 0
    name                 = var.name
    description          = var.description
    resource_group_name  = var.name
    com-svc              = var.com-svc
    location             = var.region
    env_compartments     = var.env_compartments
    status               = var.status
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
}
