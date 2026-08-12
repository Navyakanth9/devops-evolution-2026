
# 1. THE BOUNDARY: Create the VPC

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames   = true

  tags = { Name = var.project_tags["Name"] }
}

#  The Room: Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = { Name = var.project_tags["Name"] }
}

# 3. The front door: Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = { Name = var.project_tags["Name"] }
}
# 4. The path: Create Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }
  tags = { Name = var.project_tags["Name"] }
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
  tags = { Name = var.project_tags["Name"] }
}

# 6. THE AUTHENTICATION: Import your existing local Laptop PEM Key
resource "aws_key_pair" "my_key" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path) 
}

# 7. THE ENGINE: Fetch Latest Linux AMI
data "aws_ssm_parameter" "amazon_linux_2023" {
  name = var.data_ssm_value
}

# 8. THE SERVER: Spin up EC2 inside the network with Apache installation
resource "aws_instance" "web_server" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.my_key.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data_base64    = filebase64(var.script_path)

  tags = { Name = var.project_tags["Name"] }
}