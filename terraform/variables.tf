variable "aws_region" {
  default = "eu-west-1"
}

variable "project_name" {
  default = "shopflow"
}

variable "db_password" {
  sensitive = true
}

variable "ecr_image_uri" {}
