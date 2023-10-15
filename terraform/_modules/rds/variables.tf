variable "allocated_storage" {
  description = "Tamanho alocado de armazenamento para o RDS MySQL"
  type        = number
  default     = 20
}

variable "identifier" {
  description = "Identifier"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instância do RDS MySQL"
  type        = string
}

variable "username" {
  description = "Nome de usuário do RDS MySQL"
  type        = string
  default     = "admin"
}

variable "admin_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "administrator"
}

variable "engine" {
  description = "Motor de banco de dados do RDS MySQL"
  type        = string
}

variable "engine_version" {
  description = "Versão do motor de banco de dados do RDS MySQL"
  type        = string
}

variable "storage_type" {
  description = "Tipo de armazenamento do RDS MySQL"
  type        = string
  default     = "gp2"
}

variable "create_with_bootstrap" {
  type = bool
  default = false
}

variable "subnet_ids" {
  type = list(string)
}

variable "subnet_bootstrap_id" {
  
}

variable "vpc_security_group_ids" {
  
}


variable "parameter_group_name" {
  type    = string
  default = "custom-mysql-parameters"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "additional_users" {
  type    = list(string)
  default = []
}

variable "environment" {
  type = string
  default = "dev"
}

