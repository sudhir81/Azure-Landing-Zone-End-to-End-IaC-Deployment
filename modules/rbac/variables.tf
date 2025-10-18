variable "hub_rg_id" {
  description = "The ID of the Hub Resource Group"
  type        = string
}

variable "spoke_rg_id" {
  description = "The ID of the Spoke Resource Group"
  type        = string
}

variable "rbac" {
  description = "RBAC assignments object"
  type = object({
    hub_contributors   = list(string)
    spoke_contributors = list(string)
    readers            = list(string)
  })
}
