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

# 2. DYNAMIC DATA SOURCE: Automatically fetch the official, latest free-tier Amazon Linux 2023 AMI
data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

# 3. Create the instance using the dynamic AMI and modern t3.micro (Free Tier)
resource "aws_instance" "dev_server" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro" # t3.micro is the standard modern free-tier type


  tags = {
    Name = "devops-evolution-2026"
  }
}