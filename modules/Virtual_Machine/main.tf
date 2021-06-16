
resource "aws_instance" "ec2_instance_create" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.public_ip_address_true_false
  private_ip                  = var.private_ip
  user_data                   = var.user_data

  root_block_device {
    volume_size = var.volume_size
  }

  tags = var.tags
}
