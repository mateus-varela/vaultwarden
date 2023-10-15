locals {
  secrets = concat(["${var.admin_username}"], var.additional_users)
}

resource "random_string" "credentials" {
  for_each = toset(local.secrets)
  length   = 15
  upper    = true
  lower    = true
  numeric  = true
  special  = false
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_secretsmanager_secret" "credentials" {
  for_each    = toset(local.secrets)
  name        = "${var.project_secret_name}/rds/${var.environment}/${each.value}-credentials3"
  description = "Credentials to ${var.project_secret_name} ${upper(each.value)} database for ${var.environment} Env"
  tags        = merge(var.tags, tomap({ "project" = var.project_secret_name, "type" = "database" }))
}

resource "aws_secretsmanager_secret_version" "credentials" {
  for_each  = toset(local.secrets)
  secret_id = aws_secretsmanager_secret.credentials[each.value].id
  secret_string = jsonencode({
    username = each.value
    password = random_string.credentials[each.value].result
  })
}
