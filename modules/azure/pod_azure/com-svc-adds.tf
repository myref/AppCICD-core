resource "azurerm_subnet" "com-svc-adds_subnet" {
  name                 = "com-svc-adds_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "com-svc_vnet"
  address_prefixes     = ["192.168.201.128/29"]

  depends_on           = [azurerm_virtual_network.com-svc_vnet]
}

resource "azurerm_network_security_group" "com-svc-adds_nsg" {
  name                = "com-svc-adds_nsg"
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
    source_address_prefix      = "192.168.201.250"
    destination_address_prefix = "192.168.201.128/29"
  }

  security_rule {
    name                       = "ad"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "192.168.201.128/29"
  }

  security_rule {
    name                       = "PDC"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8084"
    source_address_prefix      = "192.168.201.128/29"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "com-svc-adds_ass" {
  subnet_id                 = azurerm_subnet.com-svc-adds_subnet.id
  network_security_group_id = azurerm_network_security_group.com-svc-adds_nsg.id
}

resource "azurerm_network_interface" "com-svc-adds0_nic" {
  name                = "com-svc-adds0_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.com-svc-adds_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("192.168.201.128/29", 4)}"
  }
}

resource "azurerm_network_interface" "com-svc-adds1_nic" {
  name                = "com-svc-adds1_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.com-svc-adds_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("192.168.201.128/29", 5)}"
  }
}

resource "azurerm_windows_virtual_machine" "com-svc-adds0" {
  name                = "com-svc-adds0"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.com-svc-adds0_nic.id,
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

resource "azurerm_windows_virtual_machine" "com-svc-adds1" {
  name                = "com-svc-adds1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.com-svc-adds1_nic.id,
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
