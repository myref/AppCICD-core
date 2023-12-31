resource "azurerm_subnet" "backend-jump_subnet" {
  name                 = "backend-jump_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "backend_vnet"
  address_prefixes     = ["192.168.210.248/29"]

  depends_on           = [azurerm_virtual_network.backend_vnet]
}

resource "azurerm_network_security_group" "backend-jump_nsg" {
  name                = "backend-jump_nsg"
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
    destination_address_prefix = "192.168.210.252"
  }

  security_rule {
    name                       = "git"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
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
    source_address_prefix      = "*"
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
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "backend-jump_ass" {
  subnet_id                 = azurerm_subnet.backend-jump_subnet.id
  network_security_group_id = azurerm_network_security_group.backend-jump_nsg.id
}

# Create public IPs
resource "azurerm_public_ip" "backend-jump_public_ip" {
  name                = "backend-jump_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "backend-jump_nic" {
  name                = "backend-jump_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.backend-jump_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("192.168.210.248/29", 4)}"
    public_ip_address_id          = azurerm_public_ip.backend-jump_public_ip.id
  }
}

resource "azapi_resource_action" "backend_ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.backend_ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "backend_ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "backend-jump_ssh_key"
  location  = var.location
  parent_id = data.azurerm_resource_group.myPOD.id
}

resource "azurerm_linux_virtual_machine" "backend-jump" {
  name                = "backend-jump"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "backend"
  admin_password      = "P@$$w0rd1234!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.backend-jump_nic.id,
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
