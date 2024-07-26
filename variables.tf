variable "vpc_id" {
  description = "The ID of the VPC where the RDS will be deployed"
  default     = "10.0.0.0/16"
}

variable "rds_subnet_ids" {
  description = "The IDs of the subnets for the RDS subnet group"
  type        = list(string)
  default     = ["subnet-05ff19c24395444ba", "subnet-0febb4e9413d1c23a"]
}

variable "db_identifier" {
  description = "The identifier for the RDS instance"
  default     = "healthmeddb"
}

variable "db_engine" {
  description = "The database engine for the RDS instance"
  default     = "postgres"
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  default     = "db.t2.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS instance (in GB)"
  default     = 20
}

variable "db_name" {
  description = "The name of the database"
  default     = "healthmeddb"
}

variable "db_username" {
  description = "The master username for the RDS instance"
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
  default     = "Postgres2019!"
}

variable "rds_security_group_name" {
  description = "The name of the security group for the RDS instance"
  default     = "rds-sg"
}

variable "ec2_security_group_id" {
  description = "The ID of the EC2 security group that can access the RDS instance"
}