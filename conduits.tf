variable "conduits" {
    type = map(object({
        type                = optional(string, "PAD"),
        parentid            = optional(string, "PA001"),
        name                = optional(string, "VLANx"),
        vip_name            = optional(list(string),[]),
        related_tenant      = optional(string,"tenant"),
        details             = optional(object({
            Related_Tenant                  = optional(string,"tenant"),
            Related_Compartment_Name        = optional(list(string),[]),
            Related_Compartment_Type        = optional(list(string),[]),
            Related_Compartment_Subnet      = optional(list(string),[])
        })),
        design              = optional(object({
            Configured_Ports                = optional(list(string),[])
        })),
        direction           = optional(string, "FROM"),
        related_addresses   = optional(list(string),[]),
        cversion            = optional(string, "0.0.1"),
        cstatus             = optional(string, "Operational"),
        centercode          = optional(string, "123456789"),
        read                = optional(string, "BIZA\\"),
        write               = optional(string, "BIZA\\"),
        own                 = optional(string, "BIZA\\")
        }
    ))
}

module "conduits" {
    source                  = "./modules/services/conduits"
    prov                    = var.deployment.cloudprovider
    region                  = var.deployment.region
    tenant                  = replace(replace(var.tenant," ",""),"-","_")
    mycompartments          = module.compartments

    depends_on = [
    module.compartments
    ]
}