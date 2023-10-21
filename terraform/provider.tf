provider "aws" {

  profile = "default"
  region  = "us-east-1"
  default_tags {
    tags = {
      owner      = "Mateus Varela"
      managed-by = "terraform"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.EKS.endpoint
    cluster_ca_certificate = base64decode(module.EKS.kubeconfig_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}


provider "kubernetes" {
  host                   = module.EKS.endpoint
  cluster_ca_certificate = base64decode(module.EKS.kubeconfig_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
    command     = "aws"
  }
}

#  provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

#  provider "kubernetes" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~>2.4.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~>2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.7.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "~>2.1.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-mvarela-io-remote-state"
    key     = "mvarela-io/vaultwarden/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}