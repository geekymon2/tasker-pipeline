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

  subscription_id = "eaf65449-c252-40a6-adfc-7b40b921db14"
  tenant_id       = "1a8baaf8-8855-40d4-9585-ae6328c54068"
}

module "app-service" {
  source              = "./modules/app-service"
  resource_group_name = azurerm_resource_group.tasker-resources.name
  location            = azurerm_resource_group.tasker-resources.location
}

resource "azurerm_resource_group" "tasker-resources" {
  name     = "tasker-resources"
  location = "Australia East"
}