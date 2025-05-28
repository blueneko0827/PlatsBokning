provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-north-1a"
  cidr_block = "10.0.11.0/24"
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-north-1b"
  cidr_block = "10.0.12.0/24"
}

# Internet Gateway and Routing
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Groups
resource "aws_security_group" "rails_sg" {
  name        = "rails_sg"
  description = "Allow SSH and Rails HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.rails_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "rails-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id]

  tags = {
    Name = "Rails DB subnet group"
  }
}

# RDS Instance
resource "aws_db_instance" "rails_db" {
  identifier              = "railsdb"
  engine                  = "postgres"
  engine_version          = "17.4"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false

  tags = {
    Name = "RailsPostgresDB"
  }
}

# EC2 User Data Template
data "template_file" "ec2_userdata" {
  template = file("${path.module}/ec2-userdata.sh")

  vars = {
    db_host     = aws_db_instance.rails_db.address
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password
  }
}

# EC2 Spot Instance
resource "aws_instance" "rails_server" {
  ami                         = "ami-051561e0bf48efb5a" # Ubuntu eu-north-1
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.rails_sg.id]
  user_data                   = data.template_file.ec2_userdata.rendered
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.02"
      spot_instance_type = "one-time"
    }
  }

  tags = {
    Name = "RailsAppEC2-Spot"
  }
}
