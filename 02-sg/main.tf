### Creating DB security Group ###
module "db" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "db"
    sg_description = "SG for DB Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

### Creating backend security Group ###
module "backend" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    sg_description = "SG for Backend Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

### Creating app_alb security Group ###
module "app_alb" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for app_alb Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "app_alb"
}

### Creating frontend security Group ###
module "frontend" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for frontend Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "frontend"
}

### Creating web_alb security Group ###
module "web_alb" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for web_alb Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "web_alb"
}

### Creating bastion security Group ###
module "bastion" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for bastion Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "bastion"
}

### Creating vpn security Group ###
module "vpn" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "SG for vpn Instances"
    common_tags = var.common_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "vpn"
}

### ---- Creation of Security Groups completed till here ------ #####

## Below are the security groups Rules ####

# DB is accepting connections from backend
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend.sg_id # source is where you are getting traffic from
  security_group_id = module.db.sg_id
}

# DB is accepting connections from bastion
resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # source is where you are getting traffic from
  security_group_id = module.db.sg_id
}

# DB is accepting connections from vpn
resource "aws_security_group_rule" "db_vpn" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id # source is where you are getting traffic from
  security_group_id = module.db.sg_id
}

# backend is accepting connections from app_alb
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb.sg_id # source is where you are getting traffic from
  security_group_id = module.backend.sg_id
}

# backend is accepting connections from bastion
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # source is where you are getting traffic from
  security_group_id = module.backend.sg_id
}

# backend is accepting connections from vpn_ssh
resource "aws_security_group_rule" "backend_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id # source is where you are getting traffic from
  security_group_id = module.backend.sg_id
}

# backend is accepting connections from vpn_http
resource "aws_security_group_rule" "backend_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id # source is where you are getting traffic from
  security_group_id = module.backend.sg_id
}

# app_alb is accepting connections from vpn
resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id # source is where you are getting traffic from
  security_group_id = module.app_alb.sg_id
}

# app_alb is accepting connections from bastion
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # source is where you are getting traffic from
  security_group_id = module.app_alb.sg_id
}

# frontend is accepting connections from web_alb
resource "aws_security_group_rule" "frontend_web_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb.sg_id # source is where you are getting traffic from
  security_group_id = module.frontend.sg_id
}

# frontend is accepting connections from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # source is where you are getting traffic from
  security_group_id = module.frontend.sg_id
}

# frontend is accepting connections from vpn
resource "aws_security_group_rule" "frontend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id # source is where you are getting traffic from
  security_group_id = module.frontend.sg_id
}

# web_alb is accepting connections from public_http
resource "aws_security_group_rule" "web_alb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}

# web_alb is accepting connections from public_https
resource "aws_security_group_rule" "web_alb_public_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}

# bastion is accepting connections from public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}