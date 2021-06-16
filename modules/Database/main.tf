resource "aws_db_instance" "db_instance" {
  #Basic
  engine         = var.engine
  engine_version = var.engine_version
  license_model  = var.license_model
  identifier     = var.instance_name
  instance_class = var.instance_class
  username       = var.admin_username
  password       = var.admin_password
  #port = var.port
  storage_type          = var.storage_type
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  #Network and security
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = var.publicly_accessible
  availability_zone      = var.availability_zone
  multi_az               = var.multi_az
  storage_encrypted      = var.storage_encrypted
  #kms_key_id = var.kms_key_id

  #Maintenance
  #timezone = var.timezone
  #auto_minor_upgrade = var.auto_minor_upgrade
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  skip_final_snapshot     = var.skip_final_snapshot

  tags = var.tags
}
