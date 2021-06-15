# Create VPC 
module "VPC" {
    source                  = "../modules/Networking/VPC"
    vpc_cidr_block          = var.vpc_cidr_block     #"10.5.0.0/16"
    enable_dns_hostnames    = "true"
    enable_dns_support      = "true"
    tags                    = { "Name":"${var.project_name}_vpc", "project_name":var.project_name , "env": var.env}
}

# Create subnet subnet_a
module "Subnet_A" {
    source                      = "../modules/Networking/Subnet"
    vpc_id                      = module.VPC.id
    subnet_cidr_block           = var.subnet_a_cidr_block    #"10.5.1.0/24"
    subnet_availability_zone    = "ap-southeast-2a"
    tags                        = { "Name":"${var.project_name}_subnet_a" , "project_name":var.project_name , "env": var.env}
}

# Create subnet subnet_b
module "Subnet_B" {
    source                      = "../modules/Networking/Subnet"
    vpc_id                      = module.VPC.id
    subnet_cidr_block           = var.subnet_b_cidr_block    #"10.5.2.0/24"
    subnet_availability_zone    = "ap-southeast-2b"
    tags                        = { "Name":"${var.project_name}_subnet_b" , "project_name":var.project_name , "env": var.env}
}


#Create Route table for subnet_a
module "Route_Table_Subnet_A" {
    source              = "../modules/Networking/Route_Table"
    route_table_vpc_id  = module.VPC.id
    tags                = { "Name":"${var.project_name}_route_table_subnet_a" , "project_name":var.project_name , "env": var.env}
}

#Route table association with subnet_a
module "Route_Table_Assoc_Subnet_A" {
    source          = "../modules/Networking/Route_Table_Association"
    subnet_id       = module.Subnet_A.id
    route_table_id  = module.Route_Table_Subnet_A.id
}


#Create Route table for subnet_b
module "Route_Table_Subnet_B" {
    source              = "../modules/Networking/Route_Table"
    route_table_vpc_id  = module.VPC.id
    tags                = { "Name":"${var.project_name}_route_table_subnet_b" , "project_name":var.project_name , "env": var.env}
}

#Route table association with subnet_b
module "Route_Table_Assoc_Subnet_B" {
    source          = "../modules/Networking/Route_Table_Association"
    subnet_id       = module.Subnet_B.id
    route_table_id  = module.Route_Table_Subnet_B.id
}

#Create Internet Gateway
module "Internet_Gateway" {
    source                  = "../modules/Networking/Internet_Gateway"
    internet_gateway_vpc_id = module.VPC.id
    tags                    = { "Name":"${var.project_name}_igw" , "project_name":var.project_name , "env": var.env}
}

#Create route from subnet_a to internet gateway
module "Route_Public_Subnet_A_IGW" {
    source                  = "../modules/Networking/Route"
    route_table_id          = module.Route_Table_Subnet_A.id
    destination_cidr_block  = "0.0.0.0/0"
    internet_gateway_id     = module.Internet_Gateway.id
    nat_gateway_id          = null
}

#Create route from subnet_b to internet gateway
module "Route_Public_Subnet_B_IGW" {
    source                  = "../modules/Networking/Route"
    route_table_id          = module.Route_Table_Subnet_B.id
    destination_cidr_block  = "0.0.0.0/0"
    internet_gateway_id     = module.Internet_Gateway.id
    nat_gateway_id          = null
}
