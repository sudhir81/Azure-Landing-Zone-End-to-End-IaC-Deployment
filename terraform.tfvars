
location   = "eastus"
project    = "lz"
hub_cidr   = "10.0.0.0/16"
spoke_cidr = "10.10.0.0/16"

la_id = "/subscriptions/1c95c3eb-55ac-4d47-bee1-e823c941e413/resourcegroups/loganalyticsworkspaces/providers/microsoft.operationalinsights/workspaces/alndingzoneloganalyticsworkspaces"

rbac = {
  hub_contributors   = []
  spoke_contributors = []
  readers            = []
}
