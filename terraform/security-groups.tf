module "SG_DB_BOOTSTRAP" {
  source                             = "./_modules/security-group"
  create                             = true
  vpc_id                             = module.VPC.vpc_id
  name                               = "sg db bootstrap"
  description                        = "Security group created to communicate RDS with Ephemeral Instance"
  number_of_ingress_with_cidr_blocks = 1
  ingress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Ingress Traffic"
    }
  ]
  number_of_egress_with_cidr_blocks = 1

  egress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Egress Traffic"
    }
  ]
  tags = var.tags
}

module "SG_WORKERS_RDS" {
  source                            = "./_modules/security-group"
  create                            = true
  vpc_id                            = module.VPC.vpc_id
  name                              = "sg workers rds"
  description                       = "Security group created to communicate RDS with EKS"
  number_of_egress_with_cidr_blocks = 1
  egress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Egress Traffic"
    }
  ]
  number_of_ingress_with_source_security_group_id = 4
  ingress_with_source_security_group_id = [
    {
      rule                     = "sg-bootstrap-mysql"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      source_security_group_id = module.SG_DB_BOOTSTRAP.security_group_id
    },
    {
      rule                     = "sg-bootstrap-pgsql"
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      source_security_group_id = module.SG_DB_BOOTSTRAP.security_group_id
    },

 {
      rule                     = "sg-workers-mysql"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      source_security_group_id = module.EKS.security_group_node_id
    },
    {
      rule                     = "sg-workers-pgsql"
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      source_security_group_id = module.EKS.security_group_node_id
    },

    
  ]
  tags = var.tags
}

module "SG_INGRESS_CONTROLLER" {
  source                             = "./_modules/security-group"
  create                             = true
  vpc_id                             = module.VPC.vpc_id
  name                               = "sg ingress controller"
  description                        = "Security group created to communicate Ingress NGINX with the world"
  number_of_ingress_with_cidr_blocks = 1
  ingress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Ingress Traffic"
    }
  ]
  number_of_egress_with_cidr_blocks = 1

  egress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Egress Traffic"
    }
  ]
  tags = var.tags
}


module "SG_EC2" {
  source                             = "./_modules/security-group"
  create                             = true
  vpc_id                             = module.VPC.vpc_id
  name                               = "sg EC2 instances"
  description                        = "Security group created to communicate RDS with Ephemeral Instance"
  number_of_ingress_with_cidr_blocks = 1
  ingress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Ingress Traffic"
    }
  ]
  number_of_egress_with_cidr_blocks = 1

  egress_with_cidr_blocks = [
    {
      rule        = "allow-all"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Allow All Egress Traffic"
    }
  ]
  tags = var.tags
}
