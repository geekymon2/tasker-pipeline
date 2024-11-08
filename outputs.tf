output "resource_group_name" {
  description = "Resource Group Name"
  value       = azurerm_resource_group.tasker-resources.name
}

output "location" {
  description = "Location"
  value       = azurerm_resource_group.tasker-resources.location
}

output "app_service_url" {
  description = "App Service URL"
  value       = module.app-service.app_service_url
}