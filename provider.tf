terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.69"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

provider "aws" {
  region = var.aws_region
}