resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  
  tags = {}

  root_block_device {
    volume_size = 50
    volume_type = "gp2"
    encrypted   = true
  }

}

