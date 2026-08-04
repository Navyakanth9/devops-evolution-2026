terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#Use the variables defined in variables.tf
provider "aws" {
  region = var.aws_region
}



#DYNAMIC DATA SOURCE: Automatically fetch the official, latest free-tier Amazon Linux 2023 AMI
data "aws_ssm_parameter" "amazon_linux_2023" {
  name = var.dynamic_ami
}


#Use variables defined in variables.tf
#Create the instance using the dynamic AMI and modern t3.micro (Free Tier)
resource "aws_instance" "dev_server" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = var.instance_type



# Define tags for the instance using local variables and input variables
  tags = {
    Name = local.full_server_name
    environment = var.environment_tag
  }
}