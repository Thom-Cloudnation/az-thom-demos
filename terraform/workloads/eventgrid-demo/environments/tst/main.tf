module "naming" {
  source  = "CloudNationHQ/naming/azure"
  version = "~>  0.1.0"
  suffix  = ["demo", "eventgrid", "prd"]
}

module "infrastructure" {
  source          = "../../infrastructure"
  subscription_id = "6fcbf3eb-3ee6-401a-8d23-1aee9f932d36"
  naming          = module.naming
  config = {
    customer    = "eventgrid"
    workload    = "demo"
    environment = "tst"
  }
  location        = "uksouth"
  prdns_connectivity = "privatelink.eventgrid.azure.net"
  vnet_fe_cidr    = "10.1.0.0/24"
  snet_fe_cidr    = "10.1.0.0/27"
  snet_fe_pe_cidr = "10.1.0.32/27"
  asp_demo_sku = "B2"
}

