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
  cidr_block              = "10.30.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "week3-app-lab-public"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id            = aws_vpc.class_vpc.id
  cidr_block              = "10.30.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "week3-db-lab-public"
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

# All three subnets have internet routes for this low-cost classroom bootstrap.
resource "aws_route" "web_internet_route" {
  route_table_id         = aws_route_table.web_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

# Classroom-only internet routes for apt package installation.
resource "aws_route" "app_internet_route" {
  route_table_id = aws_route_table.app_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}
resource "aws_route" "db_internet_route" {
  route_table_id = aws_route_table.db_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
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

# The EC2 instances and security groups are defined in servers.tf.
