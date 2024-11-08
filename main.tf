terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "app-service" {
  source              = "./modules/app-service"
  resource_group_name = azurerm_resource_group.tasker-resources.name
  location            = azurerm_resource_group.tasker-resources.location
}

module "db-service" {
  source              = "./modules/db-service"
  resource_group_name = azurerm_resource_group.tasker-resources.name
  location            = azurerm_resource_group.tasker-resources.location
}

resource "azurerm_resource_group" "tasker-resources" {
  name     = "tasker-resources"
  location = "Australia East"
}