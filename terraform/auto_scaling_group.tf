


# Create sg for app servers
module "Sg_App" {
    source                  = "../modules/Networking/Security_Group"
    security_group_name	    = "${var.project_name}_app_sg"
    vpc_id_sg	            = module.VPC.id
    tags                    = { "Name":"${var.project_name}_app_sg", "project_name":var.project_name , "env": var.env}
}

#Add  Security group rule to connect from Appserver to Database
module "Allow_SG_rule_Bastion_to_DB" {
    source                  = "../modules/Networking/Security_Group_Rule/allow_SG_rule"
    rule_type               = "ingress"
    security_group_id       = module.DB_Security_Group.id
    from_port	              = 5432
    to_port	                = 5432
    protocol                = "tcp"
    allowed_security_grp_id	 = module.Sg_App.id
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


#Upload public key for VMs
resource "aws_key_pair" "publickey" {
  key_name   = var.public_ssh_key_name
  public_key = var.public_ssh_key
  tags       = { "project_name":var.project_name , "env": var.env}
}

# cerate template file
# data "template_file" "user_data_assessment" {
#   template = <<-EOF
#               #!/bin/bash -xe
#               apt-get update -y
#               apt-get install -y awscli docker.io jq    
#               docker run -d -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=${var.db_password} -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST="${module.Postgres_Rds.address}" -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" servian/techchallengeapp:latest updatedb -s
#               docker run --restart always  --name assessment-app -p 8080:3000 -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=${var.db_password} -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST="${module.Postgres_Rds.address}" -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" -d servian/techchallengeapp:latest serve
#             EOF
#   vars = {
#     db_password = "${var.db_password}"
#     db_address  = "${module.Postgres_Rds.address}"
#   }
# }

#Create launch configuration
resource "aws_launch_configuration" "asg_launch_config_assesment" {
  name              = "${var.project_name}_lc"
  image_id          = "ami-0f39d06d145e9bb63"
  instance_type     = "t2.micro"
  security_groups   = [module.Sg_App.id]
  associate_public_ip_address = true 
  key_name          = aws_key_pair.publickey.key_name
  #user_data         = "${base64encode(data.template_file.user_data_assessment.rendered)}"
  user_data = <<-EOF
  #!/bin/bash -xe
  apt-get update -y
  apt-get install -y awscli docker.io jq    
  docker run -d -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=pass -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST="${module.Postgres_Rds.address}" -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" servian/techchallengeapp:latest updatedb -s
  docker run --restart always  --name assessment-app  -p 8080:3000 -e VTT_DBUSER=postgres -e VTT_DBPASSWORD=${var.db_password} -e VTT_DBNAME=postgres -e VTT_DBPORT=5432 -e VTT_DBHOST="${module.Postgres_Rds.address}" -e VTT_LISTENHOST=0.0.0.0 -e VTT_ListenPort="3000" -d servian/techchallengeapp:latest serve
  EOF
  lifecycle {
    create_before_destroy = true
  }
}


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
