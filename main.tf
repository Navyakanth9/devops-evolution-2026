# Goal to create a apache server which will be used to host a website. The server will be created in AWS using Terraform.

# 1.provider block: This block is used to specify the provider (AWS in this case) and its version. 
#  It ensures that Terraform uses the correct provider to interact with AWS services.
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

backend s3 {
    bucket = "terraform-remote-state-nk"
    key    = "global/s3/terraform.tfstate"
    encrypt = true
    use_lockfile = true
    region = "ap-south-2"
  }
} 

provider "aws" {
  region = "ap-south-2"
}

# resource block: This block defines the AWS resources to be created. In this case, it creates an EC2 instance with the specified AMI, instance type, and tags.

# 1. THE BOUNDARY: Create the VPC

resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames   = true

  tags = { Name = "evolution-vpc" }
}

#  The Room: Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = { Name = "evolution-public-subnet" }
}

# 3. The front door: Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = { Name = "evolution-igw" }
}
# 4. The path: Create Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }
  tags = { Name = "evolution-public-route-table" }
}


# Link the direction rules directly to our room (Subnet)
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# 5. THE FIREWALL: Create Security Group for Ports 22 and 80
resource "aws_security_group" "web_sg" {
  name        = "evolution-web-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from any IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from any IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
  tags = { Name = "evolution-web-sg" }
}

# 6. THE AUTHENTICATION: Import your existing local Laptop PEM Key
resource "aws_key_pair" "my_key" {
  key_name   = "aws-pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgq1cjS4sqiX/x43v4HBR/sXaXdznlh4/0ccX0+SdxED/hTZFiL4N94veJ8fM4CNDZXLitpRRCNZK4f6k7OIFqMNpxSR2CG4I55tKUQsfPcOUvptEfojKE1B4NTiUnyIMgMhxgIABKSz3GpeeJ1SIa17k/6Dvgit6Le6vW2yymsiSYIDiHShVmWU9GRM2Lf70isQKSt802jKqOdDIqgK2cEIZo1bZPSS8BeaQ5ap/fZ6XPN6Fhmsj943yZ9DGQBteuv6KRdjcv5ixlEKrahVkQMpVhJ84xnR9CIiPoWRhxgqe5uvorazWDRuTlU1Uv2PID3nl/QGcbLX9/zv8lu/qb"
}

# 7. THE ENGINE: Fetch Latest Linux AMI
data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

# 8. THE SERVER: Spin up EC2 inside the network with Apache installation
resource "aws_instance" "web_server" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to the Apache Server hosted on AWS By Navyakanth !</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = { Name = "evolution-web-server" }
}