variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags"  {
    type = map
    default = {
        Terraform = "true"
        Project = "Expense"
        Environment = "dev"
    }
}

variable "zone_name" {
    default = "mahidevops.cloud"
}