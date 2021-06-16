
variable security_group_id {
type = string
description = " sg id"
}

variable type {
type = string
description = " rule type ingress or egress"
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

variable cidr_blocks {
type = list(string)
description = " allowed_cidr_blocks"
}

variable description {
type = string
default = null
description = "security group rule description"
}
