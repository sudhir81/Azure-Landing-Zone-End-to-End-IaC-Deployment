output "rg_id" {
  description = "Resource ID of the Hub Resource Group"
  value       = azurerm_resource_group.hub_rg.id
}

output "rg_name" {
  description = "Name of the Hub Resource Group"
  value       = azurerm_resource_group.hub_rg.name
}

output "vnet_id" {
  description = "Hub VNet ID"
  value       = azurerm_virtual_network.hub_vnet.id
}

output "vnet_name" {
  description = "Hub VNet Name"
  value       = azurerm_virtual_network.hub_vnet.name
}

output "route_table_id" {
  description = "Route Table ID for Hub"
  value       = azurerm_route_table.rt_to_fw.id
}

output "firewall_private_ip" {
  description = "Private IP of Azure Firewall"
  value       = azurerm_firewall.afw.ip_configuration[0].private_ip_address
}
