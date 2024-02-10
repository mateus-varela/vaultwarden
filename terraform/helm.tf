module "CERTMANAGER" {
  source = "./_modules/helm-release"

  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"

  app = {
    name          = "cert-manager"
    chart         = "cert-manager"
    version       = null
    force_update  = true
    wait          = true
    recreate_pods = true
    max_history   = 0
    lint          = true
  }

  set = [
    {
      name  = "installCRDs"
      value = "true"
    }
  ]
}

module "NGINX_INGRESS_CONTROLLER" {
  source             = "./_modules/helm-release/nginx-ingress-controller"
  security_group     = module.SG_INGRESS_CONTROLLER.security_group_id
  ingress_class_name = "nginx"
  public_subnets_ids = module.SUBNETS.public_subnets
}

module "ARGOCD" {
  source = "./_modules/helm-release"

  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"

  app = {
    create_namespace = true
    name             = "argocd"
    force_update     = true
    wait             = true
    recreate_pods    = true
    chart            = "argo-cd"
    version          = "3.35.4"
    timeout          = var.timeout_seconds
  }

  values = [file("./_modules/helm-release/argocd-values.yaml")]

}
# # helm install argocd -n argocd -f values/argocd.yaml
# # k port-forward svc/argocd-server -n argocd 8080:80
# # k get secrets argocd-initial-admin-secret -o yaml -n argocd
# }

# # module "CONSUL" {
# #   source = "./_modules/helm-release"
# #   namespace = "consul"
# #   repository = "https://marketplace.azurecr.io/helm/v1/repo"

# #   app = {
# #     chart         = "azure-marketplace//consul"
# #     force_update  = true
# #     name          = "consul"
# #     recreate_pods = true
# #     reuse_values  = true
# #   }

# #   values = [<<EOF
# # ImageTag: "1.4.0"
# # EOF
# #   ]

# # }

# module "TRAEFIK" {
#   source = "./_modules/helm-release"
  
#   namespace  = "traefik"
#   repository = "https://traefik.github.io/charts"

#   app = {
#     create_namespace = true
#     name             = "traefik"
#     force_update     = true
#     wait             = true
#     reuse_values     = true
#     recreate_pods    = true
#     version          = "21.1.0"
#     chart            = "traefik"
#     timeout          = var.timeout_seconds
#   }

#   values = [file("./_modules/helm-release/traefik-values.yaml")]

# }
