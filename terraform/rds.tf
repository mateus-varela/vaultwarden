module "DB_MYSQL" {
  source                   = "./_modules/rds"
  depends_on               = [module.SG_WORKERS_RDS]
  create_with_bootstrap    = "true"
  subnet_bootstrap_id      = module.SUBNETS.private_subnets[0]
  vpc_security_group_ids   = module.SG_WORKERS_RDS.security_group_id
  identifier               = "db-vaultwarden"
  subnet_ids               = module.SUBNETS.private_subnets
  engine                   = "mysql"
  engine_version           = "5.7"
  instance_type            = "db.t2.micro"
  tags                     = var.tags
}
