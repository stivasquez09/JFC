# Set the Azure Provider source and version being used
terraform {


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}


module "resourcegroup" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

module "networking" {
  source         = "./modules/network"
  location       = var.location
  resource_group = module.resourcegroup.resource_group_name
  vnetcidr       = var.vnetcidr
  subnet1cidr    = var.subnet1cidr
  subnet2cidr    = var.subnet2cidr
  dbsubnet3cidr  = var.dbsubnet3cidr
}

module "AutoScaling" {
  source         = "./modules/compute"
  rg_name        = var.rg_name
  location       = var.location
  resource_group = module.resourcegroup.resource_group_name
  subnet1cidr    = module.networking.subnet1_id
}

module "basededatos" {
  source                   = "./modules/databases"
  location                 = var.location
  rg_name                  = var.rg_name
  TF_VAR_DB_ADMIN_USERNAME = var.TF_VAR_DB_ADMIN_USERNAME
  TF_VAR_DB_ADMIN_PASSWORD = var.TF_VAR_DB_ADMIN_PASSWORD
  primary_database         = var.primary_database
  primary_database_version = var.primary_database_version

}
# #configure logs
# resource "azurerm_log_analytics_workspace" "logs" {
#   name                = "law-observability"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }
# #configure app insights
# resource "azurerm_application_insights" "appinsights" {
#   name                = "appi-ecommerce"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   application_type    = "web"
#   workspace_id        = azurerm_log_analytics_workspace.logs.id
# }

# resource "azurerm_virtual_machine_extension" "oms_agent" {
#   name                 = "OmsAgentForLinux"
#   virtual_machine_id   = azurerm_linux_virtual_machine_scale_set.vmss.id
#   publisher            = "Microsoft.EnterpriseCloud.Monitoring"
#   type                 = "OmsAgentForLinux"
#   type_handler_version = "1.13"
#   settings = jsonencode({
#     workspaceId = azurerm_log_analytics_workspace.logs.workspace_id
#   })
#   protected_settings = jsonencode({
#     workspaceKey = azurerm_log_analytics_workspace.logs.primary_shared_key
#   })
# }
