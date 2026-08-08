#DYNAMIC DATA SOURCE: Automatically fetch the official, latest free-tier Amazon Linux 2023 AMI
data "aws_ssm_parameter" "amazon_linux_2023" {
  name = var.dynamic_ami
}

variable "environment_tag" {
  description = "Environment tag for the EC2 instance"
  type        = string
  default     = "dev"
}

#Use variables defined in variables.tf
#Create the instance using the dynamic AMI and modern t3.micro (Free Tier)
resource "aws_instance" "module_server" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = var.instance_type



# Define tags for the instance using local variables and input variables
  tags = {
    environment = var.environment_tag
  }
}
