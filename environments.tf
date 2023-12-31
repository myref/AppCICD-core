variable "deployment" {
    type    = object ({
        type                = optional(string, "PRD"),
        cloudprovider       = optional(string, "SSC-ICT"),
        region              = optional(string, "West"),
        availability_zone   = optional(string, "AP01"),
        version             = optional(string, "1"),
        centercode          = optional(string, "123456789"),
        read                = optional(string, "BIZA\\"),
        write               = optional(string, "BIZA\\"),
        own                 = optional(string, "BIZA\\")
    })
}

module "environments" {
    source               = "./modules/services/environments"
    prov                 = var.deployment.cloudprovider
    name                 = replace(replace(var.name," ",""),"-","_")
    description          = "Tenant: ${var.tenant}\nApplication: ${var.application}\nEnvironment: ${var.deployment.cloudprovider}-${var.deployment.region}-${var.deployment.availability_zone}-${var.deployment.type}"
    etype                = var.deployment.type
    compartments         = var.compartments
    cloudprovider        = replace(replace(var.deployment.cloudprovider," ",""),"-","_")
    region               = var.deployment.region
    az                   = var.deployment.availability_zone
    application          = replace(replace(var.application," ",""),"-","_")
    children             = []
    eversion             = var.deployment.version
    estatus              = "Operational"
    centercode           = var.deployment.centercode
    read                 = var.deployment.read
    write                = var.deployment.write
    own                  = var.deployment.own

    depends_on = [
    module.applications
    ]
}
