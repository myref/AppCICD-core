variable "servers" {
    type    = map(object({
        compartment         = optional(string, "PAD001"),
        name                = string, 
        size                = optional(string, "S"),
        serverrol           = optional(string, "Webserver"),
        details             = optional(object({
            description         = optional(string,"VLANx"),
            ipaddresses         = optional(list(string),[]),
            hostnames           = optional(list(string), []),
            type                = optional(string, ""),
            OS                  = optional(string, ""),
            vCPU                = optional(number, 2),
            memory              = optional(number, 16),
            serverrol           = optional(string, ""),
            aanspreekpunt       = optional(string, "")
        })),
        design              = optional(object({
            size                = optional(string, "S"),
            OS                  = optional(string, "Windows"),
            serverrol           = optional(string, "Webserver")
        })),
        cversion            = optional(string, "0.0.1"),
        cstatus             = optional(string, "Operational"),
        centercode          = optional(string, "123456789"),
        read                = optional(string, "BIZA\\"),
        write               = optional(string, "BIZA\\"),
        own                 = optional(string, "BIZA\\"),
        image               = optional(string, "Windows Server 2022"),
        sversion            = optional(string, "0.0.1"),
        sstatus             = optional(string, "Operational")
        })
    )
}

module "servers" {
    source               = "./modules/services/servers"
    prov                 = var.deployment.cloudprovider

    pod                  = module.pods.pod_id
    tenant               = replace(replace(var.tenant," ",""),"-","_")
    tenant_id            = module.tenants.tenant_id
    application          = replace(replace(var.application," ",""),"-","_")
    region               = var.deployment.region
    tenant_subnet        = module.tenants.cust-tenant-systems_subnet
    tenant_subnet_id     = module.tenants.cust-tenant-systems_subnet_id
    cml_url              = var.cml_url
    cml_username         = var.cml_username
    cml_password         = var.cml_password

    for_each             = var.servers
    key                  = each.key
    name                 = replace(replace(each.value.name," ",""),"-","_")
    description          = each.value.details.description
    com-svc              = module.pods.service_network
    location             = var.deployment.region
    sversion             = each.value.sversion
    sstatus              = "Operational"
    serverrol            = each.value.serverrol
    cpus                 = each.value.details.vCPU
    ram                  = each.value.details.memory
    size                 = each.value.design.size
    image                = each.value.design.OS
    centercode           = each.value.centercode
    write                = each.value.write
    read                 = each.value.read
    own                  = each.value.own
    y                    = index(keys(var.servers), each.key)
    c                    = index(keys(var.compartments), each.value.compartment)
    compartment          = module.compartments[each.value.compartment].compartment_id
    compartment_name     = module.compartments[each.value.compartment].compartment_name

    depends_on = [
    module.compartments
    ]
}
