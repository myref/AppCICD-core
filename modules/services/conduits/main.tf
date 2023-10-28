
module "conduit_azure" {
    source                      = "../../azure/conduit_azure"
    count                       = var.prov == "Azure" ? 1 : 0
    resource_group_name         = var.tenant
    mycompartments              = var.mycompartments
    location                    = var.region
}

