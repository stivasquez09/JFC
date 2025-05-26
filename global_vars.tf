variable "location" {
  description = "value"
  default     = "Central US"
  type        = string
}

variable "rg_name" {
  description = "nombre del resource group"
  default     = "rg_pragma01"
  type        = string
}

variable "vnetcidr" {

  default = "10.10.0.0/16"
}

variable "subnet1cidr" {
  default = "10.10.1.0/24"
  type        = string

}
variable "subnet2cidr" {
  default = "10.10.2.0/24"
}

variable "dbsubnet3cidr" {
  default = "10.10.3.0/24"

}


variable "primary_database" {
  default = "db-pragma012025"
}
variable "primary_database_version" {
  default = "12.0"
}

variable "TF_VAR_DB_ADMIN_USERNAME" {
  description = "Nombre del usuario administrador para la bd sql"
  type        = string
  sensitive   = true
}

variable "TF_VAR_DB_ADMIN_PASSWORD" {
  description = "Contraseña del usuario administrador para la bd sql"
  type        = string
  sensitive   = true
}
