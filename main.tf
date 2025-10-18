# =============================
# Root main.tf
# Azure Landing Zone - End-to-End IaC Deployment
# =============================

# 🔍 Monitoring Module
module "monitor" {
  source   = "./modules/monitor"
  project  = var.project
  location = var.location
}

# 🏗️ Hub Network & Resources
module "hub" {
  source   = "./modules/hub"
  project  = var.project
  location = var.location
  hub_cidr = var.hub_cidr
  la_id    = module.monitor.la_id
}

# 🌐 Spoke Network (Prod)
module "spoke_prod" {
  source           = "./modules/spoke"
  project          = "${var.project}-prod"
  location         = var.location
  spoke_cidr       = var.spoke_cidr
  hub_vnet_id      = module.hub.vnet_id
  hub_vnet_name    = module.hub.vnet_name
  hub_rg           = module.hub.rg_name
  firewall_priv_ip = module.hub.firewall_private_ip
  route_table_id   = module.hub.route_table_id
}

# 🛡️ Policy Module (Built-in / Custom Policies)
module "policy" {
  source          = "./modules/policy"
  subscription_id = "1c95c3eb-55ac-4d47-bee1-e823c941e413"
  location        = var.location

  # ✅ Passing RG names from outputs
  hub_rg_name   = module.hub.rg_name
  spoke_rg_name = module.spoke_prod.rg_name

  # ✅ Pass Log Analytics Workspace ID to audit diagnostic policy
  log_analytics_id = module.monitor.la_id
}

# 👤 RBAC Assignments
module "rbac" {
  source = "./modules/rbac"

  # ✅ Pass Resource Group IDs from module outputs
  hub_rg_id   = module.hub.rg_id
  spoke_rg_id = module.spoke_prod.rg_id

  # ✅ RBAC object from terraform.tfvars
  rbac = var.rbac
}
