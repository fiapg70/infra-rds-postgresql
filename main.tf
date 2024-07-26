# Security Group para RDS
resource "aws_security_group" "rds_sg" {
  name   = var.rds_security_group_name
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_security_group_name
  }
}

# Subnet Group para RDS
resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "Main DB subnet group"
  }
}

# Banco de Dados RDS Postgres
resource "aws_db_instance" "default" {
  identifier              = var.db_identifier
  engine                  = var.db_engine
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name

  tags = {
    Name = "PostgresDB"
  }
}
