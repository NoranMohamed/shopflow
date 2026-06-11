module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "ec2" {
  source                    = "./modules/ec2"
  project_name              = var.project_name
  vpc_id                    = module.vpc.vpc_id
  public_subnet_id          = module.vpc.public_subnet_id
  public_subnet_b_id        = module.vpc.public_subnet_b_id
  private_subnet_id         = module.vpc.private_subnet_id
  aws_region                = var.aws_region
  ami_id                    = "ami-0720a3ca2735bf2fa"
  ecr_image_uri             = var.ecr_image_uri
  ec2_instance_profile_name = module.iam.ec2_instance_profile_name
  ec2_public_key            = var.ec2_public_key
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_id   = module.vpc.private_subnet_id
  private_subnet_b_id = module.vpc.private_subnet_b_id
  app_sg_id           = module.ec2.app_sg_id
  db_password         = var.db_password
}

module "monitoring" {
  source       = "./modules/monitoring"
  project_name = var.project_name
  alert_email  = "noranmohamed948@gmail.com"
  aws_region   = var.aws_region
}

output "app_url" {
  value = "http://${module.ec2.alb_dns_name}"
}

output "bastion_ip" {
  value = module.ec2.bastion_public_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
