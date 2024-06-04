module "vpc" {
    #source = "../terraform-aws-vpc"
    source = "git::https://github.com/mahendharkanuganti/terraform-aws-vpc.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
}