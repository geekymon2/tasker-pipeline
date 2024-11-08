resource "azurerm_cosmosdb_account" "tasker-cosmosdb-account" {
  name                      = "tasker-cosmosdb-account"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"

  geo_location {
    location          = var.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  depends_on = [
    azurerm_resource_group.tasker-resources
  ]
}

resource "azurerm_cosmosdb_sql_database" "tasker-cosmosdb-sqldb" {
  name                = "tasker-db"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.tasker-cosmosdb-account.name
  throughput          = var.throughput
}

resource "azurerm_cosmosdb_sql_container" "tasker-cosmosdb-sqlcontainer" {
  name                  = "tasker-cosmosdb-sqlcontainer"
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.tasker-cosmosdb-account.name
  database_name         = azurerm_cosmosdb_sql_database.tasker-cosmosdb-sqldb.name
  partition_key_paths    = "/id"
  partition_key_version = 1
  throughput            = var.throughput

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}