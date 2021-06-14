


# Create sg for app servers
module "Sg_App" {
    source                  = "../modules/Networking/Security_Group"
    security_group_name	    = "${var.project_name}_${var.env}_app_sg"
    vpc_id_sg	            = module.VPC.id
    tags                    = { "Name":"${var.project_name}_app_sg", "project_name":var.project_name , "env": var.env}
}

# Create sg for applicatio load balancer
module "Sg_Alb" {
    source                  = "../modules/Networking/Security_Group"
    security_group_name	    = "${var.project_name}_${var.env}_alb_sg"
    vpc_id_sg	              = module.VPC.id
    tags                    = { "Name":"${var.project_name}_alb_sg", "project_name":var.project_name , "env": var.env}
}

# Add rule to allow ssh to app server
module "Allow_Cidr_Rule_Ssh_App_server" {
    source                  = "../modules/Networking/Security_Group_Rule/allow_CIDR_rule"
    rule_type               = "ingress"
    security_group_id       = module.Sg_App.id
    from_port	              = 22
    to_port	                = 22
    protocol                = "tcp"
    allowed_cidr_blocks	    = var.allowed_iprange
}


# Create sgrule for websg to allow 8080 from alb sg
module "Allow_Sg_Rule_ALB_to_App" {
    source                  = "../modules/Networking/Security_Group_Rule/allow_SG_rule"
    rule_type               = "ingress"
    security_group_id       = module.Sg_App.id
    from_port	              = 8080
    to_port	                = 8080
    protocol                = "tcp"
    allowed_security_grp_id	= module.Sg_Alb.id
}

# Create sgrule for websg to allow 8080 from alb sg
# Allow HTTP on Application load balancer sg
module "Allow_Cidr_Rule_HTTP_Alb" {
    source              = "../modules/Networking/Security_Group_Rule/allow_CIDR_rule"
    rule_type           = "ingress"
    security_group_id   = module.Sg_Alb.id
    from_port	          = 80
    to_port	            = 80
    protocol            = "tcp"
    allowed_cidr_blocks	= var.allowed_iprange
}

#Upload public key for VMs
resource "aws_key_pair" "publickey" {
  key_name   = var.public_ssh_key_name
  public_key = var.public_ssh_key
  tags       = { "project_name":var.project_name , "env": var.env}
}

#Create launch configuration
resource "aws_launch_configuration" "asg-launch-config-assesment" {
  image_id          = "ami-0f39d06d145e9bb63"
  instance_type     = "t2.micro"
  security_groups   = [module.Sg_App.id]
  associate_public_ip_address = true 
  key_name          = aws_key_pair.publickey.key_name
  user_data = <<-EOF
              #!/bin/bash -xe
              apt-get update -y
              apt-get install -y awscli docker.io jq    
              docker run -d -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=x -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST=x -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" servian/techchallengeapp:latest updatedb
              docker run --restart always  --name assessment-app --network assessment-network -p 8080:3000 -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=x -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST=x -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" -d servian/techchallengeapp:latest serve
              EOF
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg_assessment" {
  launch_configuration = aws_launch_configuration.asg-launch-config-assesment.id
  vpc_zone_identifier   = [module.Subnet_A.id, module.Subnet_B.id,]
  min_size = 2
  max_size = 2
  health_check_type = "ELB"
  tag {
    key                 = "Name"
    value               = "assessment-asg"
    propagate_at_launch = true
  }
}

