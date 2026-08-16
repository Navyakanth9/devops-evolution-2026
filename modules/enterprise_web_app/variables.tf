variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-2"
}
# --------------------------------------------------------------------------
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}
# --------------------------------------------------------------------------

variable "data_ssm_value" {
  description = "The name of the SSM parameter to retrieve"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t3.micro"
}
# --------------------------------------------------------------------------
variable "key_pair_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
  default     = "aws-pem"
}

variable "public_key_path" {
  description = "The path to the public key file for the key pair"
  type        = string

  # defining the path to the public key file for the key pair. This is used to create the key pair in AWS.
  # default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgq1cjS4sqiX/x43v4HBR/sXaXdznlh4/0ccX0+SdxED/hTZFiL4N94veJ8fM4CNDZXLitpRRCNZK4f6k7OIFqMNpxSR2CG4I55tKUQsfPcOUvptEfojKE1B4NTiUnyIMgMhxgIABKSz3GpeeJ1SIa17k/6Dvgit6Le6vW2yymsiSYIDiHShVmWU9GRM2Lf70isQKSt802jKqOdDIqgK2cEIZo1bZPSS8BeaQ5ap/fZ6XPN6Fhmsj943yZ9DGQBteuv6KRdjcv5ixlEKrahVkQMpVhJ84xnR9CIiPoWRhxgqe5uvorazWDRuTlU1Uv2PID3nl/QGcbLX9/zv8lu/qb"
  default = "C:/Users/amshu_e35w1je/OneDrive/Desktop/Nav/Devops-Evolution-2026/AWS/aws-pubkey.pub"
}


variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
}

variable "script_path" {
  description = "The path to the user data script"
  type        = string
  default     = "./modules/enterprise_web_app/exp.sh"
}

variable "project_tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    Name = "evolution"
  }
}


