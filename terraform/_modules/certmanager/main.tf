# # Cert Manater Jetstack with Helm

# ## Deploy Cert Manager
# ```bash
# helm repo add jetstack https://charts.jetstack.io
# helm repo update
# helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
# ```

# ## Create a Cluster Issuer
# ```bash
# kubectl apply -f ./clusterissuer.yaml
# ```


resource "helm_release" "this" {

  namespace     = "cert-manager"
  repository    = "https://charts.jetstack.io"
  name          = var.certmanager_name
  chart         = "cert-manager"
  force_update  = true
  wait          = false
  recreate_pods = false
  create_namespace = true



}


