output "network_name" {
  value = azurerm_virtual_network.vnet01.name
  description = "Name of the Virtual network"
}

output "subnet1_id" {
  value = azurerm_subnet.subnet1cidr.id
  description = "Id of websubnet in the network"
}

output "subnet2_id" {
  value = azurerm_subnet.subnet2cidr.id
  description = "Id of appsubnet in the network"
}

output "dbsubnet3_id" {
  value = azurerm_subnet.dbsubnet3cidr.id
  description = "Id of dbsubnet in the network"
}