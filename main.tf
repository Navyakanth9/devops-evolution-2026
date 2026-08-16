terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

#   backend "s3" {
#     bucket       = "terraform-remote-state-nk"
#     key          = "global/s3/terraform.tfstate"
#     encrypt      = true
#     use_lockfile = true
#     region       = "ap-south-2"
#   }
# }


provider "aws" {
  region = var.aws_region
}

module "enterprise_web_app" {
  source = "./modules/enterprise_web_app"
  project_tags = {
    Name = "evolution-web-app"
  }
}