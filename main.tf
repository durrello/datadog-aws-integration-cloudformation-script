# S3 Bucket Module
module "s3_bucket" {
  source      = "./cloudformation/s3-bucket"
  bucket_name = var.bucket_name
}

# CloudFormation Module
module "cloudformation" {
  source       = "./cloudformation"
  stack_name   = var.stack_name
  template_url = module.s3_bucket.template_url

  depends_on = [module.s3_bucket]
}