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
}