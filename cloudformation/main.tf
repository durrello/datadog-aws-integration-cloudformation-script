variable "stack_name" {
  description = "Name of the CloudFormation stack"
  type        = string
}

variable "template_url" {
  description = "S3 URL of the CloudFormation template"
  type        = string
}

# CloudFormation Stack
resource "aws_cloudformation_stack" "stack" {
  name         = var.stack_name
  template_url = var.template_url

  capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_NAMED_IAM"
  ]

  timeout_in_minutes = 30
}

# Get stack outputs
data "aws_cloudformation_stack" "stack_outputs" {
  name = aws_cloudformation_stack.stack.name
}

# Outputs
output "stack_id" {
  description = "CloudFormation stack ID"
  value       = aws_cloudformation_stack.stack.id
}
