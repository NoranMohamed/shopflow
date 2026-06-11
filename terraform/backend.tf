terraform {
  backend "s3" {
    bucket       = "shopflow-terraform-noran"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}
