#common variales 

variable region {
    type        = string
    description = "region"
}

variable project_name {
    type        = string
    description = "project for which resource created"
}

variable env {
    type        = string
    description = "Environment"
}


variable allowed_iprange {
    type        = list(string)
    description = "allowed ip ranges from where to ssh or call service"
}


variable vpc_cidr_block {
    type        = string
    description = "VPC cidr"
}

variable public_subnet_cidr_block {
    type        = string
    description = "public subnet cidr"
}

variable Private_subnet_cidr_block {
    type        = string
    description = "private subnet cidr"
}



variable public_ssh_key {
    type        = string
    description = "public ssh key for vm to be uploaded in aws key pair"
}


variable public_ssh_key_name {
    type        = string
    description = "public ssh key name for vm"
}


