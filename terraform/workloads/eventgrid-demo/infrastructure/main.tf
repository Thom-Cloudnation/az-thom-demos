module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = "rg-${local.default_suffix}"
      location = local.location
    }
  }
}

module "vnet_frontend" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 8.0"

  vnet = {
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
    name           = local.vnet_fe_name
    address_space  = [local.vnet_fe_cidr]
    subnets        = local.fe_subnets
  }
}

resource "azurerm_service_plan" "asp_demo" {
  name                = "asp-${local.default_suffix}"
  os_type             = "Linux"
  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name
  sku_name            = local.asp_demo_sku
}

resource "azurerm_private_dns_zone" "prdns" {
  name                = local.prdns_connectivity
  resource_group_name = module.rg.groups.demo.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "prdns_fe_link" {
  name                  = "vnet_frontend-link"
  resource_group_name   = azurerm_private_dns_zone.prdns.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.prdns.name
  virtual_network_id    = module.vnet_frontend.vnet.id
  registration_enabled  = true
}

resource "azurerm_eventgrid_domain" "eventgrid_domain" {
  name                = "evgd-${local.default_suffix}"
  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name
  public_network_access_enabled = false
}

resource "azurerm_linux_function_app" "function" {
  name                       = "func-${local.default_suffix}"
  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name
  service_plan_id        = azurerm_service_plan.asp_demo.id
  storage_account_name       = module.storage.account.name
  storage_account_access_key = module.storage.account.primary_access_key

  site_config {
    application_stack {
      dotnet_version = "9.0"
    }  # Change according to your runtime
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_linux_function_app.function.id
  subnet_id      = module.vnet_frontend.subnets[local.snet_fe_name].id
}

module "storage" {
  source  = "cloudnationhq/sa/azure"
  version = "~> 3.0"
  naming  = { storage_container = "stct" }
  storage = {
    name           = "${local.naming.storage_account.name}2"
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
    blob_properties = {
      containers = {
        files = {
          metadata = {
            project = "Demo Coporation"
            owner   = "Demo Coporation"
          }
        }
      }
    }
    network_rules = {
      virtual_network_subnet_ids = [module.vnet_frontend.subnets[local.snet_fe_name].id]
    }
  }
}

resource "azurerm_private_endpoint" "pe_eventgrid_domain" {
  name                = "pe-app-fe-${local.default_suffix}"
  subnet_id           = module.vnet_frontend.subnets[local.snet_fe_pe_name].id
  location            = module.rg.groups.demo.location
  resource_group_name = module.rg.groups.demo.name
  

  private_service_connection {
    name                           = "fe-privateserviceconnection"
    private_connection_resource_id = azurerm_eventgrid_domain.eventgrid_domain.id
    is_manual_connection           = false
    subresource_names              = ["domain"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.prdns.id]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.prdns_fe_link]
}