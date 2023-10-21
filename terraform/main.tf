data "aws_availability_zones" "available" {
  state = "available"
}


module "VPC" {
  source = "./_modules/vpc-modules/vpc"

  name = "mvarela-io"

  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  enable_dns_hostnames = true
  tags                 = var.tags
}

module "SUBNETS" {
  source = "./_modules/vpc-modules/subnets"

  name = "mvarela-io"

  single_nat_gateway = true
  azs                = data.aws_availability_zones.available.names
  enable_nat_gateway = true

  vpc_id = module.VPC.vpc_id
  igw_id = module.VPC.igw_id

  private_subnets = var.cidrs["private"]
  public_subnets  = var.cidrs["public"]


  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
    "kubernetes.io/role/internal-elb"               = "1",
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
    "kubernetes.io/role/elb"                        = "1",
  }
  tags = var.tags
}


## EKS Cluster
module "EKS" {
  source = "./_modules/eks"
  # Cluster
  vpc_id                 = module.VPC.vpc_id
  cluster_sg_name        = "${var.eks_cluster_name}-cluster-sg-mvarela-io"
  nodes_sg_name          = "${var.eks_cluster_name}-node-sg-mvarela-io"
  eks_cluster_name       = var.eks_cluster_name
  eks_cluster_subnet_ids = module.SUBNETS.private_subnets
  cluster_version        = var.cluster_version

  # Node group configuration (including autoscaling configurations)
  pvt_desired_size        = 2
  pvt_max_size            = 3
  pvt_min_size            = 2
  endpoint_private_access = true
  node_group_name         = "${var.eks_cluster_name}-node-group"
  private_subnet_ids      = module.SUBNETS.private_subnets

}

module "ECR" {
  source           = "./_modules/ecr"
  ecr_name         = var.ecr_name
  tags             = var.tags
  image_mutability = var.image_mutability
}


# module "EC2_JENKINS_MASTER" {
#   source = "./_modules/ec2"

#   ami                         = var.ami
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   subnet_id                   = module.SUBNETS.public_subnets[0]
#   vpc_security_group_ids      = [module.SG_EC2.security_group_id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "Jenkins-Master"
#   }
# }

# module "EC2_JENKINS_AGENT" {
#   source = "./_modules/ec2"

#   ami                         = var.ami
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   subnet_id                   = module.SUBNETS.public_subnets[0]
#   vpc_security_group_ids      = [module.SG_EC2.security_group_id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "Jenkins-Agent"
#   }
# }

# module "EC2_ANSIBLE" {
#   source = "./_modules/ec2"

#   ami                         = var.ami
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   subnet_id                   = module.SUBNETS.public_subnets[0]
#   vpc_security_group_ids      = [module.SG_EC2.security_group_id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "Ansible"
#   }
# }
