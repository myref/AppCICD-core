output "key_data" {
  value = jsondecode(azapi_resource_action.cust-tenant-jump_ssh_public_key_gen.output).publicKey
}

output "cust-tenant-jump_public_ip_address" {
  value = azurerm_linux_virtual_machine.cust-tenant-jump.public_ip_address
}

output "cust-tenant_vnet" {
  value = azurerm_virtual_network.cust-tenant_vnet
}

output "cust-tenant-systems_subnet" {
  value = azurerm_subnet.cust-tenant-systems_subnet
}

output "cust-tenant-systems_subnet_id" {
  value = azurerm_subnet.cust-tenant-systems_subnet.id
}