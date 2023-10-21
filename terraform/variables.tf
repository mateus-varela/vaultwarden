
## VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "192.168.0.0/16"
}


## SUBNETS

variable "cidrs" {
  default = {
    private = ["192.168.0.0/20", "192.168.16.0/20", "192.168.32.0/20"]
    public  = ["192.168.48.0/20", "192.168.64.0/20", "192.168.80.0/20"]
  }
}

variable "eks_cluster_name" {
  default = "eks-mvarela-io"
  type    = string
}

variable "cluster_version" {
  default = "1.28"
  type    = string
}

variable "launch_template" {
  default = "mvarela-io"
}

variable "region" {
  description = "AWS region to deploy to"
  default     = "us-east-1"
  type        = string
}


variable "name" {
  description = "Name to be used as a basename on all the resources identifiers"
  default     = "RDS_BOOSTRAP_EPHEMERAL"
}

variable "subnet_id" {
  description = "Subnet in which the ephemeral instance is created"
  default     = ""
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}


variable "security_group_ids" {
  description = "A list of security groups the ephemeral instance will belong to"
  type        = list(string)
  default     = []
}

variable "endpoint" {
  description = "RDS connection endpoint"
  default     = ""
}


variable "mysql" {
  description = "RDS engine"
  default     = "mysql"
}

variable "postgresql" {
  description = "RDS engine"
  default     = "postgresql"
}

variable "shell_script" {
  description = "A shell script template that will be run from the ephemeral instanceRDS database name"
  default     = "mysql.sh"
}


variable "instance_type" {
  description = "Ephemeral instance type"
  default     = "t2.micro"
}

variable "tags" {
  description = "A mapping of tags to assign to ec2"
  type        = map(string)
  default     = {}
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "kms_key_rotation" {
  description = "Indicates whether or not the KMS key rotation should be enabled"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = ""
}

variable "create_from_last_snapshot" {
  description = "False is useed only when rds have no snapshot or to create a fresh instance...true by default in order to recover from failure"
  default     = false
}


variable "admin_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "administrator"
}
variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}


variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}


variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  type        = bool
  default     = false
}



variable "subnet_bootstrap_id" {
  default = "subnetid"
}

### BOOTSTRAP

variable "create_with_bootstrap" {
  default = false
}


variable "project_secret_name" {
  description = "project name to referenciate to the secrets manager DB user credentials"
  default     = "dev"
}
variable "debug_ec2" {
  default = false
}

variable "environment" {
  description = "Indicates the environment associated with the resources being created"
  type        = string
  default     = "dev"
}

## EC2

variable "key_name" {
  type    = string
  default = "mvarela-io"
}

variable "ami" {
  default = "ami-053b0d53c279acc90"
}

## ECR

variable "ecr_name" {
  description = "The list of ecr names to create"
  type        = string
  default     = "mvarela-io/vaultwarden"
}
variable "image_mutability" {
  description = "Provide image mutability"
  type        = string
  default     = "MUTABLE"
}

variable "encrypt_type" {
  description = "Provide type of encryption here"
  type        = string
  default     = "KMS"
}

variable "traefik_chart_version" {
  description = "Version of Traefik chart to install"
  type        = string
  default     = "21.1.0"
}

variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800
}