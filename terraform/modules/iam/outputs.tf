output "kops_user_arn" {
  description = "Kops IAM user ARN"
  value       = aws_iam_user.kops.arn
}

output "kops_access_key_id" {
  description = "Kops IAM access key ID"
  value       = aws_iam_access_key.kops.id
  sensitive   = true
}

output "kops_secret_access_key" {
  description = "Kops IAM secret access key"
  value       = aws_iam_access_key.kops.secret
  sensitive   = true
}
