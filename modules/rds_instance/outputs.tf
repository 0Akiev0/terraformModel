output "rds_endpoint"{
  value = aws_db_instance.this.endpoint
  description = "The endpoint of the RDS instance"
}

output "db_instance_id"{
  value = aws_db_instance.this.id
  description = "The ID of the RDS instance"
}
