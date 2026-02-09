output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "rds_password_secret_arn" {
  value = aws_db_instance.postgres.master_user_secret[0].secret_arn
}
