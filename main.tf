locals {
  postgres_identifier    = "rds-sevenfood"
  postgres_database      = "sevenfood"
  postgres_owner         = "postgres"
  postgres_name          = "postgres"
  postgres_db_username   = "postgres"
  postgres_user_name     = "sevenuser"
  postgres_user_password = "Postgres2019!"
  postgres_instance_name = "rds-sevenfood"
  postgres_db_password   = "Postgres2019!"
  postgres_port          = "5432"
}

terraform {
  required_version = ">= 1.1.6"
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.22.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "postgresql" {
  host            = aws_db_instance.rds-sevenfood.address
  port            = local.postgres_port
  database        = local.postgres_name
  username        = local.postgres_db_username
  password        = local.postgres_user_password
  sslmode         = "require"
  connect_timeout = 15
  superuser       = false
  expected_version = aws_db_instance.rds-sevenfood.engine_version
}

# Referenciar a VPC existente
data "aws_vpc" "existing_vpc" {
  id = "vpc-e7de3280"
}

# Referenciar subnets existentes
data "aws_subnet" "subnet_1" {
  id = "subnet-c2cc50e8"
}

data "aws_subnet" "subnet_2" {
  id = "subnet-5e7f3028"
}

data "aws_security_group" "existing_sg" {
  id = "sg-xxxxxxxx" # Substitua pelo ID do seu Security Group existente
}

resource "aws_db_subnet_group" "rdssubnet" {
  name       = "rdssubnet"
  subnet_ids = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
  tags = {
    Name = "rdssubnet"
  }
}

resource "aws_db_instance" "rds-sevenfood" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.r6g.large"
  identifier           = local.postgres_identifier
  username             = local.postgres_db_username
  password             = local.postgres_user_password
  db_subnet_group_name = aws_db_subnet_group.rdssubnet.name
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = true
  tags = {
    Name = "rds-sevenfood"
  }
}

resource "postgresql_database" "sevenfood-database" {
  name              = local.postgres_database
  owner             = local.postgres_owner
  lc_collate        = "en_US.UTF-8"
  connection_limit  = -1 # sem limite. Ajuste conforme necessário
  allow_connections = true
  template          = "template0" # ou "template1", dependendo da sua necessidade
}
