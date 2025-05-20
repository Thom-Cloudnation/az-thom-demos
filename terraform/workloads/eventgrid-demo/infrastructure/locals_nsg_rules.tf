locals {
  # Rules from https://learn.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure
  frontend_pe_nsg_rules = {
    
  }
  frontend_nsg_rules = {
  #   101 = {
  #     name                       = "allow-traffic-from-pe"
  #     priority                   = 100
  #     direction                  = "Inbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "${local.snet_fe_pe_cidr}"
  #     destination_address_prefix = "*"
  #   }
  #   100 = {
  #     name                       = "allow-traffic-to-storage"
  #     priority                   = 100
  #     direction                  = "Outbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "*"
  #     destination_address_prefix = "Storage"
  #   }
  #   110 = {
  #     name                       = "allow-traffic-to-backend"
  #     priority                   = 110
  #     direction                  = "Outbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "*"
  #     destination_address_prefix = "${local.snet_be_pe_cidr}"
  #   }
  # }
  # backend_pe_nsg_rules = {
  #   101 = {
  #     name                       = "allow-traffic-from-frontend"
  #     priority                   = 100
  #     direction                  = "Inbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "${local.snet_fe_cidr}"
  #     destination_address_prefix = "*"
  #   }
  #   100 = {
  #     name                       = "allow-traffic-to-backend-snet"
  #     priority                   = 100
  #     direction                  = "Outbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "*"
  #     destination_address_prefix = "${local.snet_be_cidr}"
  #   }
  # }
  # backend_nsg_rules = {
  #   101 = {
  #     name                       = "allow-traffic-from-pe"
  #     priority                   = 100
  #     direction                  = "Inbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "${local.snet_be_pe_cidr}"
  #     destination_address_prefix = "*"
  #   }
  #   100 = {
  #     name                       = "allow-traffic-to-sql"
  #     priority                   = 100
  #     direction                  = "Outbound"
  #     access                     = "Allow"
  #     protocol                   = "*"
  #     source_port_range          = "*"
  #     destination_port_range     = "*"
  #     source_address_prefix      = "*"
  #     destination_address_prefix = "Sql"
  #   }
  }
}
