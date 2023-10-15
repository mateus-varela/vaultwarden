variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "subnet_id" {
}

variable "tags" {}

variable "vpc_security_group_ids" {}

variable "associate_public_ip_address" {
  type = bool
}