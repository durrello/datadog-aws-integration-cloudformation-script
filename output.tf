
# Outputs
output "bucket_name" {
  value = module.s3_bucket.bucket_name
}

output "stack_id" {
  value = module.cloudformation.stack_id
}