terraform {
  backend "s3" {
    bucket       = "shubham-devops-terraform-state-191239450128"
    key          = "devops-production-app/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
