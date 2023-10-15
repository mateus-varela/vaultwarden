#################
# Security group
#################

variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC associated with the security group"
  type        = string
}

variable "name" {
  description = "Name of security group"
  type        = string
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

##########
# Ingress
##########

variable "ingress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_blocks" {
  description = "List of computed ingress rules to create where 'cidr_blocks' is used"
  type        = list
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of computed ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "number_of_ingress_with_cidr_blocks" {
  description = "Number of computed ingress rules to create where 'cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_ingress_with_source_security_group_id" {
  description = "Number of computed ingress rules to create where 'source_security_group_id' is used"
  type        = number
  default     = 0
}

#########
# Egress
#########

variable "egress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_blocks" {
  description = "List of computed egress rules to create where 'cidr_blocks' is used"
  type        = list
  default = []
}

variable "egress_with_source_security_group_id" {
  description = "List of computed egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "number_of_egress_with_cidr_blocks" {
  description = "Number of computed egress rules to create where 'cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_egress_with_source_security_group_id" {
  description = "Number of computed egress rules to create where 'source_security_group_id' is used"
  type        = number
  default     = 0
}
