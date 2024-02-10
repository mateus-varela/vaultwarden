variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
  default = "mvarela-io"
}

variable "subnet_id" {
}

variable "tags" {
  description = "A mapping of tags to assign to ec2"
  type        = map(string)
  default     = {}
}

variable "vpc_security_group_ids" {}

variable "associate_public_ip_address" {
  type = bool
}
