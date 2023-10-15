variable "replica_count" {
  type = number
  default = 1
}


variable "certmanager_name" {
  type = string
  default = "cert-manager"
}

variable "chart_version" {
    type = string
    default = "4.0.13" 
}

variable "namespace" {
  type = string
  default = "cert-manager"
}

variable "public_subnets_ids" {
    type = list(string)
}