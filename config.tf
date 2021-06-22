provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.51.0"
    }
  }

  required_version = ">= 0.15.0"

  backend "azurerm" {
    subscription_id      = "CHANGE-ME"
    resource_group_name  = "CHANGE-ME"
    storage_account_name = "CHANGE-ME"
    container_name       = "tfstate"
    key                  = "aks.tfstate"
  }
}
