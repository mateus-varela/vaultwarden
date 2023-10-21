variable "replica_count" {
  type = number
  default = 1
}


variable "app_name" {
  type = string
  default = "nginx-ingress-controller"
}

variable "chart_version" {
    type = string
    default = "4.0.13" 
}

variable "namespace" {
  type = string
  default = "nginx-ingress-controller"
}

variable "security_group" {
  
}

variable "ingress_class_name" {
    type = string
    default = "nginx-controller"
  
}

variable "public_subnets_ids" {
    type = list(string)
}