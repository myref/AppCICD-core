resource "azurerm_subnet" "cust-tenant-systems_subnet" {
  name                 = "cust-tenant-systems_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "cust-tenant_vnet"
  address_prefixes     = ["192.168.1.0/24"]

  depends_on           = [azurerm_virtual_network.cust-tenant_vnet]
}

resource "azurerm_network_security_group" "cust-tenant-systems_nsg" {
  name                = "cust-tenant-systems_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "ssh"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "192.168.0.0/17"
  }

  security_rule {
    name                       = "git"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "192.168.127.248/29"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "jenkins"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8084"
    source_address_prefix      = "192.168.127.248/29"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "nexus"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8443"
    source_address_prefix      = "192.168.127.248/29"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "cust-tenant-systems_ass" {
  subnet_id                 = azurerm_subnet.cust-tenant-systems_subnet.id
  network_security_group_id = azurerm_network_security_group.cust-tenant-systems_nsg.id
}
