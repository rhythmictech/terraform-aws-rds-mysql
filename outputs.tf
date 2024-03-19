output "address" {
  description = "RDS database address"
  value       = aws_db_instance.this.address
}

output "instance_connection_info" {
  description = "Object containing connection info"
  value = {
    address  = aws_db_instance.this.address
    endpoint = aws_db_instance.this.endpoint
    id       = aws_db_instance.this.id
    port     = aws_db_instance.this.port
    username = aws_db_instance.this.username
  }
}

output "instance_id" {
  description = "Instance `identifier` NOT `id` of RDS DB. For backwards compatibility. See [change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/version-5-upgrade#aws_db_instanceid-is-no-longer-the-identifier)"
  value       = aws_db_instance.this.identifier
}
output "password_secret_arn" {
  description = "Password secret ARN"
  value       = local.create_password_secret ? module.password.secret_arn : null
}

output "password_secret_version_id" {
  description = "Password secret version"
  value       = local.create_password_secret ? module.password.version_id : null
}

output "username" {
  description = "Master username"
  value       = aws_db_instance.this.username
}
