resource "aws_ssm_parameter" "secret_db_endpoint" {
  name        = "/${var.task_id}/database/endpoint"
  type        = "SecureString"
  value       = var.database_endpoint
}

resource "aws_ssm_parameter" "secret_db_username" {
  name        = "/${var.task_id}/database/username"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_username
}

resource "aws_ssm_parameter" "secret_db_password" {
  name        = "/${var.task_id}/database/password"
  type        = "SecureString"
  value       = var.database_password
}