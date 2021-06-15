region                          = "ap-southeast-2"

env                             = "test"                   #used for tags

project_name                    = "assessment"             #user for tags and prefix in names

allowed_iprange                 = [""]                      #cidr from where the vms will be accessed

public_ssh_key                  = ""                        #update the content of public key  here                    

public_ssh_key_name             = ""                        #give any name. to be used to upload key in aws

vpc_cidr_block                  = "10.5.0.0/16"

subnet_a_cidr_block             = "10.5.1.0/24"

subnet_b_cidr_block             = "10.5.2.0/24"             

db_password                     = ""                         #password for database user postgres

allowed_iprange_alb             = ["0.0.0.0/0"]                #cidr from where app will be accessed