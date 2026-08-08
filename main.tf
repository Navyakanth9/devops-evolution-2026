terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
# Configuring the backend to use s3 for state storage 
  backend "s3" {
    bucket = "terraform-state-navyakanth-2026"
    key = "global/s3/terraform.tfstate"
    region ="us-east-1"
    use_lockfile = true // Enable state locking to prevent concurrent modifications
    encrypt = true
  }

}

#Use the variables defined in variables.tf
provider "aws" {
  region = var.aws_region

}



