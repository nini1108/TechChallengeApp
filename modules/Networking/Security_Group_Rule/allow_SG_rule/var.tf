
variable security_group_id {
type = string
description = " sg id"
}

variable type {
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

variable source_security_group_id {
type = string
description = "allowed security grp id"
}
