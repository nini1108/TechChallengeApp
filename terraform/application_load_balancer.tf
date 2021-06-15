
# Create sg for applicatio load balancer
module "Sg_Alb" {
    source                  = "../modules/Networking/Security_Group"
    security_group_name	    = "${var.project_name}_alb_sg"
    vpc_id_sg	              = module.VPC.id
    tags                    = { "Name":"${var.project_name}_alb_sg", "project_name":var.project_name , "env": var.env}
}

# Allow HTTP on Application load balancer sg
module "Allow_Cidr_Rule_HTTP_Alb" {
    source              = "../modules/Networking/Security_Group_Rule/allow_CIDR_rule"
    rule_type           = "ingress"
    security_group_id   = module.Sg_Alb.id
    from_port	          = 80
    to_port	            = 80
    protocol            = "tcp"
    allowed_cidr_blocks	= var.allowed_iprange_alb
}

# Create Target group
# Create target group association
# Create ALB
# Create ALB listener
module "Application_Load_Balancer" {
    source                          = "../modules/Load_Balancer"
    
    #load balancer
    lb_name                         = "${var.project_name}-ALB"
    if_lb_internal                  = "false"
    lb_type                         = "application"
    lb_security_group_ids           = [ module.Sg_Alb.id ]
    lb_subnet_ids                   = [ module.Subnet_A.id, module.Subnet_B.id ]       #minimum 2 subnet ids
    tags_lb                         = { "project_name":var.project_name , "env": var.env }

    #alb listener
    lb_listener_port                = "80"
    lb_listener_protocol            = "HTTP"
    lb_listener_action_type         = "forward"
    
    #target group
    target_group_name               = "${var.project_name}-target-group"
    target_group_port               = "8080"
    target_group_protocol           = "HTTP"
    target_type                     = "instance"
    target_group_vpc_id             = module.VPC.id
    tags_target_group               = { "project_name":var.project_name , "env": var.env }    
    target_group_healthcheck_path   = "/healthcheck/"                                     
    target_group_healthy_threshold  = "2"
    target_group_unhealthy_threshold= "2"
    
    #target group association with asg
    autoscaling_group_name          = aws_autoscaling_group.asg_assessment.name
}


#Get ALB url
output "lb_url" {
  description = "URL of load balancer"
  value       = "http://${module.Application_Load_Balancer.lb_dns_name}/"
}
