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

terraform {
  backend "azurerm" {
    resource_group_name  = "GeekyMon2Storage"
    storage_account_name = "geekymon2storageaccount"
    container_name       = "geekymon2-storage-container"
    key                  = "terraform.tfstate"
  }
}

module "app-service" {
  source              = "./modules/app-service"
  resource_group_name = azurerm_resource_group.tasker-resources.name
  location            = azurerm_resource_group.tasker-resources.location
  db_account_name     = module.db-service.db_account_name
}

module "db-service" {
  source              = "./modules/db-service"
  resource_group_name = azurerm_resource_group.tasker-resources.name
  location            = azurerm_resource_group.tasker-resources.location
  db_account_name     = "tasker-cosmosdb-account"
}

resource "azurerm_resource_group" "tasker-resources" {
  name     = "tasker-resources"
  location = "Australia East"
}