variable "subscription_id" {
  type        = string
  description = "Subscription ID"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "hub_rg_name" {
  type        = string
  description = "Hub Resource Group Name"
}

variable "spoke_rg_name" {
  type        = string
  description = "Spoke Resource Group Name"
}

variable "log_analytics_id" {
  type        = string
  description = "Log Analytics Workspace ID"
}
