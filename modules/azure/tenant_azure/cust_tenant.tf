resource "azurerm_virtual_network" "cust-tenant_vnet" {
  name                = "cust-tenant_vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["192.168.0.0/17"]

  tags = {
    environment = "cust_${var.name}"
  }
}

resource "azurerm_virtual_network_peering" "cust-tenant_com-svc_peer" {
    name                      = "cust-tenant_com-svc_peer"
    resource_group_name       = var.resource_group_name
    virtual_network_name      = azurerm_virtual_network.cust-tenant_vnet.name
    remote_virtual_network_id = var.com-svc.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = false
    depends_on = [
      azurerm_virtual_network.cust-tenant_vnet, 
      var.com-svc
      ]
}

resource "azurerm_virtual_network_peering" "com-svc_cust-tenant_peer" {
    name                      = "com-svc_cust-tenant_peer"
    resource_group_name       = var.resource_group_name
    virtual_network_name      = "com-svc_vnet"
    remote_virtual_network_id = azurerm_virtual_network.cust-tenant_vnet.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = false
    depends_on = [
      azurerm_virtual_network.cust-tenant_vnet, 
      var.com-svc
      ]
}
