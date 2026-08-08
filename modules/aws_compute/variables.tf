# modules/aws_compute/variables.tf

variable "instance_type" {
  type        = string
  description = "Size of the instance"
  default     = "t3.micro" # Set a default so you don't have to define it at the root unless you want to override it!
}

variable "dynamic_ami"{
  type       = string
  description = "Dynamic AMI ID for the EC2 instance"
}