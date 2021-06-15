variable  db_engine{
	type = string
	description = "The database engine for eg. Sql server, MySQL, Oracle etc"
}

variable  db_engine_version{
	type = string
	description = "Version of the database"
}

variable  db_license_model{
	type = string
	default = null
	description = "License model. Check from AWS "
}

variable  db_instance_name{
	type = string
	description = "Name of the database instance"
}

variable db_ec2_instance_class {
	type = string
	description = "Instance class eg. t2.micro"
}

variable  db_admin_username {
	type = string
	description = " Database admin user"
}

variable db_admin_password {
	type = string
	description = " Database password "
}

variable db_storage_type {
	type = string
	default = "gp2"
	description = " gp2 etc"
}

variable db_allocated_storage {
	type = number
	default = "20"
	description = "Initially allocated storage"
}

variable db_max_allocated_storage {
	type = number
	default = "50"
	description = "Max storage that database can expand to."
}

variable db_subnet_group_name {
	type = string
	description = "Subnet group to which the db will be associated"
}

variable db_security_group_ids {
	type = list(string)
	description = " Security groups to be attached to db"
}

variable db_publicly_accessible {
	type = bool
	default = "false"
	description = " is db publicly accessible true/false "
}

variable db_multi_az {
	type = bool
	default = false
	description = " true/false"
}

variable db_availability_zone {
	type = string
	default = null
	description = " "
}

variable db_storage_encrypted {
	type = bool
	default = "true"
	description = " true/false "
}

/*
variable db_timezone  {
type = string
description = " format: "
}
*/

variable db_backup_retention_period {
	type = number
	default = 7
	description = " in days "
}

variable db_backup_window  {
	type = string
	default = "21:30-22:30"
	description = " Example: 09:46-10:16. Must not overlap with maintenance_window."
}

variable db_maintenance_window  {
	type = string
	default = "Sat:02:00-Sat:05:00"
	description = " ddd:hh24:mi-ddd:hh24:mi eg. Mon:00:00-Mon:03:00 "
}

variable db_skip_final_snapshot {
	type = bool
	default = "true"
	description = " do you want to skip final snapshot when you delete database"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}