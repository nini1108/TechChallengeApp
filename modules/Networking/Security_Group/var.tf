
variable name {
type = string
description = " sg name"
}

variable vpc_id {
type = string
description = " vpc in which it will be created "
}



variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
