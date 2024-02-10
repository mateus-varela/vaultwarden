resource "aws_ecr_repository" "this" {
#  for_each             = toset(var.ecr_name)
  name                 = var.ecr_name
  image_tag_mutability = var.image_mutability
  encryption_configuration {
    encryption_type = var.encrypt_type
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.tags
}