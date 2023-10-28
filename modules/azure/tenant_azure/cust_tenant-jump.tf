resource "azurerm_subnet" "cust-tenant-jump_subnet" {
  name                 = "cust-tenant-jump_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "cust-tenant_vnet"
  address_prefixes     = ["192.168.127.248/29"]

  depends_on           = [azurerm_virtual_network.cust-tenant_vnet]
}

resource "azurerm_network_security_group" "cust-tenant-jump_nsg" {
  name                = "cust-tenant-jump_nsg"
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

resource "azurerm_subnet_network_security_group_association" "cust-tenant-jump_ass" {
  subnet_id                 = azurerm_subnet.cust-tenant-jump_subnet.id
  network_security_group_id = azurerm_network_security_group.cust-tenant-jump_nsg.id
}

# Create public IPs
resource "azurerm_public_ip" "cust-tenant-jump_public_ip" {
  name                = "cust-tenant-jump_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "cust-tenant-jump_nic" {
  name                = "cust-tenant-jump_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.cust-tenant-jump_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("192.168.127.248/29", 4)}"
    public_ip_address_id          = azurerm_public_ip.cust-tenant-jump_public_ip.id
  }
}

resource "azapi_resource_action" "cust-tenant-jump_ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.cust-tenant-jump_ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "cust-tenant-jump_ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "cust-tenant-jump_ssh_key"
  location  = var.location
  parent_id = data.azurerm_resource_group.myPOD.id
}

resource "azurerm_linux_virtual_machine" "cust-tenant-jump" {
  name                = "cust-tenant-jump"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "tenant"
  admin_password      = "P@$$w0rd1234!"
  disable_password_authentication = false

  custom_data = data.template_cloudinit_config.jumphost_config.rendered

  network_interface_ids = [
    azurerm_network_interface.cust-tenant-jump_nic.id,
  ]
  tags = {
    applicationrole = "jumphost"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}
