1 - Criar bucket e etc.
tofu init
tofu plan
tofu apply

2 - Mostrar bucket

3 - Rodar pipeline deploy terraform

4 - Acessar cluster via terminal
aws eks update-kubeconfig --region region-code --name my-cluster

5 - Se o argocd não estiver instalado, instalar.
helm install argocd -n argocd -f values/argocd.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:80 pra acessar o cluster
kubectl get secrets argocd-initial-admin-secret -o yaml -n argocd para pegar as senhas

echo "senha" | base64 --decode para decodificar

usuario admin

acessar com localhost:8080

build pipeline da imagem dockerfile

environment:
      ADMIN_TOKEN=randomPassword40characters

6 - configurar argo cd para puxar o repositorio e pasta certa do github

7 - aplicar clusterissuer do cert-manager

8 - criar namespace vaultwarden

CUIDAR COM STORAGE CLASS TEM QUE SER IMMEDIATE!

