
# Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "stack_name" {
  description = "CloudFormation stack name"
  type        = string
  default     = "my-stack"
}

variable "bucket_name" {
  description = "S3 bucket name for CloudFormation templates"
  type        = string
  default     = "my-cf-templates-bucket"
}

variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
}

variable "datadog_app_key" {
  description = "Datadog APP key"
  type        = string
}