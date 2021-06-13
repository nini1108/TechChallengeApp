variable ec2_instance_ami {
type = string
}

variable ec2_instance_type {
type = string
}

variable ec2_key_name {
type = string
}

variable ec2_subnet_id {
type = string
}

variable ec2_security_group_ids {
type = list(string)
}

# variable ec2_user_data_filename {
# type = string
# }

variable ec2_user_data {
type = string
}

variable ec2_public_ip_address_true_false {
type = bool
}

variable ec2_private_ip {
type = string
default = null
}


variable volume_size {
type = string
default = 30
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
