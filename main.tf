terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev_server" {

  ami = "ami-091b599f5f318ddd2"
  instance_type = "t2.micro"

  tags = {
    Name = "devops-evolution-2026"
  }
}