resource "azurerm_service_plan" "tasker-service-plan" {
  name                = "tasker-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "tasker-linux-web-app" {
  name                = "tasker-linux-web-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.tasker-service-plan.id

  site_config {
    always_on = false

    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    "AppConfig__CosmosEndpoint" = "${var.db_account_name}.documents.azure.com:443/"
    "AppConfig__CosmosKey" = "${azurerm_cosmosdb_account.tasker-cosmosdb-account.primary_master_key}"
    "AppConfig__CosmosDatabase" = "tasker-db"
    "AppConfig__CosmosContainer" = "tasker-cosmosdb-sqlcontainer"
  }  

  logs {
    application_logs {
      file_system_level = "Verbose"
      azure_blob_storage {
        level           = "Verbose"
        sas_url         = "https://geekymon2storageaccount.blob.core.windows.net/$logs?sp=racwdl&st=2024-11-18T07:03:43Z&se=2024-11-24T15:03:43Z&skoid=d56f2583-f7b7-4da7-81d4-a2a605cc463e&sktid=1a8baaf8-8855-40d4-9585-ae6328c54068&skt=2024-11-18T07:03:43Z&ske=2024-11-24T15:03:43Z&sks=b&skv=2022-11-02&spr=https&sv=2022-11-02&sr=c&sig=i%2FbcK0Da04VokmO1kczhCGAuB1F2bBwsSwWx5XkFtAU%3D"
        retention_in_days = 30
      }
    }      
  }
}