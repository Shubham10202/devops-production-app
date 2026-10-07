terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source = "./modules/ec2"

  ami_id                     = var.ami_id
  instance_type              = var.instance_type
  ec2_name                   = var.ec2_name
  vpc_id                     = data.aws_vpc.existing.id
  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  web_port                   = var.web_port
  ssh_port                   = var.ssh_port
  ssh_cidr                   = var.ssh_cidr
}
