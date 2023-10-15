output "secret_values" {
  sensitive = true
  value = { for k, v in aws_secretsmanager_secret_version.credentials : k => jsondecode(aws_secretsmanager_secret_version.credentials[k].secret_string) }
}

output "db_admin_username" {
  description = "Username of admin user"
  value       = var.admin_username
}

output "db_admin_password" {
  description = "Password of admin user"
  sensitive = true
  value       = random_string.credentials["administrator"].result
}

output "project_secret_name" {
  description = "Project name to referenciate to the secrets manager DB user credentials"
  value       = var.project_secret_name
}