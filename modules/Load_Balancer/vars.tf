#############################
# lb variables

variable "lb_name" {
type = string
}

variable "lb_type" {
type = string
description = "application/network"
}

variable "if_lb_internal" {
type = bool
}

variable "lb_security_group_ids" {
type = list(string)
}

variable "lb_subnet_ids" {
type = list(string)
description = "list of subnet ids to create lb in. Valid for application LB only"
}

variable "tags_lb" {
    type = map(string)
	default = null
	description = "Resource tags"
}

#################################
# lb_listener variables



variable "lb_listener_port" {
type = string
default = "443"
}

variable "lb_listener_protocol" {
type = string
default = "HTTPS"
}

variable "lb_listener_ssl_policy" {
type = string
default = null
}

variable "lb_listener_certificate_arn" {
type = string
default = null
}

variable "lb_listener_action_type" {
type = string
default = "forward"
}



/*
variable "http_header_values" {
type = list(string)
description = "List of header value patterns to match."
}
*/
#########################
#Target group variables

variable  "target_group_name" {
type = string
}

variable "target_group_port" {
type = string
default = "80"
}

variable "target_group_protocol" {
type = string
default = "HTTP"
}

variable "target_type" {
type = string
description = "instance/ip/lambda"
}

variable "target_group_vpc_id" {
type = string
description = "VPC id in which target group will be created"
}

variable "tags_target_group" {
    type = map(string)
	default = null
	description = "Resource tags"
}


variable "target_group_healthcheck_path" {
type = string
default = "/"
description = "target_group_healthcheck_path"
}


variable "target_group_healthy_threshold" {
type = string
default = "5"
description = "target_group_healthy_threshold"
}

variable "target_group_unhealthy_threshold" {
type = string
default = "2"
description = "target_group_unhealthy_threshold"
}

#Target group association
variable "autoscaling_group_name" {
type = string
description = "autoscaling group name"
}