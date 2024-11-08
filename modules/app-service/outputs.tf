output "app_service_url" {
  description = "App Service URL"
  value       = "${azurerm_linux_web_app.tasker-linux-web-app.name}.azurewebsites.net"
}