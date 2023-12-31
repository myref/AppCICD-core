output "backend_network" {
    description             = "Value generated by the provider to uniquely identify the backend network"
    value                   = try(azurerm_virtual_network.backend_vnet.id, "")
}

output "com-svc_network" {
    description             = "ID of network for com-services"
    value                   = try(azurerm_virtual_network.com-svc_vnet,{})
}

output "backend_key_data" {
  value = jsondecode(azapi_resource_action.backend_ssh_public_key_gen.output).publicKey
}

output "com-svc_key_data" {
  value = jsondecode(azapi_resource_action.com-svc_ssh_public_key_gen.output).publicKey
}

output "backend-jump_public_ip_address" {
  value = azurerm_linux_virtual_machine.backend-jump.public_ip_address
}

output "com-svc-jump_public_ip_address" {
  value = azurerm_linux_virtual_machine.com-svc-jump.public_ip_address
}