resource "azurerm_virtual_network" "backend_vnet" {
  name                = "backend_vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["192.168.210.0/24"]

  tags = {
    environment = "backend"
  }
}

resource "azurerm_virtual_network_peering" "backend_com-svc_peer" {
    name                      = "backend_com-svc_peer"
    resource_group_name       = var.resource_group_name
    virtual_network_name      = azurerm_virtual_network.backend_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.com-svc_vnet.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = false
    depends_on = [
      azurerm_virtual_network.backend_vnet, 
      azurerm_virtual_network.com-svc_vnet
      ]
}

resource "azurerm_virtual_network_peering" "com-svc_backend_peer" {
    name                      = "cust-tenant_peer"
    resource_group_name       = var.resource_group_name
    virtual_network_name      = azurerm_virtual_network.com-svc_vnet.name
    remote_virtual_network_id = azurerm_virtual_network.backend_vnet.id

    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit   = false
    use_remote_gateways     = false
    depends_on = [
      azurerm_virtual_network.backend_vnet, 
      azurerm_virtual_network.com-svc_vnet
      ]
}

