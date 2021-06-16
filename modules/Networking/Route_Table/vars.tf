variable vpc_id {
type = string
description = "VPC id in which route tables will be created"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
