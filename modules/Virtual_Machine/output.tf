output id {
value = aws_instance.ec2_instance_create.id
description = "instance id"
}

output private_ip {
value = aws_instance.ec2_instance_create.private_ip
description = "instance private ip"
}