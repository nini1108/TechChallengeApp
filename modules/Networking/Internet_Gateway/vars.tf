variable internet_gateway_vpc_id {
type = string
description = "Id of vpc in which internet_gateway will be created"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
