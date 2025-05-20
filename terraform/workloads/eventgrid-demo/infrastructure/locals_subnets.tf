locals {
  fe_subnets = {
    "${local.snet_fe_name}" = {
      name                                          = local.snet_fe_name
      address_prefixes                              = [local.snet_fe_cidr]
      service_endpoints                             = ["Microsoft.Storage"]
      private_endpoint_network_policies             = "Enabled"
      private_link_service_network_policies_enabled = true
      delegations = {
        web = {
          name = "Microsoft.Web/serverFarms"
        }
      }
      network_security_group = {
        name = "nsg-frontend-${local.default_suffix}"
        rules = local.frontend_nsg_rules
      }
    }
    "${local.snet_fe_pe_name}" = {
      name                                          = local.snet_fe_pe_name
      address_prefixes                              = [local.snet_fe_pe_cidr]
      private_endpoint_network_policies             = "Enabled"
      private_link_service_network_policies_enabled = true
      network_security_group = {
        name = "nsg-frontend-pe-${local.default_suffix}"
        rules = local.frontend_pe_nsg_rules
      }
    }
  }
}
