resource "helm_release" "this" {

  namespace     = "nginx-ingress"
  repository    = "https://kubernetes.github.io/ingress-nginx"
  name          = var.app_name
  version       = var.chart_version
  chart         = "ingress-nginx"
  force_update  = true
  wait          = false
  recreate_pods = false
  create_namespace = true

  set {
    name  = "controller.replicaCount"
    value = var.replica_count
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.ingressClass"
    value = var.ingress_class_name
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
    value = "internet-facing"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-extra-security-groups"
    value = var.security_group
  }

set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
    value = join("\\,", var.public_subnets_ids)
  }

}


