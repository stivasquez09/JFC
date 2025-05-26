# modulo deprecado 
#resource "azurerm_sql_server" "primary" {
#   name                         = var.primary_database
#   resource_group_name          = var.rg_name
#   location                     = var.location
#   version                      = var.primary_database_version
#   administrator_login          = var.TF_VAR_DB_ADMIN_USERNAME
#   administrator_login_password = var.TF_VAR_DB_ADMIN_PASSWORD
# }

# resource "azurerm_sql_database" "db" {
#   name                = "db"
#   resource_group_name = var.rg_name
#   location            = var.location
#   server_name         = azurerm_sql_server.primary.name
# }


resource "azurerm_mssql_server" "primary" {
  name                         = var.primary_database
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.TF_VAR_DB_ADMIN_USERNAME
  administrator_login_password = var.TF_VAR_DB_ADMIN_PASSWORD
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "db" {
  name                = "ecommerce-db"
  server_id           = azurerm_mssql_server.primary.id
  sku_name            = "Basic"
}