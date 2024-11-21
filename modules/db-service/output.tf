output "cosmosdb_key" {
   value = azurerm_cosmosdb_account.tasker-cosmosdb-account.primary_key
   sensitive   = true
}