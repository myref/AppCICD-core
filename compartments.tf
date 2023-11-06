variable "compartments" {
    type = map(object({
        type                = optional(string, "PAD"),
        parentid            = optional(string, "PA001"),
        name                = optional(string, "VLANx"),
        numofitems          = optional(number, 1),
        addressing          = optional(string, "IPv4"),
        details             = optional(object({
            Subnet              = optional(string,"a.b.c.d/m"),
            Description         = optional(string,"VLANx"),
            SubnetSize          = optional(number, 24),
            Type                = optional(string,"PAD"),
            Number_of_Servers   = optional(number, 6)
        })),
        design              = optional(object({
            Number_of_Servers   = optional(number, 6),
            Type                = optional(string,"PAD")
        })),
        cversion            = optional(string, "0.0.1"),
        cstatus             = optional(string, "Operational"),
        centercode          = optional(string, "123456789"),
        read                = optional(string, "BIZ"),
        write               = optional(string, "BIZ"),
        own                 = optional(string, "BIZ")
        })            
    )
}

module "compartments" {
    source               = "./modules/services/compartments"
    prov                 = var.deployment.cloudprovider
    pod                  = module.pods.pod_id
    tenant               = replace(replace(var.tenant," ",""),"-","_")
    tenant_id            = module.tenants.tenant_id
    vrf                  = module.tenants.tenant_vrf
    vnet                 = module.tenants.tenant_vnet
    compartments         = var.compartments
    application          = replace(replace(var.application," ",""),"-","_")
    region               = var.deployment.region
    servers              = var.servers
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password

    for_each             = var.compartments
    key                  = each.key
    name                 = replace(replace(each.value.name," ",""),"-","_")
    description          = each.value.details.Description
    cversion             = "0.0.1"
    cstatus              = "Operational"
    centercode           = each.value.centercode
    write                = each.value.write
    read                 = each.value.read
    own                  = each.value.own
    environment          = each.value.parentid
    y                    = index(keys(var.compartments), each.key)
    children             = []
    ctype                = each.value.details.Type
    numOfServers         = each.value.details.Number_of_Servers
    addressing           = "IPv4"

    depends_on = [
    module.tenants
    ]
}
