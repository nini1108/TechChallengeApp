

resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = var.if_lb_internal
  load_balancer_type = var.lb_type
  security_groups    = var.lb_security_group_ids
  subnets            = var.lb_subnet_ids

  #enable_deletion_protection = true
  tags = var.tags_lb

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  ssl_policy        = var.lb_listener_ssl_policy
  certificate_arn   = var.lb_listener_certificate_arn
  
  default_action {
    type             = var.lb_listener_action_type
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    }
  
}

# resource "aws_lb_listener" "lb_listener_http_to_https" {
#   load_balancer_arn = aws_lb.lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }



resource "aws_lb_target_group" "lb_target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_type
  vpc_id      = var.target_group_vpc_id
  tags = var.tags_target_group

  health_check {
    path = var.target_group_healthcheck_path
    healthy_threshold = var.target_group_healthy_threshold
    unhealthy_threshold = var.target_group_unhealthy_threshold
    }
}


# resource "aws_lb_target_group_attachment" "target_group_attach" {
#   target_group_arn = aws_lb_target_group.lb_target_group.arn
#   target_id        = var.target_group_attach_instance_id
#   port             = 80
# }

resource "aws_autoscaling_attachment" "autoscaling_attachment" {
  autoscaling_group_name = var.autoscaling_group_name
  alb_target_group_arn   = aws_lb_target_group.lb_target_group.arn
}