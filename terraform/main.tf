provider "azurerm" {
  features {}
}

resource "random_string" "server" {
  length = 8
  special = false
}

resource "azurerm_resource_group" "rg" {
  name     = "Social-${random_string.server.result}-RG"
  location = "South Central US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "Social-${random_string.server.result}-ASP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "as" {
  name                = "Social-${random_string.server.result}-AS"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version = "v4.0"
  }
}