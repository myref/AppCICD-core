module "server_cml" {
    source               = "../../cml/server_cml"
    count                = var.prov == "CML" ? 1 : 0
    pod                  = var.pod
    tenant               = var.tenant_id
    application          = var.application
    compartment          = var.compartment
    name                 = var.name
    description          = var.description
    sstatus              = var.sstatus
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    y                    = var.y
    c                    = var.c
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password
}

module "server_azure" {
    source               = "../../azure/server_azure"
    count                = var.prov == "Azure" ? 1 : 0
    pod                  = var.pod
    tenant               = var.tenant
    tenant_subnet        = var.tenant_subnet
    tenant_subnet_id     = var.tenant_subnet_id
    application          = var.application
    compartment          = var.compartment
    key                  = var.key
    name                 = var.name
    description          = var.description
    resource_group_name  = var.tenant
    com-svc              = var.com-svc
    serverrol            = var.serverrol
    location             = var.region
    sstatus              = var.sstatus
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    y                    = var.y
    c                    = var.c
}
