terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

 # THE BULLETPROOF ENTERPRISE BACKEND
  backend "s3" {
    bucket  = "terraform-remote-state-nk"
    key     = "global/s3/terraform.tfstate"
    region  = "ap-south-2"
    encrypt = true
    # We omit use_lockfile completely here to remove any version compilation friction
  }
}

provider "aws" {
  region = var.aws_region
}


# provider "aws" {
#   region = var.aws_region
# }

module "enterprise_web_app" {
  source = "./modules/enterprise_web_app"
  project_tags = {
    Name = "evolution-web-app"
  }
}