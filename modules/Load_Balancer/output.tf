output "lb_id" {
value = aws_lb.lb.id
description = "id of lb. same as arn"
}

output "lb_arn" {
value = aws_lb.lb.arn
description = "arn of lb. same as id"
}

output "target_group_id" {
value = aws_lb_target_group.lb_target_group.id
description = "id of target group. same as arn"
}

output "target_group_arn" {
value = aws_lb_target_group.lb_target_group.arn
description = "id of target group. same as arn"
}


output "dns_name" {
value = aws_lb.lb.dns_name
description = "dns name of load balancer"
}
