variable instance_ami {
type = string
}

variable instance_type {
type = string
}

variable key_name {
type = string
}

variable subnet_id {
type = string
}

variable security_group_ids {
type = list(string)
}

# variable user_data_filename {
# type = string
# }

variable user_data {
type = string
}

variable public_ip_address_true_false {
type = bool
}

variable private_ip {
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
