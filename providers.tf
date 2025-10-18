# =============================
# providers.tf
# Azure Landing Zone - End-to-End IaC Deployment
# =============================

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # ✅ Always use 4.x for latest policy/resource support
    }
  }

  backend "azurerm" {
    # ✅ Backend config is supplied via backend.hcl
  }
}

# =============================
# AzureRM Provider Configuration
# =============================

provider "azurerm" {
  features {}

  # ✅ Optional but recommended: explicitly pass subscription ID
  #    (can also be set via ARM_SUBSCRIPTION_ID environment variable)
  subscription_id = var.subscription_id
}

# =============================
# (Optional) Data Blocks (for Subscription/Tenant)
# =============================

# Useful if you want to reference subscription/tenant info elsewhere
data "azurerm_client_config" "current" {}
