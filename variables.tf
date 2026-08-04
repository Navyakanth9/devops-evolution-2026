variable "aws_region" {
  type        = string
  description = "The target AWS region for deployment"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "The size of the EC2 instance"
  default     = "t3.micro"
}

variable "environment_tag" {
  type        = string
  description = "Value for the Environment tag"
  default     = "Development"
}

variable "dynamic_ami"{
  type       = string
  description = "Dynamic AMI ID for the EC2 instance"
  default     = ""
}

locals{
  project_name = "Evolution"
  full_server_name = "${local.project_name}-server-${var.environment_tag}"

}
