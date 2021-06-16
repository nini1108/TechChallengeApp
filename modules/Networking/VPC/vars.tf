variable cidr_block {
type = string
}


variable "enable_dns_hostnames" {
    type = bool
	default = "false"
	description = "A boolean flag to enable/disable DNS hostnames in the VPC"
}

variable "enable_dns_support" {
    type = bool
	default = "true"
	description = "A boolean flag to enable/disable DNS support in the VPC"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}
