variable "environment" {
  description = "Indicates the environment associated with the resources being created"
  type        = string
  default     = ""
}

variable "project_secret_name" {
  description = "Project name to referenciate to the secrets manager DB user credentials"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "additional_users" {
  type = list(string)
  default = []
}

variable "admin_username" {
  type = string
  default = "administrator"
}