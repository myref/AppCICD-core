resource "azurerm_subnet" "backend-adds_subnet" {
  name                 = "backend-adds_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "backend_vnet"
  address_prefixes     = ["192.168.210.128/29"]

  depends_on           = [azurerm_virtual_network.backend_vnet]
}

resource "azurerm_network_security_group" "backend-adds_nsg" {
  name                = "backend-adds_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "winrm"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "192.168.210.252"
    destination_address_prefix = "192.168.210.128/29"
  }

  security_rule {
    name                       = "ad"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "192.168.201.128/29"
    destination_address_prefix = "192.168.210.128/29"
  }

}

resource "azurerm_subnet_network_security_group_association" "backend-adds_ass" {
  subnet_id                 = azurerm_subnet.backend-adds_subnet.id
  network_security_group_id = azurerm_network_security_group.backend-adds_nsg.id
}

resource "azurerm_network_interface" "backend-adds0_nic" {
  name                = "backend-adds0_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.backend-adds_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("192.168.210.128/29", 4)}"
  }
}

resource "azurerm_windows_virtual_machine" "backend-adds0" {
  name                = "backend-adds0"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.backend-adds0_nic.id,
  ]
  tags = {
    applicationrole = "addshost"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

}
