
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

variable allowed_security_grp_id {
type = string
description = "allowed_security_grp_id"
}
