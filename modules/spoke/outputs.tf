output "rg_id" {
  description = "Resource ID of the Spoke Resource Group"
  value       = azurerm_resource_group.spoke_rg.id
}

output "rg_name" {
  description = "Name of the Spoke Resource Group"
  value       = azurerm_resource_group.spoke_rg.name
}

output "vnet_name" {
  description = "Spoke VNet Name"
  value       = azurerm_virtual_network.spoke_vnet.name
}
