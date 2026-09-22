output "aws_account_id" {
  description = "Current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "name_prefix" {
  description = "Standard resource naming prefix"
  value       = local.name_prefix
}
