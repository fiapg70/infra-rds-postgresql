output "rds_sg_id" {
  description = "ID of the RDS Security Group"
  value       = aws_security_group.rds_sg.id
}

output "db_instance_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.default.endpoint
}

output "db_instance_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.default.id
}
