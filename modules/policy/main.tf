
variable "location"         { type = string }
variable "hub_rg_name"      { type = string }
variable "spoke_rg_name"    { type = string }
variable "log_analytics_id" { type = string }

# Built-in policy definitions are referenced by ID; here we create assignments

# Require tags on resources
resource "azurerm_policy_assignment" "require_tags" {
  name                 = "require-standard-tags"
  display_name         = "Require standard tags"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4af9b103-3ccb-4a62-9e63-98937f71b49a"
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  description          = "Requires cost-center and environment tags"
  parameters = jsonencode({
    tagName = { value = "environment" }
  })
}

# Deny public IP on NICs
resource "azurerm_policy_assignment" "deny_public_ip" {
  name                 = "deny-public-ip"
  display_name         = "Deny public IP on NICs"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  description          = "Denies public IP assignment on NICs"
}

# Audit diagnostics to Log Analytics (example)
resource "azurerm_policy_assignment" "audit_diag" {
  name                 = "audit-diag-settings"
  display_name         = "Audit diagnostic settings"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/790c7a17-42b6-4e52-8a49-f6b3f05d47ad"
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  parameters = jsonencode({
    effect = { value = "AuditIfNotExists" }
  })
}

data "azurerm_client_config" "current" {}
