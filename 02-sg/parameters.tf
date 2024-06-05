### Storing the DB Security group ID in aws ssm parameter store named as /expense/dev/db_sg_id
### this contains the value of SG_ID's

resource "aws_ssm_parameter" "db_sg_id" {
    name = "/${var.project_name}/${var.environment}/db_sg_id"   #/expense/dev/db_sg_id
    type = "String"
    value = module.db.sg_id
}

### Storing the backend Security group ID in aws ssm parameter store.
resource "aws_ssm_parameter" "backend_sg_id" {
    name = "/${var.project_name}/${var.environment}/backend_sg_id"
    type = "String"
    value = module.backend.sg_id
}

### Storing the frontend Security group ID in aws ssm parameter store
resource "aws_ssm_parameter" "frontend_sg_id" {
    name = "/${var.project_name}/${var.environment}/frontend_sg_id"
    type = "String"
    value = module.frontend.sg_id
}

### Storing the bastion Security group ID in aws ssm parameter store
resource "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project_name}/${var.environment}/bastion_sg_id"
    type = "String"
    value = module.bastion.sg_id
}

### Storing the vpn Security group ID in aws ssm parameter store
resource "aws_ssm_parameter" "vpn_sg_id" {
    name = "/${var.project_name}/${var.environment}/vpn_sg_id"
    type = "String"
    value = module.vpn.sg_id
}

### Storing the app_alb Security group ID in aws ssm parameter store
resource "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
    type = "String"
    value = module.app_alb.sg_id
}

### Storing the app_alb Security group ID in aws ssm parameter store
resource "aws_ssm_parameter" "web_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
    type = "String"
    value = module.web_alb.sg_id
}