# Create VPC 
module "VPC" {
    source                  = "../modules/Networking/VPC"
    vpc_cidr_block          = var.vpc_cidr_block     #"10.5.0.0/16"
    enable_dns_hostnames    = "true"
    enable_dns_support      = "true"
    tags                    = { "Name":"${var.project_name}_vpc", "project_name":var.project_name , "env": var.env}
}

# Create Public Subnet public_subnetA
module "Public_Subnet_A" {
    source                      = "../modules/Networking/Subnet"
    vpc_id                      = module.VPC.id
    subnet_cidr_block           = var.public_subnet_cidr_block    #"10.5.1.0/24"
    subnet_availability_zone    = "ap-southeast-2a"
    tags                        = { "Name":"${var.project_name}_public_subnetA" , "project_name":var.project_name , "env": var.env}
}

# Create Private Subnet private_subnetA
module "Private_Subnet_A" {
    source                      = "../modules/Networking/Subnet"
    vpc_id                      = module.VPC.id
    subnet_cidr_block           = var.Private_subnet_cidr_block    #"10.5.2.0/24"
    subnet_availability_zone    = "ap-southeast-2a"
    tags                        = { "Name":"${var.project_name}_private_subnetA" , "project_name":var.project_name , "env": var.env}
}


#Create Route table for public subnet A
module "Route_Table_Public_SubnetA" {
    source              = "../modules/Networking/Route_Table"
    route_table_vpc_id  = module.VPC.id
    tags                = { "Name":"${var.project_name}_route_table_public_subnetA" , "project_name":var.project_name , "env": var.env}
}

#Route table association with public_subnetA
module "Route_Table_Assoc_Public_SubnetA" {
    source          = "../modules/Networking/Route_Table_Association"
    subnet_id       = module.Public_Subnet_A.id
    route_table_id  = module.Route_Table_Public_SubnetA.id
}


#Create Route table for private subnet A
module "Route_Table_Private_SubnetA" {
    source              = "../modules/Networking/Route_Table"
    route_table_vpc_id  = module.VPC.id
    tags                = { "Name":"${var.project_name}_route_table_private_subnetA" , "project_name":var.project_name , "env": var.env}
}

#Route table association with private_subnetA
module "Route_Table_Assoc_Private_SubnetA" {
    source          = "../modules/Networking/Route_Table_Association"
    subnet_id       = module.Private_Subnet_A.id
    route_table_id  = module.Route_Table_Private_SubnetA.id
}

#Create Internet Gateway
module "Internet_Gateway" {
    source                  = "../modules/Networking/Internet_Gateway"
    internet_gateway_vpc_id = module.VPC.id
    tags                    = { "Name":"${var.project_name}_igw" , "project_name":var.project_name , "env": var.env}
}

#Create route from public_subnetA to IGW
module "Route_public_subnetA_IGW" {
    source                  = "../modules/Networking/Route"
    route_table_id          = module.Route_Table_Public_SubnetA.id
    destination_cidr_block  = "0.0.0.0/0"
    internet_gateway_id     = module.Internet_Gateway.id
    nat_gateway_id          = null
}

