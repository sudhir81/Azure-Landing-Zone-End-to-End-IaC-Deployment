# =============================
# Root variables.tf
# Azure Landing Zone - End-to-End IaC Deployment
# =============================

# 🌍 Project name (used as prefix for resources)
variable "project" {
  description = "The name of the project or landing zone prefix"
  type        = string
}

# 📍 Azure region
variable "location" {
  description = "The Azure region to deploy resources into"
  type        = string
  default     = "eastus"
}

# 🌐 Hub VNet CIDR
variable "hub_cidr" {
  description = "CIDR block for the Hub virtual network"
  type        = string
}

# 🌐 Spoke VNet CIDR
variable "spoke_cidr" {
  description = "CIDR block for the Spoke virtual network"
  type        = string
}

# 🔐 RBAC configuration
variable "rbac" {
  description = "RBAC assignments for Hub and Spoke resource groups"
  type = object({
    hub_contributors   = list(string) # Object IDs of contributors for Hub RG
    spoke_contributors = list(string) # Object IDs of contributors for Spoke RG
    readers            = list(string) # Object IDs of readers for Spoke RG
  })
}

# 🛡️ Optional: Subscription ID (can also be set via environment variable)
variable "subscription_id" {
  description = "Azure subscription ID where resources will be deployed"
  type        = string
}

# 🪵 Optional: Log Analytics Workspace retention period (used by monitor module)
variable "log_retention_days" {
  description = "Number of days to retain logs in Log Analytics Workspace"
  type        = number
  default     = 30
}
