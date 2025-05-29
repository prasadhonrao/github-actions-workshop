output "webapp_url" {
  value = azurerm_linux_web_app.webapp.default_hostname
}
