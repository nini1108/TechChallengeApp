
variable security_group_id {
type = string
description = " sg id"
}

variable rule_type {
type = string
description = " sg id"
}

variable from_port {
type = string
description = " from port "
}

variable to_port {
type = string
description = " to port"
}

variable protocol {
type = string
default = "tcp"
description = " tcp etc"
}

variable allowed_cidr_blocks {
type = list(string)
description = " allowed_cidr_blocks"
}

variable sg_rule_description {
type = string
default = null
description = "security group rule description"
}
