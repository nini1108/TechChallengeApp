variable  engine{
	type = string
	description = "The database engine for eg. Sql server, MySQL, Oracle etc"
}

variable  engine_version{
	type = string
	description = "Version of the database"
}

variable  license_model{
	type = string
	default = null
	description = "License model. Check from AWS "
}

variable  instance_name{
	type = string
	description = "Name of the database instance"
}

variable instance_class {
	type = string
	description = "Instance class eg. t2.micro"
}

variable  admin_username {
	type = string
	description = " Database admin user"
}

variable admin_password {
	type = string
	description = " Database password "
}

variable storage_type {
	type = string
	default = "gp2"
	description = " gp2 etc"
}

variable allocated_storage {
	type = number
	default = "20"
	description = "Initially allocated storage"
}

variable max_allocated_storage {
	type = number
	default = "50"
	description = "Max storage that database can expand to."
}

variable subnet_group_name {
	type = string
	description = "Subnet group to which the db will be associated"
}

variable security_group_ids {
	type = list(string)
	description = " Security groups to be attached to db"
}

variable publicly_accessible {
	type = bool
	default = "false"
	description = " is db publicly accessible true/false "
}

variable multi_az {
	type = bool
	default = false
	description = " true/false"
}

variable availability_zone {
	type = string
	default = null
	description = " "
}

variable storage_encrypted {
	type = bool
	default = "true"
	description = " true/false "
}

/*
variable timezone  {
type = string
description = " format: "
}
*/

variable backup_retention_period {
	type = number
	default = 7
	description = " in days "
}

variable backup_window  {
	type = string
	default = "21:30-22:30"
	description = " Example: 09:46-10:16. Must not overlap with maintenance_window."
}

variable maintenance_window  {
	type = string
	default = "Sat:02:00-Sat:05:00"
	description = " ddd:hh24:mi-ddd:hh24:mi eg. Mon:00:00-Mon:03:00 "
}

variable skip_final_snapshot {
	type = bool
	default = "true"
	description = " do you want to skip final snapshot when you delete database"
}

variable "tags" {
    type = map(string)
	default = null
	description = "Resource tags"
}