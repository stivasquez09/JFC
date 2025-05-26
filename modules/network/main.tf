resource "azurerm_virtual_network" "vnet01" {
  name                = "vnet01"
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = [var.vnetcidr]
}

resource "azurerm_subnet" "subnet1cidr" {
  name                 = "subnet1cidr"
  virtual_network_name = azurerm_virtual_network.vnet01.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.subnet1cidr]
}

resource "azurerm_subnet" "subnet2cidr" {
  name                 = "subnet2cidr"
  virtual_network_name = azurerm_virtual_network.vnet01.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.subnet2cidr]
}

resource "azurerm_subnet" "dbsubnet3cidr" {
  name                 = "dbsubnet3cidr"
  virtual_network_name = azurerm_virtual_network.vnet01.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.dbsubnet3cidr]
}