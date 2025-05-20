terraform {
  backend "azurerm" {
    resource_group_name   = "rg-tf-state"
    storage_account_name  = "stthomdemo"
    container_name        = "tfstate"
    key                   = "demo-tst.tfstate"
  }
}