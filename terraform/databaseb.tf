#Create security Group for SQL server
module "DB_Security_Group" {
  source              = "../modules/Networking/Security_Group"
  security_group_name = "${var.project_name}_db_sg"
  vpc_id_sg           = module.VPC.id
  tags                = { "project_name" : var.project_name, "env" : var.env }
}


#Create db subnet group
module "DB_Subnet_Group" {
  source               = "../modules/DB_Subnet_Group"
  db_subnet_group_name = "${var.project_name}_db_subnet_group"
  db_subnet_ids        = [module.Subnet_A.id, module.Subnet_B.id]
  tags                 = { "project_name" : var.project_name, "env" : var.env }
}


#Create SQL db module
module "Postgres_Rds" {
  source                     = "../modules/Database"
  db_engine                  = "postgres"
  db_engine_version          = "12.5"
  db_ec2_instance_class      = "db.t3.micro"
  db_instance_name           = "${var.project_name}db"
  db_admin_username          = "postgres"
  db_admin_password          = var.db_password
  db_storage_type            = "gp2"
  db_allocated_storage       = 20
  db_max_allocated_storage   = 21
  db_subnet_group_name       = module.DB_Subnet_Group.name
  db_security_group_ids      = [module.DB_Security_Group.id]
  db_publicly_accessible     = "false"
  db_multi_az                = true
  db_storage_encrypted       = "true"
  db_backup_retention_period = 7
  db_backup_window           = "21:30-22:30"
  db_maintenance_window      = "Sat:02:00-Sat:05:00"
  db_skip_final_snapshot     = "true"
  tags                       = { "project_name" : var.project_name, "env" : var.env }
}
