
resource "aws_instance" "ec2_instance_create" {
  ami           = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  key_name = var.ec2_key_name
  subnet_id = var.ec2_subnet_id
  vpc_security_group_ids = var.ec2_security_group_ids
  associate_public_ip_address = var.ec2_public_ip_address_true_false
  private_ip = var.ec2_private_ip
  user_data = var.ec2_user_data
 
  root_block_device {
            volume_size           = var.volume_size
            }

  tags = var.tags
}
