variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

# S3 Bucket for CloudFormation templates
resource "aws_s3_bucket" "cf_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "cf_bucket_versioning" {
  bucket = aws_s3_bucket.cf_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cf_bucket_encryption" {
  bucket = aws_s3_bucket.cf_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Upload CloudFormation template to S3
resource "aws_s3_object" "cf_template" {
  bucket = aws_s3_bucket.cf_bucket.id
  key    = "cloudformation-template.yaml"
  source = "${path.module}/cloudformation-template.yaml"
  etag   = filemd5("${path.module}/cloudformation-template.yaml")
}

# Outputs
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.cf_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.cf_bucket.arn
}

output "template_url" {
  description = "S3 URL of the CloudFormation template"
  value       = "https://${aws_s3_bucket.cf_bucket.bucket}.s3.amazonaws.com/${aws_s3_object.cf_template.key}"
}