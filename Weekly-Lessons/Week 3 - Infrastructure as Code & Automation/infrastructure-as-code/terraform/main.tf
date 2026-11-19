# WEEK 3: BEGINNER THREE-TIER AWS INFRASTRUCTURE
# All values are written directly in this file on purpose.
# No variables, locals, count, for_each, or modules.

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

# Use the current Amazon Linux 2023 AMI in us-east-1.
# This is a lookup, not a Terraform input variable.
data "aws_ssm_parameter" "amazon_linux_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# ONE VPC
resource "aws_vpc" "class_vpc" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "week3-class-vpc"
  }
}

# THREE SUBNETS
resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.class_vpc.id
  cidr_block              = "10.30.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "week3-web-public"
  }
}

resource "aws_subnet" "app_subnet" {
  vpc_id            = aws_vpc.class_vpc.id
  cidr_block        = "10.30.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "week3-app-private"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id            = aws_vpc.class_vpc.id
  cidr_block        = "10.30.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "week3-db-private"
  }
}

# ONE INTERNET GATEWAY
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.class_vpc.id

  tags = {
    Name = "week3-internet-gateway"
  }
}

# THREE ROUTE TABLES
resource "aws_route_table" "web_route_table" {
  vpc_id = aws_vpc.class_vpc.id

  tags = {
    Name = "week3-web-route-table"
  }
}

resource "aws_route_table" "app_route_table" {
  vpc_id = aws_vpc.class_vpc.id

  tags = {
    Name = "week3-app-route-table"
  }
}

resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.class_vpc.id

  tags = {
    Name = "week3-db-route-table"
  }
}

# Only the public web tier can route to the internet.
resource "aws_route" "web_internet_route" {
  route_table_id         = aws_route_table.web_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# THREE EXPLICIT ROUTE TABLE ASSOCIATIONS
resource "aws_route_table_association" "web_association" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_route_table.id
}

resource "aws_route_table_association" "app_association" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_route_table.id
}

resource "aws_route_table_association" "db_association" {
  subnet_id      = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.db_route_table.id
}

# THREE SECURITY GROUPS
# Web: HTTP from the internet (classroom demo only).
resource "aws_security_group" "web_security_group" {
  name        = "week3-web-sg"
  description = "HTTP access to web tier"
  vpc_id      = aws_vpc.class_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "week3-web-sg"
  }
}

# App: port 8080 from web security group only.
resource "aws_security_group" "app_security_group" {
  name        = "week3-app-sg"
  description = "Application access from web tier"
  vpc_id      = aws_vpc.class_vpc.id

  ingress {
    description     = "App from web"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "week3-app-sg"
  }
}

# Database: port 3306 from app security group only.
resource "aws_security_group" "db_security_group" {
  name        = "week3-db-sg"
  description = "Database access from application tier"
  vpc_id      = aws_vpc.class_vpc.id

  ingress {
    description     = "Database from app"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "week3-db-sg"
  }
}

# THREE EC2 INSTANCES (no software is installed)
resource "aws_instance" "web_server" {
  ami                    = data.aws_ssm_parameter.amazon_linux_ami.value
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.web_subnet.id
  vpc_security_group_ids = [aws_security_group.web_security_group.id]

  tags = {
    Name = "week3-web-server"
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ssm_parameter.amazon_linux_ami.value
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.app_security_group.id]

  tags = {
    Name = "week3-app-server"
  }
}

resource "aws_instance" "db_server" {
  ami                    = data.aws_ssm_parameter.amazon_linux_ami.value
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.db_subnet.id
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  tags = {
    Name = "week3-db-server"
  }
}
