terraform {
  backend "azurerm" {
    storage_account_name = "walmartatx"
    container_name       = "walmartatx-remote-state-container"
    key                  = "dev.terraform.tfstate"
    resource_group_name = "walmartatx-remote-state-rg"
  }
}