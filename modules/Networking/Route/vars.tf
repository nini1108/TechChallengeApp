variable route_table_id {
type = string
description = " Route table in which route will be created"
}

variable destination_cidr_block {
type = string
description = "destination ip block"
}

variable gateway_id {
type = string
description = "internet_gateway_id if target is internet gateway otherwise null"
}

variable nat_gateway_id {
type = string
description = " NAT gateway_id if target is NAT gateway otherwise null"
}
