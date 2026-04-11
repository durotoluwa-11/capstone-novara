output "kops_state_bucket" {
  description = "Kops state store bucket name"
  value       = aws_s3_bucket.kops_state.bucket
}

output "terraform_state_bucket" {
  description = "Terraform state store bucket name"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  value       = aws_dynamodb_table.terraform_state_lock.name
}
