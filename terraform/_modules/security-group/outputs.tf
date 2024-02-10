output "security_group_id" {
  description = "The ID of the security group"
  value       = local.this_sg_id
}

output "vpc_id" {
  description = "The VPC ID"
  value       = aws_security_group.this[0].vpc_id
}

output "owner_id" {
  description = "The owner ID"
  value       = aws_security_group.this[0].owner_id
}

output "name" {
  description = "The name of the security group"
  value       = aws_security_group.this[0].name
}

output "description" {
  description = "The description of the security group"
  value       = aws_security_group.this[0].description
}

output "ingress" {
  description = "The ingress rules"
  value       = aws_security_group.this[0].ingress
}
output "this_security_group_egress" {
  description = "The egress rules"
    value       = aws_security_group.this[0].egress
}
