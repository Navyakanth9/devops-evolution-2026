variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1" # Set a default so you don't have to define it at the root unless you want to override it!  

  
}