resource "aws_launch_template" "this" {
  name = var.launch_template

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 80
      volume_type = "gp3"
    }
  }

  vpc_security_group_ids = [aws_security_group.eks_nodes.id]
}

# Nodes in private subnets
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.private_subnet_ids

  launch_template {
    name    = aws_launch_template.this.name
    version = aws_launch_template.this.latest_version
  }

  ami_type       = var.ami_type
  instance_types = var.eks_instance_types

  scaling_config {
    desired_size = var.pvt_desired_size
    max_size     = var.pvt_max_size
    min_size     = var.pvt_min_size
  }

  tags = {
    Name = var.node_group_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_worker_node_policy,
    aws_iam_role_policy_attachment.aws_eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_read_only,
  ]
}

