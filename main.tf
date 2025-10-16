
module "monitor" {
  source   = "./modules/monitor"
  project  = var.project
  location = var.location
}

module "hub" {
  source   = "./modules/hub"
  project  = var.project
  location = var.location
  hub_cidr = var.hub_cidr
  la_id    = module.monitor.la_id
}

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

module "policy" {
  source             = "./modules/policy"
  location           = var.location
  hub_rg_name        = module.hub.rg_name
  spoke_rg_name      = module.spoke_prod.rg_name
  log_analytics_id   = module.monitor.la_id
}

module "rbac" {
  source        = "./modules/rbac"
  hub_rg_name   = module.hub.rg_name
  spoke_rg_name = module.spoke_prod.rg_name
  rbac          = var.rbac
}
