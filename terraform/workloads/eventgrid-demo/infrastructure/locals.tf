locals {
  default_suffix = "${var.config.customer}-${var.config.workload}-${var.config.environment}"
}

locals {
  subscription_id = var.subscription_id
  naming          = var.naming
  location        = var.location
  prdns_connectivity = var.prdns_connectivity
  vnet_fe_name    = "vnet-frontend-${local.default_suffix}"
  vnet_fe_cidr    = var.vnet_fe_cidr
  snet_fe_pe_name    = "snet-frontend-pe-${local.default_suffix}"
  snet_fe_pe_cidr = var.snet_fe_pe_cidr
  snet_fe_name    = "snet-frontend-${local.default_suffix}"
  snet_fe_cidr    = var.snet_fe_cidr
  asp_demo_sku = var.asp_demo_sku
}
