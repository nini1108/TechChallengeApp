#Create security group for App VM #Allow RDP from a ip/range
module "SG_App_Server" {
    source                  = "../modules/Networking/Security_Group"
    security_group_name	    = "${var.project_name}_${var.env}_app_sg"
    vpc_id_sg	            = module.VPC.id
    tags                    = { "Name":"${var.project_name}_app_sg", "project_name":var.project_name , "env": var.env}
}


# Add rule to allow rdp from motorola vpn
module Allow_SSH_on_App_server {
    source                  = "../modules/Networking/Security_Group_Rule/allow_CIDR_rule"
    rule_type               = "ingress"
    security_group_id       = module.SG_App_Server.id
    from_port	            = 22
    to_port	                = 22
    protocol                = "tcp"
    allowed_cidr_blocks	    = var.allowed_iprange
}


module Allow_Http_on_App_server {
    source                  = "../modules/Networking/Security_Group_Rule/allow_CIDR_rule"
    rule_type               = "ingress"
    security_group_id       = module.SG_App_Server.id
    from_port	            = 3000
    to_port	                = 3000
    protocol                = "tcp"
    allowed_cidr_blocks	    = var.allowed_iprange
}



####################################################################
#Upload public key for VMs
####################################################################

resource "aws_key_pair" "publickey" {
  key_name   = var.public_ssh_key_name
  public_key = var.public_ssh_key
  tags       = { "project_name":var.project_name , "env": var.env}
}


#########################################################################
#Create Linux VM for ELK in Private Subnet
#########################################################################
data "template_file" "user_data" {
  template = "${file("${path.module}/install_ansible.tpl")}"
}


module "VM_Linux_App" {
    source                              = "../modules/Virtual_Machine"
    ec2_instance_ami                    = "ami-0f39d06d145e9bb63"   #ubuntu 18.04
    ec2_instance_type                   = "t2.micro"
    ec2_key_name                        = aws_key_pair.publickey.key_name
    ec2_subnet_id                       = module.Public_Subnet_A.id
    ec2_security_group_ids              = [ module.SG_App_Server.id ]
    ec2_public_ip_address_true_false    = "true"
    ec2_private_ip                      = "10.5.1.75"
    ec2_user_data                       = "${data.template_file.user_data.rendered}"
    volume_size                         = 8
    tags                                = { "Name":"${var.project_name}_app_server", "project_name":var.project_name , "env": var.env}
}

