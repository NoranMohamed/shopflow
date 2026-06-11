variable "project_name"        {}
variable "vpc_id"              {}
variable "private_subnet_id"   {}
variable "private_subnet_b_id" {}
variable "app_sg_id"           {}
variable "db_password"         { sensitive = true }
