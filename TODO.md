# Vídeo 0: Apresentação do projeto

- Objetivo do projeto
- Introdução ao projeto e seus componentes.
- Visão geral da arquitetura proposta.
- Desenho e explicação das escolhas
- Explicar que é um projeto completo para abordar diversos pontos e ferramentas

## Pré requisitos: AWS CLI, Helm, OpenTofu ou Terraform, repositório no GitHub, conta na AWS, 


# Vídeo 1: Preparação da Infraestrutura com Terraform

- Configuração do ambiente de desenvolvimento local.
- Demonstração da estrutura do Terraform
- Explicar que é modular, e que não vou focar em escrever o código, mas dar uma visão geral apenas
- Escrever código do bucket e deploy manual via maquina
- Implementação do tfstate remoto no AWS S3.
- Enquanto o código fica sendo deployado, explicar algumas coisas
- Explicar sobre boas praticas de terraform (OpenTofu)
- Configuração do backend do Terraform.

# Vídeo 2: Configuração da Pipeline deploy terraform com GitHub Actions

- Introdução às GitHub Actions.
- Configuração do arquivo de fluxo de trabalho (workflow).
- Definição dos passos da pipeline
- Mostrar o que vai ser criado com o terraform
- Integração com AWS para autenticação e acesso aos recursos.
- Execução da pipeline e monitoramento dos resultados.

# Vídeo 3: Implementação da CI 

### A decidir se vou usar Jenkins ou GitHub Actions

- Breve introdução a ferramenta que vou usar e seu papel na integração contínua.
- Configuração de uma instância EC2 para o Jenkins. (Caso use Jenkins)
- Instalação e configuração do Jenkins na instância. (Caso use Jekins)
- Configuração do Jenkinsfile para automação do pipeline. (Caso use Jenkins )
- Ensinar o FROM vaultwarden/server:latest para criar uma imagem e enviar pro seu repositório
- Integrar pipeline com o registry da AWS
- Build da imagem da aplicação e análise de vulnerabilidades com Trivy.
- Integração com o REPOSITÓRIO para disparo automático da pipeline.
- Execução da pipeline e análise dos resultados.

# Vídeo 4: Implantação e Gerenciamento com Argo CD

- Introdução ao Argo CD e seus benefícios.
- Falar sobre GitOps
- Instalação e configuração do Argo CD no cluster EKS.
- Escrever manifestos
- Falar sobre ingress nginx + lets encrypt 
- Configuração das aplicações e definição dos recursos no Argo CD.
- Fluxo de GitOps com o Argo CD.
- Implantação e atualização automática da aplicação através do Argo CD.
- Monitoramento e gerenciamento das aplicações implantadas.

# Vídeo 5: Implementação do kube-prometheus e grafana

- Explicação da stack poderosa prometheus + grafana
- Demonstração de instalação
- Explicação sobre como funciona, node exporter, que ele que vai buscar as métricas, aplicação precisa estar com ela exposta
- Configuração do prometheus
- Configuração de dashboards do grafana

# Vídeo 6: Conclusão e Considerações Finais

- Demonstração do resultado
- Recapitulação dos principais pontos abordados nos vídeos anteriores.
- Discussão sobre os desafios enfrentados e lições aprendidas.
- Sugestões para aprendizado adicional e aprimoramento das habilidades em DevOps.
- Falar sobre novos projetos que virão