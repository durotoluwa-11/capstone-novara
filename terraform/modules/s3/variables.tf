variable "kops_state_bucket" {
  description = "S3 bucket for Kops state"
  type        = string
}

variable "terraform_state_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
}
