data "azurerm_resource_group" "hub"   { name = var.hub_rg_name }
data "azurerm_resource_group" "spoke" { name = var.spoke_rg_name }

resource "azurerm_role_assignment" "hub_contrib" {
  for_each             = toset(var.rbac.hub_contributors)
  scope                = data.azurerm_resource_group.hub.id
  role_definition_name = "Network Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "spoke_contrib" {
  for_each             = toset(var.rbac.spoke_contributors)
  scope                = data.azurerm_resource_group.spoke.id
  role_definition_name = "Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "readers" {
  for_each             = toset(var.rbac.readers)
  scope                = data.azurerm_resource_group.spoke.id
  role_definition_name = "Reader"
  principal_id         = each.value
}
