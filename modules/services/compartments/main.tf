module "compartment_cml" {
    source               = "../../cml/compartment_cml"
    count                = var.prov == "CML" ? 1 : 0
    pod                  = var.pod
    tenant_id            = var.tenant_id
    vrf                  = var.vrf
    application          = var.application
    environment          = var.environment
    name                 = var.name
    description          = var.description
    cstatus              = var.cstatus
    ctype                = var.ctype
    servers              = var.servers
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    y                    = var.y
    key                  = var.key
    children             = var.children
    compartments         = var.compartments
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password
}

module "compartment_azure" {
    source               = "../../azure/compartment_azure"
    count                = var.prov == "Azure" ? 1 : 0
    pod                  = var.pod
    tenant               = var.tenant
    vnet                 = var.vnet
    application          = var.application
    environment          = var.environment
    compartments         = var.compartments
    key                  = var.key
    name                 = var.name
    description          = var.description
    resource_group_name  = var.tenant
    location             = var.region
    cstatus              = var.cstatus
    ctype                = var.ctype
    centercode           = var.centercode
    write                = var.write
    read                 = var.read
    own                  = var.own
    y                    = var.y
}
