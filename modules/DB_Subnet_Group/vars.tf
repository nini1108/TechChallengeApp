variable name {
type = string
description = "name of db subnet group"
}

variable subnet_ids {
type = list(string)
description = "Subnet ids that are supposed to be added to the subnet group"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
