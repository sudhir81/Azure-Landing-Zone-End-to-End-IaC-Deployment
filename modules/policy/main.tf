# =====================================
# modules/policy/main.tf - Fixed Version
# =====================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# --------------------------------------------
# Deny Public IP - Applied to Spoke RG
# --------------------------------------------
resource "azurerm_policy_assignment" "deny_public_ip" {
  name                 = "deny-public-ip"
  display_name         = "Deny Public IPs"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.spoke_rg_name}"
  location             = var.location
  description          = "Deny public IPs on resources in the Spoke RG."

  metadata = jsonencode({
    assignedBy = "Terraform"
  })
}

# --------------------------------------------
# Require Tags on All Resources - Applied to Hub RG
# --------------------------------------------
resource "azurerm_policy_assignment" "require_tags" {
  name                 = "require-tags"
  display_name         = "Require Tags on Resources"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4f9d6fdd-7b84-4cf2-9fdb-3b6d7c66a1f2"
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.hub_rg_name}"
  location             = var.location
  description          = "Ensure all resources in Hub RG have required tags."

  metadata = jsonencode({
    assignedBy = "Terraform"
  })
}

# --------------------------------------------
# Audit Diagnostic Settings - Applied to both Hub and Spoke RGs
# --------------------------------------------
resource "azurerm_policy_assignment" "audit_diag_hub" {
  name                 = "audit-diagnostics-hub"
  display_name         = "Audit Diagnostic Settings (Hub)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1a569ee6-ff41-4d34-8e38-3c4f1bdf5c13"
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.hub_rg_name}"
  location             = var.location
  description          = "Audit that diagnostic settings are enabled in Hub RG."

  metadata = jsonencode({
    assignedBy = "Terraform"
  })

  parameters = jsonencode({
    logAnalytics = {
      value = var.log_analytics_id
    }
  })
}

resource "azurerm_policy_assignment" "audit_diag_spoke" {
  name                 = "audit-diagnostics-spoke"
  display_name         = "Audit Diagnostic Settings (Spoke)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1a569ee6-ff41-4d34-8e38-3c4f1bdf5c13"
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.spoke_rg_name}"
  location             = var.location
  description          = "Audit that diagnostic settings are enabled in Spoke RG."

  metadata = jsonencode({
    assignedBy = "Terraform"
  })

  parameters = jsonencode({
    logAnalytics = {
      value = var.log_analytics_id
    }
  })
}

# ------------------------
# Outputs
# ------------------------
output "deny_public_ip_id" {
  value = azurerm_policy_assignment.deny_public_ip.id
}

output "require_tags_id" {
  value = azurerm_policy_assignment.require_tags.id
}

output "audit_diag_hub_id" {
  value = azurerm_policy_assignment.audit_diag_hub.id
}

output "audit_diag_spoke_id" {
  value = azurerm_policy_assignment.audit_diag_spoke.id
}
