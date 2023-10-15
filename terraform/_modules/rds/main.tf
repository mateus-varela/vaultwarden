resource "aws_db_instance" "this" {
  identifier                          = var.identifier
  allocated_storage                   = var.allocated_storage
  storage_type                        = var.storage_type
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_type
  username                            = module.DB_SECRETS.db_admin_username
  password                            = module.DB_SECRETS.db_admin_password
  vpc_security_group_ids              = [var.vpc_security_group_ids]
  db_subnet_group_name                = aws_db_subnet_group.this.name
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = true

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  apply_immediately = true

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.identifier)
    },
  )
}


# Security group for public subnet resources
resource "aws_db_subnet_group" "this" {
  name       = format("subnet-group-%s", var.identifier)
  subnet_ids = var.subnet_ids
  tags = merge(
    var.tags,
    {
      "Name" = format("subnet-group-%s", var.identifier)
    },
  )
}

module "DB_SECRETS" {
  source              = "./db_secrets"
  project_secret_name = var.identifier
  environment         = var.environment
  additional_users    = var.additional_users
  tags                = var.tags
  admin_username      = var.admin_username
}
