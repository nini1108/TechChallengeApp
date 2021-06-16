variable vpc_id {
type = string
description = " id of VPC in which subnet will be created "
}

variable cidr_block {
type = string
description = "CIDR block to eb assigned to the subnet "
}

variable availability_zone {
type = string
description = "AZ in which subnet will be created"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
