variable "hub_rg_name" { type = string }
variable "spoke_rg_name" { type = string }
variable "rbac" {
  type = object({
    hub_contributors   = list(string)
    spoke_contributors = list(string)
    readers            = list(string)
  })
}
