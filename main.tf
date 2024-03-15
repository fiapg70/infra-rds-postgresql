provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "rdssubnet" {
  name       = "rdssubnet"
  subnet_ids = ["subnet-07f6357a47a7bab23", "subnet-00c269ae8f0e56f80", "subnet-050a66c2d1035fd67", "subnet-0591ff8243d99c9a8", "subnet-0506f725026e430fc", "subnet-08923de2d5e058b7c", "subnet-07de2318b77347bc7"]
  tags = {
    Name = "rdssubnet"
  }
}

resource "aws_security_group" "rdssecurity" {
  name        = "rdssecuritygroup"
  description = "Example security group for RDS"
  vpc_id      = "vpc-0776a67e8b94ed8f1"

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name = "rdssecurity"
  }
}

resource "aws_db_instance" "rds-sevenfood" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.r6g.large"
  identifier           = "rds-sevenfood"
  username             = "postgres"
  password             = "Postgres2019!"
  db_subnet_group_name = aws_db_subnet_group.rdssubnet.name
  vpc_security_group_ids = [aws_security_group.rdssecurity.id]
  skip_final_snapshot  = true
  publicly_accessible  = false

  tags = {
    Name = "rds-sevenfood"
  }
}
