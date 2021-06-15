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


#network
variable vpc_cidr_block {
    type        = string
    description = "VPC cidr"
}

variable subnet_a_cidr_block {
    type        = string
    description = "subnet a cidr"
}

variable subnet_b_cidr_block {
    type        = string
    description = "subnet b cidr"
}

#ASG/vm
variable public_ssh_key {
    type        = string
    description = "public ssh key for vm to be uploaded in aws key pair"
}

variable public_ssh_key_name {
    type        = string
    description = "public ssh key name for vm"
}


#database
variable db_password {
    type        = string
    description = "database password"
}


#applicatio load balancer
variable allowed_iprange_alb {
    type        = list(string)
    description = "ip range from where the app will be accesed"
}

