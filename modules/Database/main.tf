resource "aws_db_instance" "db_instance" {
  #Basic
  engine = var.db_engine
  engine_version = var.db_engine_version
  license_model = var.db_license_model
  identifier = var.db_instance_name
  instance_class = var.db_ec2_instance_class
  username = var.db_admin_username
  password = var.db_admin_password
  #port = var.db_port
  storage_type = var.db_storage_type
  allocated_storage = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage

  #Network and security
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = var.db_security_group_ids
  publicly_accessible = var.db_publicly_accessible
  availability_zone = var.db_availability_zone
  multi_az = var.db_multi_az
  storage_encrypted = var.db_storage_encrypted
  #kms_key_id = var.kms_key_id

  #Maintenance
  #timezone = var.db_timezone
  #auto_minor_upgrade = var.db_auto_minor_upgrade
  backup_retention_period = var.db_backup_retention_period
  backup_window = var.db_backup_window
  maintenance_window = var.db_maintenance_window
  skip_final_snapshot = var.db_skip_final_snapshot

  tags = var.tags
}