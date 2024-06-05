variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "sg_name" {
    default = "db"
}

variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
  
}

variable "db_sg_description" {
  default = "SG for DB MySQL Instances"
}

