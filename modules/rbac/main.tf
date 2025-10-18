# =============================
# RBAC Assignments for Hub and Spoke Resource Groups
# =============================

# Hub RG - Contributor assignments
resource "azurerm_role_assignment" "hub_contributors" {
  for_each             = toset(var.rbac.hub_contributors)
  scope                = var.hub_rg_id
  role_definition_name = "Contributor"
  principal_id         = each.value
}

# Spoke RG - Contributor assignments
resource "azurerm_role_assignment" "spoke_contributors" {
  for_each             = toset(var.rbac.spoke_contributors)
  scope                = var.spoke_rg_id
  role_definition_name = "Contributor"
  principal_id         = each.value
}

# Readers for Hub RG
resource "azurerm_role_assignment" "hub_readers" {
  for_each             = toset(var.rbac.readers)
  scope                = var.hub_rg_id
  role_definition_name = "Reader"
  principal_id         = each.value
}

# Readers for Spoke RG
resource "azurerm_role_assignment" "spoke_readers" {
  for_each             = toset(var.rbac.readers)
  scope                = var.spoke_rg_id
  role_definition_name = "Reader"
  principal_id         = each.value
}
