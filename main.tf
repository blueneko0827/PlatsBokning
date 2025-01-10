variable "db_password" {
    type = string
    description = "The password for the database"
    sensitive = true
}

variable "azure_db_password" {
    type = string
    description = "The password for the database"
    sensitive = true
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
    name = "booking-desk-rg"
    location = "West Europe"
}

resource "azure_app_service_plan" "app_service_plan" {
    name = "booking-desk-app-service-plan"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    sku {
        tier = "Basic"
        size = "B1"
    }
}

# Database
resource "azurerm_postgresql_flexible_server" "db" {
    name = "booking-desk-db"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    administrator_login = "apiusser"
    administrator_password = var.db_password
    sku_name = "Standard_B1ms"
    storage_mb = 32768
    version = "14" 
    backup_retention_days = 1
    geo_redundant_backup_enabled = false
    public_network_access_enabled = true
    administrator_login_password = var.azure_db_password
}