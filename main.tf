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
    region  = "ap-south-2" #Always use hardcoded region for backend to avoid issues with provider region changes
    encrypt = true #Helps to encrypt the state file at rest in S3
    # We omit use_lockfile completely here to remove any version compilation friction
  }
}

provider "aws" {
  region = var.aws_region
}


module "enterprise_web_app" {
  source = "./modules/enterprise_web_app"

  
  project_tags = { Name = "Evolution-web-app" }
}