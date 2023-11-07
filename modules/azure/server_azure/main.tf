resource "azurerm_network_interface" "cust-server_nic" {
  name                = "cust-server-${var.key}_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.name
    subnet_id                     = var.tenant_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "random_pet" "server_ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource_action" "server_ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.server_ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "server_ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.server_ssh_key_name.id
  location  = var.location
  parent_id = data.azurerm_resource_group.myPOD.id
}

resource "azurerm_linux_virtual_machine" "cust-server" {
  name                = "cust-server-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "IAmTheBoss"
  admin_password      = "P@$$w0rd1234!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.cust-server_nic.id,
  ]
  tags = {
    applicationrole = "var.serverrol"
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

resource "ansible_host" "custAcme" {
    inventory_hostname = "${var.name}"
    groups = [var.compartment_name]
    vars = {
        ansible_host = "192.168.${var.c + 5}.${var.y + 2}"
    }
}
