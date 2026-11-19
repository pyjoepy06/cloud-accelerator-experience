# Week 3: Two EC2 instances, no modules, loops, locals, count, or input variables.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_password" "mysql" {
  length = 24
  special = false
}

resource "aws_security_group" "web" {
  name = "week3-web-app-sg"
  description = "HTTP to class web application"
  vpc_id = aws_vpc.class_vpc.id
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "week3-web-app-sg" }
}

resource "aws_security_group" "db" {
  name = "week3-db-sg"
  description = "MySQL from web application only"
  vpc_id = aws_vpc.class_vpc.id
  ingress {
    description = "MySQL from application"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.web.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "week3-db-sg" }
}

resource "aws_instance" "db" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.db_subnet.id
  vpc_security_group_ids = [aws_security_group.db.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
  user_data = templatefile("${path.module}/db-user-data.sh.tftpl", {
    db_password = random_password.mysql.result
  })
  user_data_replace_on_change = true
  tags = { Name = "week3-db-server" }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name
  user_data = templatefile("${path.module}/web-user-data.sh.tftpl", {
    db_host = aws_instance.db.private_ip
    db_password = random_password.mysql.result
  })
  user_data_replace_on_change = true
  tags = { Name = "week3-web-app-server" }
}

output "web_url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "mysql_password" {
  value = random_password.mysql.result
  sensitive = true
}
