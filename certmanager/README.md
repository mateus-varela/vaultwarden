# Cert Manater Jetstack with Helm

## Deploy Cert Manager
```bash
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
```

## Create a Cluster Issuer
```bash
kubectl apply -f ./clusterissuer.yaml
```

## Add to deployment manifest

ingress:
  enabled: true
  ingressClassName: "nginx"
  hostname: vault.mvarela.io
  path: /
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: "256m"
    cert-manager.io/cluster-issuer: letsencrypt-prod
  tls: true

