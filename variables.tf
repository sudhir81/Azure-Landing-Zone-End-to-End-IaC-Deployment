
variable "location" {
  type    = string
  default = "eastus"
}

variable "project" {
  type    = string
  default = "lz"
}

variable "hub_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "spoke_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "rbac" {
  type = object({
    hub_contributors   = list(string)
    spoke_contributors = list(string)
    readers            = list(string)
  })
  default = {
    hub_contributors   = []
    spoke_contributors = []
    readers            = []
  }
}
