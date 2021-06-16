#Create security Group for SQL server
module "DB_Security_Group" {
  source              = "../modules/Networking/Security_Group"
  name                = "${var.project_name}_db_sg"
  vpc_id              = module.VPC.id
  tags                = { "project_name" : var.project_name, "env" : var.env }
}


#Create db subnet group
module "DB_Subnet_Group" {
  source               = "../modules/DB_Subnet_Group"
  name                 = "${var.project_name}_db_subnet_group"
  subnet_ids        = [module.Subnet_A.id, module.Subnet_B.id]
  tags                 = { "project_name" : var.project_name, "env" : var.env }
}


#Create SQL db module
module "Postgres_Rds" {
  source                     = "../modules/Database"
  engine                  = "postgres"
  engine_version          = "12.5"
  instance_class      = "db.t3.micro"
  instance_name           = "${var.project_name}db"
  admin_username          = "postgres"
  admin_password          = var.db_password
  storage_type            = "gp2"
  allocated_storage       = 20
  max_allocated_storage   = 21
  subnet_group_name       = module.DB_Subnet_Group.name
  security_group_ids      = [module.DB_Security_Group.id]
  publicly_accessible     = "false"
  multi_az                = true
  storage_encrypted       = "true"
  backup_retention_period = 7
  backup_window           = "21:30-22:30"
  maintenance_window      = "Sat:02:00-Sat:05:00"
  skip_final_snapshot     = "true"
  tags                       = { "project_name" : var.project_name, "env" : var.env }
}
