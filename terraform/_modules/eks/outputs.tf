output "security_group_node_id" {
  value = aws_security_group.eks_nodes.id
}

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}
