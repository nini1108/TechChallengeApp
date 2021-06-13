
resource "aws_security_group" "security_group" {
  name        = var.security_group_name
  description = "traffic rules"
  vpc_id      = var.vpc_id_sg


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
