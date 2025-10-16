
variable "hub_rg_name"   { type = string }
variable "spoke_rg_name" { type = string }
variable "rbac" {
  type = object({
    hub_contributors   = list(string)
    spoke_contributors = list(string)
    readers            = list(string)
  })
}

data "azurerm_resource_group" "hub"   { name = var.hub_rg_name }
data "azurerm_resource_group" "spoke" { name = var.spoke_rg_name }

# Hub contributors
resource "azurerm_role_assignment" "hub_contrib" {
  for_each           = toset(var.rbac.hub_contributors)
  scope              = data.azurerm_resource_group.hub.id
  role_definition_name = "Network Contributor"
  principal_id       = each.value
}

# Spoke contributors (app teams)
resource "azurerm_role_assignment" "spoke_contrib" {
  for_each           = toset(var.rbac.spoke_contributors)
  scope              = data.azurerm_resource_group.spoke.id
  role_definition_name = "Contributor"
  principal_id       = each.value
}

# Readers (common)
resource "azurerm_role_assignment" "readers" {
  for_each           = toset(var.rbac.readers)
  scope              = data.azurerm_resource_group.spoke.id
  role_definition_name = "Reader"
  principal_id       = each.value
}
