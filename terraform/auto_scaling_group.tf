
#Create security group for app servers
module "Sg_App" {
    source                  = "../modules/Networking/Security_Group"
    name	                  = "${var.project_name}_app_sg"
    vpc_id	                = module.VPC.id
    tags                    = { "Name":"${var.project_name}_app_sg", "project_name":var.project_name , "env": var.env}
}

#Create security group rule to connect from appserver to database
module "Allow_SG_rule_Bastion_to_DB" {
    source                  = "../modules/Networking/Security_Group_Rule/allow_SG_rule"
    type               = "ingress"
    security_group_id       = module.DB_Security_Group.id
    from_port	              = 5432
    to_port	                = 5432
    protocol                = "tcp"
    source_security_group_id	 = module.Sg_App.id
}

#Create security group rule to allow ssh to app server
module "Allow_Cidr_Rule_Ssh_App_server" {
    source                  = "../modules/Networking/Security_Group_Rule/allow_CIDR_rule"
    type               = "ingress"
    security_group_id       = module.Sg_App.id
    from_port	              = 22
    to_port	                = 22
    protocol                = "tcp"
    cidr_blocks	    = var.allowed_iprange
}


#Create security group rule for websg to allow 8080 from alb security group
module "Allow_Sg_Rule_ALB_to_App" {
    source                  = "../modules/Networking/Security_Group_Rule/allow_SG_rule"
    type               = "ingress"
    security_group_id       = module.Sg_App.id
    from_port	              = 8080
    to_port	                = 8080
    protocol                = "tcp"
    source_security_group_id	= module.Sg_Alb.id
}


#Upload public key for VMs
resource "aws_key_pair" "publickey" {
  key_name   = var.public_ssh_key_name
  public_key = var.public_ssh_key
  tags       = { "project_name":var.project_name , "env": var.env}
}


#Create launch configuration
resource "aws_launch_configuration" "asg_launch_config_assesment" {
  name              = "${var.project_name}_lc"
  image_id          = "ami-0f39d06d145e9bb63"
  instance_type     = "t2.micro"
  security_groups   = [module.Sg_App.id]
  associate_public_ip_address = true 
  key_name          = aws_key_pair.publickey.key_name
  user_data = <<-EOF
  #!/bin/bash -xe
  apt-get update -y
  apt-get install -y awscli docker.io jq    
  docker run -d -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=${var.db_password} -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST="${module.Postgres_Rds.address}" -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" servian/techchallengeapp:latest updatedb -s
  docker run --restart always  --name assessment-app  -p 8080:3000 -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=${var.db_password} -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST="${module.Postgres_Rds.address}" -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" -d servian/techchallengeapp:latest serve
  EOF
  lifecycle {
    create_before_destroy = true
  }
}

# Create auto scaling group
resource "aws_autoscaling_group" "asg_assessment" {
  name                  = "${var.project_name}_asg"
  launch_configuration  = aws_launch_configuration.asg_launch_config_assesment.id
  vpc_zone_identifier   = [module.Subnet_A.id, module.Subnet_B.id,]
  target_group_arns = [module.Application_Load_Balancer.target_group_arn]
  min_size              = 2
  max_size = 2
  health_check_type = "ELB"
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "${var.project_name}_asg"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "project_name"
        "value"               = var.project_name
        "propagate_at_launch" = true
      }
    ]
  )
}
